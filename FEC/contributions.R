library(rio)
library(data.table)
library(dplyr)
library(tidyr)

#######################
###### Build master candidate file
########################
# load individual files
get_candidateinfo <- function(year){
  filename <- paste0("raw/cn", year, ".txt")
  candidates <- import(filename)
  names(candidates) <- c("cand_id", "cand_name", "cand_pty_affiliation", "cand_election_yr", 
                         "cand_office_st", "cand_office", "cand_office_district", "cand_ici", 
                         "cand_status", "cand_pcc", "cand_st1", "cand_st2", "cand_city", 
                         "cand_st", "cand_zip")
  return(candidates)
}
cnlist <- list()
# row bind and drop duplicates
for (year in seq(1996, 2020, by=2)){
  cnlist[[as.character(year)]] <- get_candidateinfo(year)
}
cn_rel <- rbindlist(cnlist)
cn_rel <- cn_rel %>%
  arrange(desc(cand_election_yr)) %>% 
  distinct(cand_id, cand_election_yr, .keep_all = TRUE) %>%
  arrange(cand_id)

# FILTERING
# keep only relevant variables
cn_rel <- cn_rel %>% 
  select(cand_id, cand_name, cand_pty_affiliation, cand_election_yr, 
         cand_office_st, cand_office)
# keep only relevant election years (range: 1998-2022)
#   note: years outside this range exist because of 
#         lingering committees or early starters
cn_rel <- cn_rel %>% 
  filter(cand_election_yr >= 1996 & cand_election_yr <= 2022)
# keep only democratic and republican candidates
n_prev <- nrow(cn_rel)
cn_rel <- cn_rel %>% 
  filter(cand_pty_affiliation %in% c("DEM","REP"))
n_after <- nrow(cn_rel)
print(paste0("Candidates for other parties: ", n_prev - n_after))
# for presidentials, keep only primary winners
# b/c including other candidates would inflate (intra-party conflict)
# e.g. Bernie Sanders -> did not translate to Democratic votes
# 1996: Clinton vs Dole
# 2000: Gore vs Bush
# 2004: Kerry vs Bush
# 2008: Obama vs McCain
# 2012: Obama vs Romney
# 2016: Clinton vs Trump
# 2020: Biden vs Trump
# [TODO] manual checking of ids
presidentialprimaries <- data.frame(
  cand_id = c(
    "P20000642", # Clinton, Bill
    "P00000489", # Dole
    "P80000912", # Gore
    "P00003335", # Bush
    "P80000235", # Kerry
    "P00003335", # Bush
    "P80003338", # Obama
    "P80002801", # McCain
    "P80003338", # Obama
    "P80003353", # Romney
    "P00003392", # Clinton, Hillary
    "P80001571", # Trump
    "P80000722", # Biden
    "P80001571" # Trump
  ),
  cand_election_yr = c(
    1996, 1996,
    2000, 2000, 
    2004, 2004,
    2008, 2008,
    2012, 2012,
    2016, 2016,
    2020, 2020
  )
)
cn_pres <- cn_rel %>% 
  filter(cand_office == "P") %>% 
  inner_join(
    presidentialprimaries, 
    by = c("cand_id", "cand_election_yr")
  )
cn_rel <- rbind(
  cn_rel %>% filter(cand_office != "P"), 
  cn_pres
)
print(paste0("Final candidates for DEM: ", sum(cn_rel$cand_pty_affiliation=="DEM")))
print(paste0("Final candidates for REP: ", sum(cn_rel$cand_pty_affiliation=="REP")))
export(cn_rel, "candidates_master.csv")
rm(cn_rel)

######################################################################
############ PRESIDENTIALS ####################################
########################################################

presyears <- c(1996, 2000, 2004, 2008, 2012, 2016, 2020)

##############################
##### Presidential candidates 
###############################
cn_pres <- import("candidates_master.csv") %>% 
  filter(cand_office == "P") %>% 
  arrange(cand_election_yr)

list_pres_candidates <- list()
for (year in presyears){
  list_pres_candidates[[as.character(year)]] <- cn_pres %>%
    filter(cand_election_yr == year) %>% 
    select(cand_id, cand_name, cand_pty_affiliation) %>% 
    mutate(
      cand_lastname = sub(",.*", "", cand_name),
      cand_firstname = sub("^\\s*(\\w+).*", "\\1", sub(".*,", "", cand_name))
    )
}


##########################
##### Build unofficial committee-candidate links
###########################
pas2_headers <- fread(
  "raw/pas2_header_file.csv", 
  sep = ",", header = FALSE, quote = "") %>% 
  as.character()
  
get_expenditures <- function(year){
  filename <- paste0("raw/itpas2", year, ".txt")
  expenditures <- fread(filename, sep = "|", header = FALSE, quote = "")
  names(expenditures) <- tolower(pas2_headers)
  return(expenditures)
}

list_pres_inexps <- list()
list_unofflinks <- list()

checkdf <- get_expenditures(2016) %>% 
  filter(cmte_id == "C00618876")

for (year in presyears){
  pas2 <- get_expenditures(year)
  # filter for valid transactions
  # cf: should NOT filter by amndt_ind (no duplicates by default)
  # 1) transaction_tp: supporting / against
  # 24 except 24G (internal bookkeeping), 24H (honorarium)
  # plus 22H (loans to candidate)
  # mostly supporting except 24A and 24N (opposition)
  pas2 <- pas2 %>% 
    filter(
      transaction_tp %in% c(
        "24E", "24K", "24C", "24Z", "24F", 
        "24I", "24T", "24P", "22H", "24A", "24N"
      )) %>% 
    mutate(
      isfor = ifelse(
        transaction_tp %in% c("24A", "24N"), 
        FALSE, TRUE
      )
    )
  # 2) transaction_amt: nonmissing, > 0
  pas2 <- pas2 %>% 
    filter(!is.na(transaction_amt) & transaction_amt > 0)
  # 3) CAND_ID: presidential recipient
  pas2 <- pas2 %>% 
    inner_join(
      list_pres_candidates[[as.character(year)]],
      by = "cand_id"
    )
  
  # keep necessary columns
  pas2 <- pas2 %>% 
    select(cmte_id, isfor, transaction_tp, transaction_amt,
           cand_id, cand_name, cand_pty_affiliation)
  
  # save to list
  list_pres_inexps[[as.character(year)]] <- pas2
  
  # aggregate by committee x party
  # by: cmte_id, cand_pty_affiliation
  # 1) for_n : number of rows with expenditure for
  # 2) for_sum : sum(transaction_amt) of expenditures for
  # 3) agt_n : number of rows with expenditure against
  # 4) agt_sum : sum(transaction_amt) of expenditures against
  pas2_agg <- pas2 %>% 
    group_by(cmte_id, cand_pty_affiliation) %>% 
    summarise(
      for_n = sum(isfor),
      for_sum = sum(ifelse(isfor, transaction_amt, 0)),
      agt_n = sum(!isfor),
      agt_sum = sum(ifelse(!isfor, transaction_amt, 0))
    ) %>% 
    ungroup()
  # aggregate to a single row per committee
  # rightness_n = (n(for REP) + n(agt DEM)) 
  #       / (n(for REP) + n(agt DEM) + n(for DEM) + n(agt REP)))
  # rightness_sum = (sum(for REP) + sum(agt DEM))
  #       / (sum(for REP) + sum(agt DEM) + sum(for DEM) + sum(agt REP)))
  # then scale to (0,1) -> (-1,1) where 1 is most pro-REP and -1 is most pro-DEM
  pas2_agg_rightness <- pas2_agg %>% 
    group_by(cmte_id) %>% 
    summarise(
      rightness_n = (sum(for_n[cand_pty_affiliation == "REP"]) + sum(agt_n[cand_pty_affiliation == "DEM"])) / 
        (sum(for_n) + sum(agt_n)),
      rightness_sum = (sum(for_sum[cand_pty_affiliation == "REP"]) + sum(agt_sum[cand_pty_affiliation == "DEM"])) / 
        (sum(for_sum) + sum(agt_sum))
    ) %>%
    ungroup() %>% 
    mutate(
      rightness_n = 2 * rightness_n - 1,
      rightness_sum = 2 * rightness_sum - 1
    )
  
  # save
  list_unofflinks[[as.character(year)]] <- pas2_agg_rightness
  
}



########################
###### Baseline screen on committees
########################
# load committee information
get_committeeinfo <- function(year){
  filename <- paste0("raw/cm", year, ".txt")
  committees <- import(filename)
  names(committees) <- c("cmte_id","cmte_nm","tres_nm","cmte_st1","cmte_st2","cmte_city","cmte_st","cmte_zip","cmte_dsgn","cmte_tp","cmte_pty_affiliation",
                         "cmte_filing_freq","org_tp","connected_org_nm","cand_id")
  cmte_dsgn_codes <- data.frame(cmte_dsgn = c("A","B","D","J","P","U"), cmte_dsgn_lab = c("Authorized by candidate","Lobbyist/PAC","Leadership PAC","Joint fundraiser","Principal","Unauthorized"))
  cmte_tp_codes <- data.frame(cmte_tp = c("C","D","E","H","I","N","O","P","Q","S","U","V","W","X","Y","Z"),
                              cmte_tp_lab = c("Communcation Cost","Delegate Committee","Electioneering Communcation","House","Independent Expenditor",
                                              "PAC - Nonqual", "Super PAC", "Presidential", "PAC - Qual","Senate","Single Cand Indep Exp","PAC w/ Non-Contrib - Nonqual",
                                              "PAC w/ Non-Contrib - Qual","Party - Nonqual","Party - Qual", "National Party Nonfed Account"))
  committees <- merge(committees, cmte_dsgn_codes, by="cmte_dsgn")
  committees <- merge(committees, cmte_tp_codes, by="cmte_tp")
  rm(cmte_dsgn_codes, cmte_tp_codes)
  committees <- committees %>% 
    select(cmte_id, cmte_nm, cmte_dsgn, cmte_dsgn_lab, cmte_tp, cmte_tp_lab, cmte_pty_affiliation, cand_id)
  return(committees)
}

list_comm_1 <- list()

for (year in presyears){
  cm_year<- get_committeeinfo(year)
  
  # merge unofficial links
  cm_year <- cm_year %>% 
    left_join(
      list_unofflinks[[as.character(year)]], 
      by = "cmte_id"
    )
  
  # merge candidate information for official links
  cm_year <- cm_year %>%
    left_join(
      list_pres_candidates[[as.character(year)]] %>% 
        select(cand_id, cand_pty_affiliation),
      by = "cand_id"
    )
  
  
  
  # screening: result to final_cm_pty
  # values:
  # DEM: included as "democratic" committee
  # REP: included as "republican" committee
  # EXC: excluded definitively
  # IND: indeterminate
  
  # criteria:
  
  # 1) committee type: 
  # EXC: 
    # C, E, I: non-committees
    # D: presidential primary
    # S: senate
    # H: house of representatives
  # IND:
    # N, O, Q, V, W: PACs (including hybrid PACs)
    # U: single-candidate supports, mostly senate but can be presidential
    # P: presidential
  # DEM/REP: 
    # X, Y, Z: party committees; use cmte_pty_affiliation variable
  cm_pres_year <- cm_year %>% 
    mutate(
      final_cm_pty = case_when(
        cmte_tp %in% c("C","D","E","H","I","S") ~ "EXC",
        cmte_tp %in% c("N","O","P","Q","U","V","W") ~ "IND",
        cmte_tp %in% c("X", "Y", "Z") ~ ifelse(
          cmte_pty_affiliation == "DEM", "DEM", 
          ifelse(cmte_pty_affiliation == "REP", "REP", 
                 "EXC") # "UNK" or other party codes
        ),
        TRUE ~ "IND"
      )
    )
    
  # 2) official links
  # DEM/REP:
  # if officially linked by cand_id to a candidate in the presidential election, 
  # then include as that party's committee
  # EXC:
  # if officially linked by cand_id to a different candidate
  # (e.g. senate, house, losing presidential)
  presidential_cand_ids <- list_pres_candidates[[as.character(year)]]$cand_id
  cm_pres_year <- cm_pres_year %>% 
    mutate(
      final_cm_pty = case_when(
        final_cm_pty != "IND" ~ final_cm_pty,
        cand_id %in% presidential_cand_ids ~ ifelse(
          cand_pty_affiliation == "DEM", "DEM", 
          ifelse(cand_pty_affiliation == "REP", "REP", "IND")
        ),
        !is.na(cand_id) & (cand_id != "") ~ "EXC",
        TRUE ~ final_cm_pty
      )
    )
  
  # 3) unofficial links
  # (rightness_n, rightness_sum) both le than -0.75 -> DEM
  # (rightness_n, rightness_sum) both ge than 0.75 -> REP
  cm_pres_year <- cm_pres_year %>% 
    mutate(
      final_cm_pty = case_when(
        final_cm_pty != "IND" ~ final_cm_pty,
        !is.na(rightness_n) & rightness_n <= -0.75 & rightness_sum <= -0.75 ~ "DEM",
        !is.na(rightness_n) & rightness_n >= 0.75 & rightness_sum >= 0.75 ~ "REP",
        TRUE ~ final_cm_pty
      )
    )
  
  # 4) keyword targeting
  # presidential candidate last name
  # party keywords for federal party organizations
  dem_keywords <- c(list_pres_candidates[[as.character(year)]] 
                    %>% filter(cand_pty_affiliation == "DEM") 
                    %>% pull(cand_lastname),
                    "DNC", "DSCC", "DCCC", "DCCCC", "DCCCE",
                    "DEMOCRATIC", "DEMOCRAT", "DEMOCRATS",
                    "SENATE MAJORITY PAC", 'HOUSE MAJORITY PAC')
  
  rep_keywords <- c(list_pres_candidates[[as.character(year)]] 
                    %>% filter(cand_pty_affiliation == "REP") 
                    %>% pull(cand_lastname),
                    "RNC", "NRSC", "NRCC", "NRCCC", "NRCCE",
                    "REPUBLICAN", "REPUBLICANS", "GOP", "GOPAC",
                    "CONGRESSIONAL LEADERSHIP FUND", "SENATE LEADERSHIP FUND",
                    "REP S/H DINNER", "REP H/S DINNER")
  
  cm_pres_year <- cm_pres_year %>%
    mutate(
      final_cm_pty = case_when(
        final_cm_pty != "IND" ~ final_cm_pty,
        grepl(paste(paste0("\\b", dem_keywords, "\\b"), collapse = "|"), 
              cmte_nm, ignore.case = TRUE) ~ "DEM",
        grepl(paste(paste0("\\b", rep_keywords, "\\b"), collapse = "|"), 
              cmte_nm, ignore.case = TRUE) ~ "REP",
        TRUE ~ final_cm_pty
      )
    )

  
  
  # save
  list_comm_1[[as.character(year)]] <- cm_pres_year
}

# check
# cm_year_actualselected <- cm_pres_year %>% 
#   filter(cmte_id %in% c(
#     "C00586537",
#     "C00575795",
#     "C00495861",
#     "C00618389",
#     "C00547349",
#     "C00003418",
#     "C00571703",
#     "C00000935",
#     "C00618371",
#     "C00042366",
#     "C00484642",
#     "C00580100",
#     "C00027466",
#     "C00619411",
#     "C00504530",
#     "C00010603",
#     "C00495028",
#     "C00574533",
#     "C00618876",
#     "C00075820",
#     "C00575373"
#   ))
# 

rm(list_unofflinks)


########################
###### Secondary committee selection using indiv contribution data
########################

# read only necessary columns for speed and memory efficiency
itcont_headers <- fread(
  "raw/indiv_header_file.csv", 
  sep = ",", header = FALSE, quote = "") %>% 
  as.character() %>% tolower()
cols_to_keep <- c("cmte_id", "transaction_pgi", "transaction_tp", "entity_tp", 
                  "name", "state", "zip_code", "transaction_dt", "transaction_amt", 
                  "other_id", "sub_id")
cols_indices <- match(cols_to_keep, itcont_headers)

# function for importing and cleaning individual contributions
get_indivconts <- function(year, colidx = cols_indices){
  # read data
  indiv_contrib_data <- fread(
    paste0("raw/itcont", year, ".txt"), 
    sep = "|", 
    select = colidx,
    col.names = cols_to_keep,
    quote = ""
  )
  
  # keep only valid transactions
  indiv_contrib_data <- indiv_contrib_data %>% 
    filter(transaction_tp %in% c("10","11","15","15E","21Y","22Y"))
  indiv_contrib_data <- indiv_contrib_data %>%
    filter(entity_tp == "IND" | is.na(entity_tp)) %>% 
    filter(is.na(other_id) | other_id == "") 
  # set refunds to negative values
  indiv_contrib_data[
    transaction_tp %in% c("21Y","22Y")
  ]$transaction_amt <- -abs(
    indiv_contrib_data[
      transaction_tp %in% c("21Y","22Y")]$transaction_amt)
  # keep rows with valid state
  indiv_contrib_data <- indiv_contrib_data %>%
    filter(state %in% c(state.abb, "DC"))
  
  return(indiv_contrib_data)
}

list_comm_2 <- list()
for (year in presyears){
  indiv_contrib_data <- get_indivconts(year)
  
  # aggregate sums by committee for secondary committee screening
  comit_contrib_data <- indiv_contrib_data %>% 
    group_by(cmte_id) %>% 
    summarise(
      tot_amt = sum(transaction_amt),
      n_trans = n(),
      n_trans_pos = sum(transaction_amt > 0),
    ) %>% 
    ungroup()
  # merge with preliminary screening result
  comit_contrib_data <- comit_contrib_data %>% 
    inner_join(
      list_comm_1[[as.character(year)]],
      by = "cmte_id"
    )
  # rankings and sort
  comit_contrib_data <- comit_contrib_data %>% 
    mutate(
      rank_tot = min_rank(desc(tot_amt)),
      rank_n = min_rank(desc(n_trans)),
      rank_n_pos = min_rank(desc(n_trans_pos))
    ) %>% 
    arrange(desc(tot_amt))
  
  # save
  list_comm_2[[as.character(year)]] <- comit_contrib_data
}

# merge as single dataframe and export as csv for manual screening
combined_dt <- rbindlist(list_comm_2, idcol = "year")
fwrite(combined_dt, "comm_for_manual_screening.csv")

rm(list_comm_1, list_comm_2)


# manual updates: up to the 100th rank by transaction amount per election year
# Updated manualupdater to accept and apply the override flag
manualupdater <- function(data, condition, new_value, override = FALSE){
  data %>% 
    mutate(
      final_cm_pty = case_when(
        override & {{condition}} ~ new_value,     # If override is TRUE, this forces the change immediately
        final_cm_pty != "IND" ~ final_cm_pty,     # Otherwise, preserve existing classifications
        {{condition}} ~ new_value,                # Apply new value if currently "IND"
        TRUE ~ final_cm_pty                       # Leave as is
      ) 
    )
}
combined_dt <- fread("comm_for_manual_screening.csv")



# include: candidate-related PACs
# year == 2016, cmte_nm contains HILLARY -> DEM
# year == 2008, cmte_nm == "COMMITTEE FOR CHANGE" -> DEM (Obama)
combined_dt <- combined_dt %>%
  manualupdater(year == 2016 & grepl("HILLARY", cmte_nm, ignore.case = TRUE), "DEM") %>%
  manualupdater(year == 2008 & cmte_nm == "COMMITTEE FOR CHANGE", "DEM")

# include: party supporting PACs w/ nonconventional names or extra buckets
# year == 2020, cmte_nm == "SMP" -> DEM (Senate Majority PAC) 
# year == 2020, cmte_nm == "TAKE BACK THE HOUSE 2020" -> REP
# year == 2020, cmte_nm == "SENATE GEORGIA BATTLEGROUND FUND" -> REP
# year == 2012, cmte_nm == "YG ACTION FUND" -> REP
combined_dt <- combined_dt %>%
  manualupdater(year == 2020 & cmte_nm == "SMP", "DEM") %>%
  manualupdater(year == 2020 & cmte_nm == "TAKE BACK THE HOUSE 2020", "REP") %>%
  manualupdater(year == 2020 & cmte_nm == "SENATE GEORGIA BATTLEGROUND FUND", "REP") %>%
  manualupdater(year == 2012 & cmte_nm == "YG ACTION FUND", "REP")

# exclude: well-known issue specifics
# cmte_nm == "ACTBLUE": conduit. already recorded in destination
# cmte_nm == "EMILY'S LIST": often reflects intra-Democratic party conflict
# year == 2020, cmte_nm == "FAIR FIGHT": voting rights PAC at state level
# cmte_nm == "ESAFUND": issue-specific conservative super PAC
# year == 2020, cmte_nm contains "AMERICANS FOR PROSPERITY ACTION"
# year == 2016, cmte_nm == "CLUB FOR GROWTH ACTION"
# year == 2004, cmte_nm == "AMERICA COMING TOGETHER"
combined_dt <- combined_dt %>%
  manualupdater(cmte_nm == "ACTBLUE", "EXC", override = TRUE) %>%
  manualupdater(cmte_nm == "EMILY'S LIST", "EXC", override = TRUE) %>%
  manualupdater(year == 2020 & cmte_nm == "FAIR FIGHT", "EXC", override = TRUE) %>%
  manualupdater(cmte_nm == "ESAFUND", "EXC", override = TRUE) %>%
  manualupdater(year == 2020 & grepl("AMERICANS FOR PROSPERITY ACTION", cmte_nm, ignore.case = TRUE), "EXC", override = TRUE) %>%
  manualupdater(year == 2016 & cmte_nm == "CLUB FOR GROWTH ACTION", "EXC", override = TRUE) %>% 
  manualupdater(year == 2004 & cmte_nm == "AMERICA COMING TOGETHER", "EXC", override = TRUE)

# exclude: non-final presidential candidates
# cmte_nm contains "HILL PAC": HIllary Clinton's Senator PAC
# year == 2012, cmte_nm == "INDEPENDENCE USA PAC": pro-gun across both sides
# year == 2016, cmte_nm == "UNINTIMIDATED PAC INC": Scott Walker
# year == 2016, cmte_name == "AMERICA LEADS": Chris Christie
# year == 2016, cmte_name contains "KEEP THE PROMISE": Ted Cruz
combined_dt <- combined_dt %>%
  manualupdater(grepl("HILL PAC", cmte_nm, ignore.case = TRUE), "EXC", override = TRUE) %>%
  manualupdater(year == 2012 & cmte_nm == "INDEPENDENCE USA PAC", "EXC", override = TRUE) %>%
  manualupdater(year == 2016 & cmte_nm == "UNINTIMIDATED PAC INC", "EXC", override = TRUE) %>%
  manualupdater(year == 2016 & cmte_nm == "AMERICA LEADS", "EXC", override = TRUE) %>%
  manualupdater(year == 2016 & grepl("KEEP THE PROMISE", cmte_nm, ignore.case = TRUE), "EXC", override = TRUE)

# exclude: profession-based lobbying groups
# cmte_nm contains "AUTOMOBILE DEALERS", "AUTOMOTIVE DEALERS"
# cmte_nm contains "BEER"
# cmte_nm contains "HOME BUILDERS", "REALTORS", "LAWYERS"
# cmte_nm contains "HOLLYWOOD", "ERNST & YOUNG", "DELOITTE"
# year == 2012, cmte_id == "C00528448"
combined_dt <- combined_dt %>%
  manualupdater(grepl("AUTOMOBILE DEALERS|AUTOMOTIVE DEALERS", cmte_nm, ignore.case = TRUE), "EXC", override = TRUE) %>%
  manualupdater(grepl("BEER", cmte_nm, ignore.case = TRUE), "EXC", override = TRUE) %>%
  manualupdater(grepl("HOME BUILDERS|REALTORS|LAWYERS", cmte_nm, ignore.case = TRUE), "EXC", override = TRUE) %>%
  manualupdater(grepl("HOLLYWOOD|ERNST & YOUNG|DELOITTE", cmte_nm, ignore.case = TRUE), "EXC", override = TRUE) %>%
  manualupdater(year == 2012 & cmte_id == "C00528448", "EXC", override = TRUE)

# exclude: other unclear groups
# year == 1996, cmte_id == "C60000866": NON-FEDERAL soft money pac but unclear which side
combined_dt <- combined_dt %>%
  manualupdater(year == 1996 & cmte_id == "C60000866", "EXC", override = TRUE)

# export selected committes: committee id, election year, party
export(
  combined_dt %>% 
    filter(final_cm_pty %in% c("DEM", "REP")) %>% 
    select(cmte_id, year, final_cm_pty) %>% 
    rename(cmte_election_year = year, cmte_party = final_cm_pty),
  "committees_selected.csv"
)
rm(combined_dt)

########################
###### Export sums by state for selected committees
########################

# function for importing and cleaning individual contributions
# get_indivconts: see section above for definition

### Selected committees
cmte_final <- import("committees_selected.csv")

list_bystate <- list()
for (year in presyears){
  indiv_contrib_data <- get_indivconts(year)
  
  # filter by selected committees
  indiv_contrib_data <- indiv_contrib_data %>% 
    inner_join(cmte_final %>% filter(cmte_election_year == year)
               , by = c("cmte_id"))
  
  # aggregate to state x cmte_election_year x cmte_party
  indiv_contrib_bystate <- indiv_contrib_data %>% 
    group_by(state, cmte_election_year, cmte_party) %>% 
    summarise(
      tot_amt = sum(transaction_amt),
      n_trans = n(),
      n_trans_pos = sum(transaction_amt > 0),
    ) %>% 
    ungroup() 
  
  # portion of REP vs DEM for state x cmte_election_year
  indiv_contrib_bystate_wide <- indiv_contrib_bystate %>% 
    pivot_wider(
      id_cols = c(state, cmte_election_year),
      names_from = cmte_party,
      values_from = c("tot_amt", "n_trans", "n_trans_pos")
    )
  indiv_contrib_bystate_wide <- indiv_contrib_bystate_wide %>% 
    mutate(
      tot_amt_rep_share = tot_amt_REP / (tot_amt_REP + tot_amt_DEM),
      n_trans_rep_share = n_trans_REP / (n_trans_REP + n_trans_DEM),
      n_trans_pos_rep_share = n_trans_pos_REP / (n_trans_pos_REP + n_trans_pos_DEM)
    ) %>% 
    mutate(
      STDIR_amt = tot_amt_rep_share * 2 - 1,
      STDIR_n = n_trans_rep_share * 2 -1,
      STDIR_npos = n_trans_pos_rep_share * 2 - 1
    )
  
  list_bystate [[as.character(year)]] <- indiv_contrib_bystate_wide %>% 
    select(state, cmte_election_year, STDIR_amt, STDIR_n, STDIR_npos) %>% 
    rename(year = cmte_election_year)
}

STDIR <- rbindlist(list_bystate)
export(STDIR, "STDIR_pres.csv")
