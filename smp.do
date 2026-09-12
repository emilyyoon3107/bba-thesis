*********************************************
**# ===DATASET CONSTRUCTION====
***************************************
*===================================
**# PSID
*=====================================
use "./PSID/J362369.dta", clear
*-----------------------------------------------
* Y varibles
* 1) stockhold
assert wthstckimptf == 1 | wthstckimptf == 0
gen stockhold = cond(wthstckimptf == 1, 1, 0) 
sum stockhold // 111,759 obs, mean 0.1525 (15.25% SMP rate)
// wthstckimptfacc == 1: 599 out of 111,759 obs
* 2) stockshare
// financial assets = cash(+checkings, savings) + bonds(+CD, t-bill) + stocks
// -2017: cash + bonds => wthcashbondimpval
// 2019-: cash => wthcashimpval; bond => wthbondimpval
assert !missing(wthcashbondimpval) | (year>=2019)
gen finassets = .
replace finassets = wthcashbondimpval + wthstckimpval if year <= 2017
replace finassets = wthcashimpval + wthbondimpval + wthstckimpval if year >= 2019
assert !missing(finassets)
gen stockshare = .
replace stockshare = wthstckimpval / finassets if (wthstckimpval >= 0) & (finassets > 0)
replace stockshare = 1 if !missing(stockshare) & stockshare > 1 // 3 real changes made
sum stockshare // 81,980 obs
* 3) stockholdtot
// direct holding: stockhold binary
// ira/annuity holding: 1 is mostly stocks, 2 is mostly interest-bearing, 3 is split
	// retirementalloc == 1 | retirementalloc == 3
// pension plan holding: 1 is mostly stocks, 2 is some of each, 3 is mostly interest-bearing
	// pensionallochd == 1 | pensionallochd == 2 | pensionallocsp == 1 | pensionallocsp == 2
gen stockhold_ira = cond(retirementalloc == 1 | retirementalloc == 3, 1, 0)
gen stockhold_pen = cond(pensionallochd == 1 | pensionallochd == 2 | pensionallocsp == 1 | pensionallocsp == 2, 1, 0)
gen stockhold_tot = stockhold == 1 | stockhold_ira == 1 | stockhold_pen == 1
sum stockhold_ira // 111,759 obs, mean 0.1627 (16.27% SMP rate)
sum stockhold_pen // 111,579 obs, mean 0.1786 (17.86% SMP rate)
sum stockhold_tot // 111,759 obs, mean 0.3430 (34.30% SMP rate)

* CONTROLS
* 1) lnincome
gen income = incfamilytotal if incfamilytotal > 0
gen lnincome = ln(income)
sum lnincome, detail // 110,393 obs
// incfamilytotal: TOTAL FAMILY income. includes taxable and transfer, head and spouse and others.
// incfamilytotal < 0 : 77 out of 111,759 obs, comes from businesses or farms
* 2) lnwealth
gen wealth = wthtotinclheq if wthtotinclheq > 0
gen lnwealth = ln(wealth)
sum lnwealth, detail // 87,245 obs
* 3) college
assert inlist(eduhdcoldegtf, 0, 1, 5, 9)
gen college = . // 9: missing
replace college = 1 if eduhdcoldegtf == 1 // 1: Yes
replace college = 0 if inlist(eduhdcoldegtf, 0, 5) // 0: drop-out or no edu, 5: No
sum college, detail // 111,575 obs; mean 0.3003 (approx 30% college grads, reasonable representation)
* 4) age
assert !missing(agehd) & agehd >= 0
gen age = agehd
replace age = . if age == 999
sum age, detail // 111,736 obs
* 5) male
assert !missing(sexhd)
assert inlist(sexhd, 1, 2)
gen male = cond(sexhd== 1, 1, 0)
sum male, detail // 111,759 obs; approx 68% male

* INDEPENDENT VARIABLES
gen state = currfips if inrange(currfips, 1, 56)
label define state_abbrev ///
    1 "AL" 2 "AK" 4 "AZ" 5 "AR" 6 "CA" 8 "CO" 9 "CT" 10 "DE" ///
    11 "DC" 12 "FL" 13 "GA" 15 "HI" 16 "ID" 17 "IL" 18 "IN" ///
    19 "IA" 20 "KS" 21 "KY" 22 "LA" 23 "ME" 24 "MD" 25 "MA" ///
    26 "MI" 27 "MN" 28 "MS" 29 "MO" 30 "MT" 31 "NE" 32 "NV" ///
    33 "NH" 34 "NJ" 35 "NM" 36 "NY" 37 "NC" 38 "ND" 39 "OH" ///
    40 "OK" 41 "OR" 42 "PA" 44 "RI" 45 "SC" 46 "SD" 47 "TN" ///
    48 "TX" 49 "UT" 50 "VT" 51 "VA" 53 "WA" 54 "WV" 55 "WI" 56 "WY"
label values state state_abbrev
tabulate state
// baseline becomes 1 AL

* HELPERS FOR MERGE
decode state, gen(state_str)
gen pres_year = year - mod(year, 4)
sort state_str pres_year

*=================================
**# FEC: Presidentials
*==============================
* see ./FEC/contributions.R for construction of STDIR_pres.csv
* STDIR_pres
preserve
	import delimited "./FEC/STDIR_pres.csv", clear
	rename state state_str
	rename year pres_year
	rename stdir_* stdir_pres_*
	sort state_str pres_year
	tempfile fec_pres_temp
	save `fec_pres_temp'
restore
merge m:1 state_str pres_year using `fec_pres_temp', keep(match) nogen
keep uniqueid year state state_str stockhold-stdir_pres_npos
order uniqueid year state state_str stockhold-stdir_pres_npos

* FEDIR_pres
preserve
    clear
    * Define fedir: 1 = Republican Win, -1 = Democrat Win
    input pres_year fedir
    1996 -1 // Bill Clinton (D)
    2000  1 // George W. Bush (R)
    2004  1 // George W. Bush (R)
    2008 -1 // Barack Obama (D)
    2012 -1 // Barack Obama (D)
    2016  1 // Donald Trump (R)
    2020 -1 // Joe Biden (D)
    end
    
    tempfile fedir_temp
    save `fedir_temp'
restore
merge m:1 pres_year using `fedir_temp', keep(match) nogen

* STALG_pres
gen stalg_pres_amt  = stdir_pres_amt  * fedir
gen stalg_pres_n    = stdir_pres_n    * fedir
gen stalg_pres_npos = stdir_pres_npos * fedir

*=================================
**# General elections (presidential)
*====================================
* load and merge general election data
preserve
	// open and filter
	import delimited "./elections/1976-2024-president.csv", clear
	keep if party_simplified == "DEMOCRAT" | party_simplified == "REPUBLICAN"
	drop if candidate == "" | candidate == "OTHER"
	destring year, replace
	keep if year >= 1996 & year <= 2020
	drop state
	rename state_fips state
	rename state_po state_str
	rename year pres_year
	// treat duplicate entries of same canddiate
	// Note: do not filter with writein b/c some states had both final candidates registered as write-ins
	sort pres_year state state_str party_simplified candidatevotes	
	by pres_year state state_str party_simplified: gen trueentry = _n == _N
	drop if trueentry == 0
	drop trueentry
	// reshape to wide
	keep pres_year state state_str candidatevotes party_simplified
	reshape wide candidatevotes, i(pres_year state state_str) j(party_simplified) string
	tempfile vt_pres_temp
	save `vt_pres_temp'
restore
merge m:1 state_str state pres_year using `vt_pres_temp', keep(match) nogen

* STDIR_presvt
gen stdir_presvt = candidatevotesREPUBLICAN / (candidatevotesDEMOCRAT + candidatevotesREPUBLICAN)
replace stdir_presvt = 2 * stdir_presvt - 1

* STALG_presvt
gen stalg_presvt = stdir_presvt * fedir


*=================================
**# Standardize
*==============================

* Standardize continuous variables for 1-SD interpretation
foreach v in lnincome lnwealth age {
    egen z_`v' = std(`v')
}

save "basedata.dta", replace

*================================
**# CSPP
*================================
import delimited "./CSPP/cspp_data_2026-06-03.csv", clear
keep year st state_fips govparty_a ///
	sen_dem_prop_all sen_rep_prop_all hs_dem_prop_all hs_rep_prop_all ///
	efna_index
rename state_fips state
rename st state_str
destring govparty_a sen_dem_prop_all sen_rep_prop_all /// 
	hs_dem_prop_all hs_rep_prop_all efna_index, replace ignore("NA")

* govparty_a: 1 = Repub, 0 = Dem, 0.5 = other party, other non-missing values indicate change in governor
assert missing(govparty_a) | govparty_a == 0 | govparty_a == 1 | govparty_a == 0.5
replace govparty_a = . if govparty_a == 0.5
gen stdir_st_gov = govparty_a * 2 -1 

* state senate and state house values
gen stdir_st_sen = 2 * sen_rep_prop_all / (sen_dem_prop_all + sen_rep_prop_all) - 1
gen stdir_st_hs = 2 * hs_rep_prop_all / (hs_dem_prop_all + hs_rep_prop_all) - 1

* efna_index: economic freedom index
* Stansel, Dean, Jose Torra, and Fred McMahon. 2015. 'Economic Freedom of North America.' Vancouver, BC: Fraiser Institute.
rename efna_index st_efna

* keep necessary
keep year state stdir_st_gov stdir_st_sen stdir_st_hs st_efna
order year state stdir_st_gov stdir_st_sen stdir_st_hs st_efna
save "./cspp.dta", replace

* merge with base data
joinby state year using "basedata.dta", unmatched(using)
drop _merge

* generate alignment
gen stalg_st_gov = stdir_st_gov * fedir
gen stalg_st_sen = stdir_st_sen * fedir
gen stalg_st_hs = stdir_st_hs * fedir

save "basedata.dta", replace


*========================================================================================================
*========================================================================================================
*========================================================================================================



********************************************
**# ===LPM, STOCKHOLD====
****************************************
use "basedata.dta", clear

eststo clear

* (1) No State FE, With stdir_pres_amt
regress stockhold z_lnincome z_lnwealth college z_age male stdir_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm1

* (2) No State FE, With stdir_pres_npos
regress stockhold z_lnincome z_lnwealth college z_age male stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm2

* (3) No State FE, With stalg_pres_amt
regress stockhold z_lnincome z_lnwealth college z_age male stalg_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm3

* (4) No State FE, With stalg_pres_npos
regress stockhold z_lnincome z_lnwealth college z_age male stalg_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm4

* (5) No State FE, full interaction model with amount
* Note: automatically drops one of time fixed effects due to multicolinearity
* would not be included in the final outputs
regress stockhold z_lnincome z_lnwealth college z_age male stdir_pres_amt fedir stalg_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm5

* (6) No State FE, full interaction model with npos
regress stockhold z_lnincome z_lnwealth college z_age male stdir_pres_npos fedir stalg_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm6

* Export LPM to LaTeX
esttab lpm1 lpm2 lpm3 lpm4 lpm5 lpm6 using "reg_stockhold_lpm.tex", replace ///
    keep(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               z_age "Age [1 SD]" ///
               stdir_pres_amt "FEC Amount" ///
               stdir_pres_npos "FEC N (Pos)" ///
               stalg_pres_amt "FEC Aligned Amt" ///
               stalg_pres_npos "FEC Aligned N (Pos)" ///
			   fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes ///
    scalars("r2_comp Adj R-sq") ///
    title("Linear Probability Model: Geographic and Political Effects on Market Participation")


********************************************
**# ===Probit, STOCKHOLD====
****************************************
use "basedata.dta", clear
eststo clear

* (1) No State FE, With stdir_pres_amt
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob1

* (2) No State FE, With stdir_pres_npos
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob2

* (3) No State FE, With stalg_pres_amt
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob3

* (4) No State FE, With stalg_pres_npos
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob4

* (5) No State FE, full interaction model with amount
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt fedir stalg_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt fedir stalg_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob5

* (6) No State FE, full interaction model with npos
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos fedir stalg_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos fedir stalg_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob6

* Export Probit to LaTeX
esttab prob1 prob2 prob3 prob4 prob5 prob6 using "reg_stockhold_probit.tex", replace ///
    keep(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    order(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               z_age "Age [1 SD]" ///
               stdir_pres_amt "FEC Amount" ///
               stdir_pres_npos "FEC N (Pos)" ///
               stalg_pres_amt "FEC Aligned Amt" ///
               stalg_pres_npos "FEC Aligned N (Pos)" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes ///
    scalars("r2_comp Pseudo R-sq") ///
    title("Probit Marginal Effects: Geographic and Political Effects on Market Participation")


********************************************
**# ===LPM, STOCKSHARE ====
****************************************
use "basedata.dta", clear

eststo clear

* (1) No State FE, with stdir_pres_amt
regress stockshare z_lnincome z_lnwealth college z_age male stdir_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm1

* (2) No State FE, With stdir_pres_npos
regress stockshare z_lnincome z_lnwealth college z_age male stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm2

* (3) No State FE, With stalg_pres_amt
regress stockshare z_lnincome z_lnwealth college z_age male stalg_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm3

* (4) No State FE, With stalg_pres_npos
regress stockshare z_lnincome z_lnwealth college z_age male stalg_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm4

* (5) No State FE, full interaction model with amount
regress stockshare z_lnincome z_lnwealth college z_age male stdir_pres_amt fedir stalg_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm5

* (6) No State FE, full interaction model with npos
regress stockshare z_lnincome z_lnwealth college z_age male stdir_pres_npos fedir stalg_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm6

* Export LPM to LaTeX
esttab lpm1 lpm2 lpm3 lpm4 lpm5 lpm6 using "reg_stockshare_lpm.tex", replace ///
    keep(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               z_age "Age [1 SD]" ///
               stdir_pres_amt "FEC Amount" ///
               stdir_pres_npos "FEC N (Pos)" ///
               stalg_pres_amt "FEC Aligned Amt" ///
               stalg_pres_npos "FEC Aligned N (Pos)" ///
			   fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes ///
    scalars("r2_comp Adj R-sq") ///
    title("Linear Probability Model: Geographic and Political Effects on Equity Share")


********************************************
**# ===Probit, STOCKSHARE====
****************************************

use "basedata.dta", clear
eststo clear

* (1) No State FE, With stdir_pres_amt
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob1

* (2) No State FE, With stdir_pres_npos
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob2

* (3) No State FE, With stalg_pres_amt
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stalg_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob3

* (4) No State FE, With stalg_pres_npos
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob4

* (5) No State FE, full interaction model with amount
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt fedir stalg_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt fedir stalg_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob5

* (6) No State FE, full interaction model with npos
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos fedir stalg_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos fedir stalg_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob6

* Export Probit to LaTeX
esttab prob1 prob2 prob3 prob4 prob5 prob6 using "reg_stockshare_probit.tex", replace ///
    keep(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    order(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               z_age "Age [1 SD]" ///
               stdir_pres_amt "FEC Amount" ///
               stdir_pres_npos "FEC N (Pos)" ///
               stalg_pres_amt "FEC Aligned Amt" ///
               stalg_pres_npos "FEC Aligned N (Pos)" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes ///
    scalars("r2_comp Pseudo R-sq") ///
    title("Probit Marginal Effects: Geographic and Political Effects on Equity Share")
	
	
	
	
********************************************
**# ===ROBUSTNESS: presvt, stockhold ====
****************************************
use "basedata.dta", clear

* clear memory
eststo clear

* (1) LPM, stdir_presvt
regress stockhold z_lnincome z_lnwealth college z_age male stdir_presvt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m1

* (2) LPM, stalg_presvt
regress stockhold z_lnincome z_lnwealth college z_age male stalg_presvt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m2

* (3) LPM, stdir_presvt + stalg_presvt + fedir
regress stockhold z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m3

* (4) Probit, stdir_presvt
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_presvt) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m4

* (5) Probit, stalg_presvt
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_presvt) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m5

* (6) Probit, stdir_presvt + stalg_presvt + fedir
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_presvt stalg_presvt fedir i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_presvt stalg_presvt fedir) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m6

* Export all 6 models to a single LaTeX file
esttab m1 m2 m3 m4 m5 m6 using "reg_stockhold_votes.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               college "College" ///
               z_age "Age [1 SD]" ///
               male "Male" ///
               stdir_presvt "Pres. Vote Share" ///
               stalg_presvt "Aligned Pres. Vote Share" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress ///
    scalars("model_type Model Type" "r2_comp R-sq / Pseudo R-sq") ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6") ///
    title("Combined Models: Robustness with Presidential Vote Share")


********************************************
**# ===ROBUSTNESS: presvt, stockhold ====
****************************************
use "basedata.dta", clear

* clear memory
eststo clear

* (1) LPM, stdir_presvt
regress stockhold z_lnincome z_lnwealth college z_age male stdir_presvt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m1

* (2) LPM, stalg_presvt
regress stockhold z_lnincome z_lnwealth college z_age male stalg_presvt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m2

* (3) LPM, stdir_presvt + stalg_presvt + fedir
regress stockhold z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m3

* (4) Probit, stdir_presvt
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_presvt) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m4

* (5) Probit, stalg_presvt
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_presvt) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m5

* (6) Probit, stdir_presvt + stalg_presvt + fedir
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_presvt stalg_presvt fedir i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_presvt stalg_presvt fedir) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m6

* Export all 6 models to a single LaTeX file
esttab m1 m2 m3 m4 m5 m6 using "reg_stockhold_votes.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               college "College" ///
               z_age "Age [1 SD]" ///
               male "Male" ///
               stdir_presvt "Pres. Vote Share" ///
               stalg_presvt "Aligned Pres. Vote Share" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress ///
    scalars("model_type Model Type" "r2_comp R-sq / Pseudo R-sq") ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6") ///
    title("Combined Models: Robustness with Presidential Vote Share")


********************************************
**# ===ROBUSTNESS: presvt, stockshare ====
****************************************
use "basedata.dta", clear
eststo clear

* (1) LPM, stdir_presvt
regress stockshare z_lnincome z_lnwealth college z_age male stdir_presvt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo s1

* (2) LPM, stalg_presvt
regress stockshare z_lnincome z_lnwealth college z_age male stalg_presvt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo s2

* (3) LPM, stdir_presvt + stalg_presvt + fedir
regress stockshare z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo s3

* (4) Fracreg, stdir_presvt
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
* Note: fracreg doesn't strictly produce e(r2_p) like standard probit, but we leave the macro structure intact
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_presvt) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo s4

* (5) Fracreg, stalg_presvt
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stalg_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_presvt) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo s5

* (6) Fracreg, stdir_presvt + stalg_presvt + fedir
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_presvt stalg_presvt fedir i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_presvt stalg_presvt fedir) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo s6

* Export all 6 models to a single LaTeX file
esttab s1 s2 s3 s4 s5 s6 using "reg_stockshare_votes.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               college "College" ///
               z_age "Age [1 SD]" ///
               male "Male" ///
               stdir_presvt "Pres. Vote Share" ///
               stalg_presvt "Aligned Pres. Vote Share" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress ///
    scalars("model_type Model Type" "r2_comp R-sq / Pseudo R-sq") ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6") ///
    title("Combined Models: Robustness with Presidential Vote Share (Stock Share)")

********************************************
**# === ROBUSTNESS: ST_GOV, STOCKHOLD ====
****************************************
use "basedata.dta", clear
eststo clear

* (1) LPM, stdir_st_gov
regress stockhold z_lnincome z_lnwealth college z_age male stdir_st_gov i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m1

* (2) LPM, stalg_st_gov
regress stockhold z_lnincome z_lnwealth college z_age male stalg_st_gov i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m2

* (3) LPM, stdir_st_gov + stalg_st_gov + fedir
regress stockhold z_lnincome z_lnwealth college z_age male stdir_st_gov stalg_st_gov fedir i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m3

* (4) Probit, stdir_st_gov
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_st_gov i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_gov) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m4

* (5) Probit, stalg_st_gov
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_st_gov i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_st_gov) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m5

* (6) Probit, stdir_st_gov + stalg_st_gov + fedir
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_st_gov stalg_st_gov fedir i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_gov stalg_st_gov fedir) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m6

* Export all 6 models to a single LaTeX file
esttab m1 m2 m3 m4 m5 m6 using "reg_stockhold_st_gov.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_st_gov stalg_st_gov fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_st_gov stalg_st_gov fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               college "College" ///
               z_age "Age [1 SD]" ///
               male "Male" ///
               stdir_st_gov "Gov. Vote Share" ///
               stalg_st_gov "Aligned Gov. Vote Share" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress ///
    scalars("model_type Model Type" "r2_comp R-sq / Pseudo R-sq") ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6") ///
    title("Combined Models: Robustness with Gubernatorial (Gov) Vote Share (stockhold)")

********************************************
**# === ROBUSTNESS: ST_GOV, STOCKSHARE ====
****************************************
use "basedata.dta", clear
eststo clear

* (1) LPM, stdir_st_gov
regress stockshare z_lnincome z_lnwealth college z_age male stdir_st_gov i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m1

* (2) LPM, stalg_st_gov
regress stockshare z_lnincome z_lnwealth college z_age male stalg_st_gov i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m2

* (3) LPM, stdir_st_gov + stalg_st_gov + fedir
regress stockshare z_lnincome z_lnwealth college z_age male stdir_st_gov stalg_st_gov fedir i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m3

* (4) Fracreg, stdir_st_gov
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_st_gov i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_gov) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m4

* (5) Fracreg, stalg_st_gov
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stalg_st_gov i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_st_gov) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m5

* (6) Fracreg, stdir_st_gov + stalg_st_gov + fedir
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_st_gov stalg_st_gov fedir i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_gov stalg_st_gov fedir) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m6

* Export all 6 models to a single LaTeX file
esttab m1 m2 m3 m4 m5 m6 using "reg_stockshare_st_gov.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_st_gov stalg_st_gov fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_st_gov stalg_st_gov fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               college "College" ///
               z_age "Age [1 SD]" ///
               male "Male" ///
               stdir_st_gov "Gov. Vote Share" ///
               stalg_st_gov "Aligned Gov. Vote Share" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress ///
    scalars("model_type Model Type" "r2_comp R-sq / Pseudo R-sq") ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6") ///
    title("Combined Models: Robustness with Gubernatorial (Gov) Vote Share (stockshare)")

********************************************
**# === ROBUSTNESS: ST_SEN, STOCKHOLD ====
****************************************
use "basedata.dta", clear
eststo clear

* (1) LPM, stdir_st_sen
regress stockhold z_lnincome z_lnwealth college z_age male stdir_st_sen i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m1

* (2) LPM, stalg_st_sen
regress stockhold z_lnincome z_lnwealth college z_age male stalg_st_sen i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m2

* (3) LPM, stdir_st_sen + stalg_st_sen + fedir
regress stockhold z_lnincome z_lnwealth college z_age male stdir_st_sen stalg_st_sen fedir i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m3

* (4) Probit, stdir_st_sen
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_st_sen i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_sen) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m4

* (5) Probit, stalg_st_sen
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_st_sen i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_st_sen) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m5

* (6) Probit, stdir_st_sen + stalg_st_sen + fedir
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_st_sen stalg_st_sen fedir i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_sen stalg_st_sen fedir) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m6

* Export all 6 models to a single LaTeX file
esttab m1 m2 m3 m4 m5 m6 using "reg_stockhold_st_sen.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_st_sen stalg_st_sen fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_st_sen stalg_st_sen fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               college "College" ///
               z_age "Age [1 SD]" ///
               male "Male" ///
               stdir_st_sen "Sen. Vote Share" ///
               stalg_st_sen "Aligned Sen. Vote Share" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress ///
    scalars("model_type Model Type" "r2_comp R-sq / Pseudo R-sq") ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6") ///
    title("Combined Models: Robustness with Senatorial (Sen) Vote Share (stockhold)")

********************************************
**# === ROBUSTNESS: ST_SEN, STOCKSHARE ====
****************************************
use "basedata.dta", clear
eststo clear

* (1) LPM, stdir_st_sen
regress stockshare z_lnincome z_lnwealth college z_age male stdir_st_sen i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m1

* (2) LPM, stalg_st_sen
regress stockshare z_lnincome z_lnwealth college z_age male stalg_st_sen i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m2

* (3) LPM, stdir_st_sen + stalg_st_sen + fedir
regress stockshare z_lnincome z_lnwealth college z_age male stdir_st_sen stalg_st_sen fedir i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m3

* (4) Fracreg, stdir_st_sen
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_st_sen i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_sen) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m4

* (5) Fracreg, stalg_st_sen
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stalg_st_sen i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_st_sen) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m5

* (6) Fracreg, stdir_st_sen + stalg_st_sen + fedir
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_st_sen stalg_st_sen fedir i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_sen stalg_st_sen fedir) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m6

* Export all 6 models to a single LaTeX file
esttab m1 m2 m3 m4 m5 m6 using "reg_stockshare_st_sen.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_st_sen stalg_st_sen fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_st_sen stalg_st_sen fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               college "College" ///
               z_age "Age [1 SD]" ///
               male "Male" ///
               stdir_st_sen "Sen. Vote Share" ///
               stalg_st_sen "Aligned Sen. Vote Share" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress ///
    scalars("model_type Model Type" "r2_comp R-sq / Pseudo R-sq") ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6") ///
    title("Combined Models: Robustness with Senatorial (Sen) Vote Share (stockshare)")

********************************************
**# === ROBUSTNESS: ST_HS, STOCKHOLD ====
****************************************
use "basedata.dta", clear
eststo clear

* (1) LPM, stdir_st_hs
regress stockhold z_lnincome z_lnwealth college z_age male stdir_st_hs i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m1

* (2) LPM, stalg_st_hs
regress stockhold z_lnincome z_lnwealth college z_age male stalg_st_hs i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m2

* (3) LPM, stdir_st_hs + stalg_st_hs + fedir
regress stockhold z_lnincome z_lnwealth college z_age male stdir_st_hs stalg_st_hs fedir i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m3

* (4) Probit, stdir_st_hs
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_st_hs i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_hs) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m4

* (5) Probit, stalg_st_hs
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_st_hs i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_st_hs) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m5

* (6) Probit, stdir_st_hs + stalg_st_hs + fedir
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_st_hs stalg_st_hs fedir i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_hs stalg_st_hs fedir) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m6

* Export all 6 models to a single LaTeX file
esttab m1 m2 m3 m4 m5 m6 using "reg_stockhold_st_hs.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_st_hs stalg_st_hs fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_st_hs stalg_st_hs fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               college "College" ///
               z_age "Age [1 SD]" ///
               male "Male" ///
               stdir_st_hs "House Vote Share" ///
               stalg_st_hs "Aligned House Vote Share" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress ///
    scalars("model_type Model Type" "r2_comp R-sq / Pseudo R-sq") ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6") ///
    title("Combined Models: Robustness with House (Hs) Vote Share (stockhold)")

********************************************
**# === ROBUSTNESS: ST_HS, STOCKSHARE ====
****************************************
use "basedata.dta", clear
eststo clear

* (1) LPM, stdir_st_hs
regress stockshare z_lnincome z_lnwealth college z_age male stdir_st_hs i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m1

* (2) LPM, stalg_st_hs
regress stockshare z_lnincome z_lnwealth college z_age male stalg_st_hs i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m2

* (3) LPM, stdir_st_hs + stalg_st_hs + fedir
regress stockshare z_lnincome z_lnwealth college z_age male stdir_st_hs stalg_st_hs fedir i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo m3

* (4) Fracreg, stdir_st_hs
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_st_hs i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_hs) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m4

* (5) Fracreg, stalg_st_hs
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stalg_st_hs i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_st_hs) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m5

* (6) Fracreg, stdir_st_hs + stalg_st_hs + fedir
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_st_hs stalg_st_hs fedir i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_st_hs stalg_st_hs fedir) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m6

* Export all 6 models to a single LaTeX file
esttab m1 m2 m3 m4 m5 m6 using "reg_stockshare_st_hs.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_st_hs stalg_st_hs fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_st_hs stalg_st_hs fedir) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               college "College" ///
               z_age "Age [1 SD]" ///
               male "Male" ///
               stdir_st_hs "House Vote Share" ///
               stalg_st_hs "Aligned House Vote Share" ///
               fedir "Fed Dir") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress ///
    scalars("model_type Model Type" "r2_comp R-sq / Pseudo R-sq") ///
    mtitles("Model 1" "Model 2" "Model 3" "Model 4" "Model 5" "Model 6") ///
    title("Combined Models: Robustness with House (Hs) Vote Share (stockshare)")

	
**********************************************************************
**# === STDIR_PRES & ST_FE, STOCKHOLD ===
*****************************************************
use "basedata.dta", clear

eststo clear
* =========================================================
* LPM MODELS (Columns 1 - 4)
* =========================================================

* ---------------------------------------------------------
* (1) LPM: No State FE, With stdir_pres_npos
* ---------------------------------------------------------
regress stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year, vce(cluster state)
test stdir_pres_npos
local st_s = r(F)
local st_p = r(p)

estadd local model_type "LPM"
estadd local state_fe "No"
estadd local year_fe "Yes"
estadd scalar r2_comp = e(r2_a)
estadd local fe_stat = "-"
estadd local fe_pval = "-"
estadd local stdir_stat = string(`st_s', "%9.2f")
estadd local stdir_pval = string(`st_p', "%9.2e")
eststo m1

* ---------------------------------------------------------
* (2) LPM: With State FE, No stdir_pres_npos
* ---------------------------------------------------------
regress stockhold z_lnincome z_lnwealth i.college z_age i.male i.year i.state, vce(cluster state)
testparm i.state
local fe_s = r(F)
local fe_p = r(p)

estadd local model_type "LPM"
estadd local state_fe "Yes"
estadd local year_fe "Yes"
estadd scalar r2_comp = e(r2_a)
estadd local fe_stat = string(`fe_s', "%9.2f")
estadd local fe_pval = string(`fe_p', "%9.2e")
estadd local stdir_stat = "-"
estadd local stdir_pval = "-"
eststo m2

* ---------------------------------------------------------
* (3) LPM: With State FE, With stdir_pres_npos
* ---------------------------------------------------------
regress stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year i.state, vce(cluster state)
testparm i.state
local fe_s = r(F)
local fe_p = r(p)
test stdir_pres_npos
local st_s = r(F)
local st_p = r(p)

estadd local model_type "LPM"
estadd local state_fe "Yes"
estadd local year_fe "Yes"
estadd scalar r2_comp = e(r2_a)
estadd local fe_stat = string(`fe_s', "%9.2f")
estadd local fe_pval = string(`fe_p', "%9.2e")
estadd local stdir_stat = string(`st_s', "%9.2f")
estadd local stdir_pval = string(`st_p', "%9.2e")
eststo m3

* ---------------------------------------------------------
* (4) LPM: Residual Re-regression Approach (NEW)
* ---------------------------------------------------------
* Step 1: Regress Y on controls + FEs (Silent run of m2 params)
quietly regress stockhold z_lnincome z_lnwealth i.college z_age i.male i.year i.state, vce(cluster state)
* Step 2: Predict residuals for Y
predict lpm_resid, resid
* Step 3: Regress residuals on X
regress lpm_resid stdir_pres_npos, vce(cluster state)
test stdir_pres_npos
local st_s = r(F)
local st_p = r(p)

estadd local model_type "LPM Resid"
estadd local state_fe "Step 1"
estadd local year_fe "Step 1"
estadd scalar r2_comp = e(r2_a)
estadd local fe_stat = "-"
estadd local fe_pval = "-"
estadd local stdir_stat = string(`st_s', "%9.2f")
estadd local stdir_pval = string(`st_p', "%9.2e")
eststo m4


* =========================================================
* PROBIT MODELS (Columns 5 - 8)
* =========================================================

* ---------------------------------------------------------
* (5) PROBIT: No State FE, With stdir_pres_npos
* ---------------------------------------------------------
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
test stdir_pres_npos
local st_s = r(chi2)
local st_p = r(p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post

estadd local model_type "Probit"
estadd local state_fe "No"
estadd local year_fe "Yes"
estadd scalar r2_comp = `p_r2'
estadd local fe_stat = "-"
estadd local fe_pval = "-"
estadd local stdir_stat = string(`st_s', "%9.2f")
estadd local stdir_pval = string(`st_p', "%9.2e")
eststo m5

* ---------------------------------------------------------
* (6) PROBIT: With State FE, No stdir_pres_npos
* ---------------------------------------------------------
probit stockhold z_lnincome z_lnwealth i.college z_age i.male i.year i.state, vce(cluster state)
local p_r2 = e(r2_p)
testparm i.state
local fe_s = r(chi2)
local fe_p = r(p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male) post

estadd local model_type "Probit"
estadd local state_fe "Yes"
estadd local year_fe "Yes"
estadd scalar r2_comp = `p_r2'
estadd local fe_stat = string(`fe_s', "%9.2f")
estadd local fe_pval = string(`fe_p', "%9.2e")
estadd local stdir_stat = "-"
estadd local stdir_pval = "-"
eststo m6

* ---------------------------------------------------------
* (7) PROBIT: With State FE, With stdir_pres_npos
* ---------------------------------------------------------
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year i.state, vce(cluster state)
local p_r2 = e(r2_p)
testparm i.state
local fe_s = r(chi2)
local fe_p = r(p)
test stdir_pres_npos
local st_s = r(chi2)
local st_p = r(p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post

estadd local model_type "Probit"
estadd local state_fe "Yes"
estadd local year_fe "Yes"
estadd scalar r2_comp = `p_r2'
estadd local fe_stat = string(`fe_s', "%9.2f")
estadd local fe_pval = string(`fe_p', "%9.2e")
estadd local stdir_stat = string(`st_s', "%9.2f")
estadd local stdir_pval = string(`st_p', "%9.2e")
eststo m7

* ---------------------------------------------------------
* (8) PROBIT: Residual Re-regression Approach (NEW)
* ---------------------------------------------------------
* Step 1: Probit Y on controls + FEs (Silent run of m6 params)
quietly probit stockhold z_lnincome z_lnwealth i.college z_age i.male i.year i.state, vce(cluster state)
* Step 2: Predict probabilities and generate raw continuous residuals
predict probit_phat, pr
gen probit_resid = stockhold - probit_phat
* Step 3: Regress continuous residuals on X (Must be OLS due to continuous DV)
regress probit_resid stdir_pres_npos, vce(cluster state)
test stdir_pres_npos
local st_s = r(F)
local st_p = r(p)

estadd local model_type "Prob Resid"
estadd local state_fe "Step 1"
estadd local year_fe "Step 1"
estadd scalar r2_comp = e(r2_a)
estadd local fe_stat = "-"
estadd local fe_pval = "-"
estadd local stdir_stat = string(`st_s', "%9.2f")
estadd local stdir_pval = string(`st_p', "%9.2e")
eststo m8


* =========================================================
* Export Combined Table to LaTeX
* =========================================================
* Updated to include all 8 models
esttab m1 m2 m3 m4 m5 m6 m7 m8 using "reg_stockhold_dir_wfe.tex", replace ///
    keep(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_npos) ///
    order(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_npos) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               z_age "Age [1 SD]" ///
               stdir_pres_npos "FEC Dir N (Pos)") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes ///
    scalars("model_type Model" "state_fe State FE" "year_fe Year FE" ///
            "fe_stat State FE Stat." "fe_pval State FE P-Value" ///
            "stdir_stat FEC Stat." "stdir_pval FEC P-Value" ///
            "r2_comp Adj/Pseudo R-sq") ///
    title("Geographic Effects on Stock Market Participation: LPM vs Probit with State Fixed Effects")
	
**********************************************************************
**# === STALG_PRES & ST_FE, STOCKHOLD ===
*****************************************************
use "basedata.dta", clear

* Clear memory
eststo clear

* =========================================================
* LPM MODELS (Columns 1 - 4)
* =========================================================

* ---------------------------------------------------------
* (1) LPM: No State FE, With stalg_pres_npos
* ---------------------------------------------------------
regress stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year, vce(cluster state)
test stalg_pres_npos
local st_s = r(F)
local st_p = r(p)

estadd local model_type "LPM"
estadd local state_fe "No"
estadd local year_fe "Yes"
estadd scalar r2_comp = e(r2_a)
estadd local fe_stat = "-"
estadd local fe_pval = "-"
estadd local stalg_stat = string(`st_s', "%9.2f")
estadd local stalg_pval = string(`st_p', "%9.2e")
eststo m1

* ---------------------------------------------------------
* (2) LPM: With State FE, No stalg_pres_npos
* ---------------------------------------------------------
regress stockhold z_lnincome z_lnwealth i.college z_age i.male i.year i.state, vce(cluster state)
testparm i.state
local fe_s = r(F)
local fe_p = r(p)

estadd local model_type "LPM"
estadd local state_fe "Yes"
estadd local year_fe "Yes"
estadd scalar r2_comp = e(r2_a)
estadd local fe_stat = string(`fe_s', "%9.2f")
estadd local fe_pval = string(`fe_p', "%9.2e")
estadd local stalg_stat = "-"
estadd local stalg_pval = "-"
eststo m2

* ---------------------------------------------------------
* (3) LPM: With State FE, With stalg_pres_npos
* ---------------------------------------------------------
regress stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year i.state, vce(cluster state)
testparm i.state
local fe_s = r(F)
local fe_p = r(p)
test stalg_pres_npos
local st_s = r(F)
local st_p = r(p)

estadd local model_type "LPM"
estadd local state_fe "Yes"
estadd local year_fe "Yes"
estadd scalar r2_comp = e(r2_a)
estadd local fe_stat = string(`fe_s', "%9.2f")
estadd local fe_pval = string(`fe_p', "%9.2e")
estadd local stalg_stat = string(`st_s', "%9.2f")
estadd local stalg_pval = string(`st_p', "%9.2e")
eststo m3

* ---------------------------------------------------------
* (4) LPM: Residual Re-regression Approach (NEW)
* ---------------------------------------------------------
* Step 1: Regress Y on controls + FEs (Silent run of m2 params)
quietly regress stockhold z_lnincome z_lnwealth i.college z_age i.male i.year i.state, vce(cluster state)
* Step 2: Predict residuals for Y
capture drop lpm_resid
predict lpm_resid, resid
* Step 3: Regress residuals on X
regress lpm_resid stalg_pres_npos, vce(cluster state)
test stalg_pres_npos
local st_s = r(F)
local st_p = r(p)

estadd local model_type "LPM Resid"
estadd local state_fe "Step 1"
estadd local year_fe "Step 1"
estadd scalar r2_comp = e(r2_a)
estadd local fe_stat = "-"
estadd local fe_pval = "-"
estadd local stalg_stat = string(`st_s', "%9.2f")
estadd local stalg_pval = string(`st_p', "%9.2e")
eststo m4


* =========================================================
* PROBIT MODELS (Columns 5 - 8)
* =========================================================

* ---------------------------------------------------------
* (5) PROBIT: No State FE, With stalg_pres_npos
* ---------------------------------------------------------
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
test stalg_pres_npos
local st_s = r(chi2)
local st_p = r(p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos) post

estadd local model_type "Probit"
estadd local state_fe "No"
estadd local year_fe "Yes"
estadd scalar r2_comp = `p_r2'
estadd local fe_stat = "-"
estadd local fe_pval = "-"
estadd local stalg_stat = string(`st_s', "%9.2f")
estadd local stalg_pval = string(`st_p', "%9.2e")
eststo m5

* ---------------------------------------------------------
* (6) PROBIT: With State FE, No stalg_pres_npos
* ---------------------------------------------------------
probit stockhold z_lnincome z_lnwealth i.college z_age i.male i.year i.state, vce(cluster state)
local p_r2 = e(r2_p)
testparm i.state
local fe_s = r(chi2)
local fe_p = r(p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male) post

estadd local model_type "Probit"
estadd local state_fe "Yes"
estadd local year_fe "Yes"
estadd scalar r2_comp = `p_r2'
estadd local fe_stat = string(`fe_s', "%9.2f")
estadd local fe_pval = string(`fe_p', "%9.2e")
estadd local stalg_stat = "-"
estadd local stalg_pval = "-"
eststo m6

* ---------------------------------------------------------
* (7) PROBIT: With State FE, With stalg_pres_npos
* ---------------------------------------------------------
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year i.state, vce(cluster state)
local p_r2 = e(r2_p)
testparm i.state
local fe_s = r(chi2)
local fe_p = r(p)
test stalg_pres_npos
local st_s = r(chi2)
local st_p = r(p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos) post

estadd local model_type "Probit"
estadd local state_fe "Yes"
estadd local year_fe "Yes"
estadd scalar r2_comp = `p_r2'
estadd local fe_stat = string(`fe_s', "%9.2f")
estadd local fe_pval = string(`fe_p', "%9.2e")
estadd local stalg_stat = string(`st_s', "%9.2f")
estadd local stalg_pval = string(`st_p', "%9.2e")
eststo m7

* ---------------------------------------------------------
* (8) PROBIT: Residual Re-regression Approach (NEW)
* ---------------------------------------------------------
* Step 1: Probit Y on controls + FEs (Silent run of m6 params)
quietly probit stockhold z_lnincome z_lnwealth i.college z_age i.male i.year i.state, vce(cluster state)
* Step 2: Predict probabilities and generate raw continuous residuals
capture drop probit_phat probit_resid
predict probit_phat, pr
gen probit_resid = stockhold - probit_phat
* Step 3: Regress continuous residuals on X (Must be OLS due to continuous DV)
regress probit_resid stalg_pres_npos, vce(cluster state)
test stalg_pres_npos
local st_s = r(F)
local st_p = r(p)

estadd local model_type "Prob Resid"
estadd local state_fe "Step 1"
estadd local year_fe "Step 1"
estadd scalar r2_comp = e(r2_a)
estadd local fe_stat = "-"
estadd local fe_pval = "-"
estadd local stalg_stat = string(`st_s', "%9.2f")
estadd local stalg_pval = string(`st_p', "%9.2e")
eststo m8


* =========================================================
* Export Combined Table to LaTeX
* =========================================================
esttab m1 m2 m3 m4 m5 m6 m7 m8 using "reg_stockhold_alg_wfe.tex", replace ///
    keep(z_lnincome z_lnwealth 1.college z_age 1.male stalg_pres_npos) ///
    order(z_lnincome z_lnwealth 1.college z_age 1.male stalg_pres_npos) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               z_age "Age [1 SD]" ///
               stalg_pres_npos "FEC Align N (Pos)") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes ///
    scalars("model_type Model" "state_fe State FE" "year_fe Year FE" ///
            "fe_stat State FE Stat." "fe_pval State FE P-Value" ///
            "stalg_stat FEC Stat." "stalg_pval FEC P-Value" ///
            "r2_comp Adj/Pseudo R-sq") ///
    title("Geographic Effects on Stock Market Participation: LPM vs Probit with State Fixed Effects")
	
	
**********************************************************************
**# === PREDICTED STATE-LEVEL MARGINAL EFFECTS (t-1 to t+1) ===
**********************************************************************
use "basedata.dta", clear

* ---------------------------------------------------------
* 1. Extract Marginal Effects (LPM Coefficients)
* ---------------------------------------------------------
* Run LPM for STDIR to capture the coefficient
quietly regress stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year, vce(cluster state)
local beta_stdir = _b[stdir_pres_npos]

* Run LPM for STALG to capture the coefficient
quietly regress stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year, vce(cluster state)
local beta_stalg = _b[stalg_pres_npos]

* ---------------------------------------------------------
* 2. Aggregate to State-Year Level
* ---------------------------------------------------------
* Collapse individual data to get actual state averages per year
collapse (mean) barY=stockhold stdir=stdir_pres_npos stalg=stalg_pres_npos, by(state year)

* ---------------------------------------------------------
* 3. Isolate the t-1 and t+1 Window
* ---------------------------------------------------------
* Presidential elections happen when mod(year, 4) == 0 (e.g., 2000, 2004)
* Odd survey years are mapped to their adjacent election year:
* Survey year = Election - 1 (e.g., 1999 -> 2000)
gen pres_year = year + 1 if mod(year, 4) == 3 

* Survey year = Election + 1 (e.g., 2001 -> 2000)
replace pres_year = year - 1 if mod(year, 4) == 1 

* Drop any survey years that don't fall exactly 1 year before or after an election
drop if missing(pres_year)

* Tag periods for reshaping
gen period = "before" if year < pres_year
replace period = "after" if year > pres_year

* ---------------------------------------------------------
* 4. Reshape to Panel and Calculate Predictions
* ---------------------------------------------------------
keep state pres_year period barY stdir stalg
reshape wide barY stdir stalg, i(state pres_year) j(period) string

* Drop instances where a state doesn't have both t-1 and t+1 data
drop if missing(barYbefore) | missing(barYafter)

* Rename to requested variables
rename pres_year election_year
gen start_year = election_year - 1

* Assign the stored coefficients to the dataset
gen me_stdir = `beta_stdir'
gen me_stalg = `beta_stalg'

* Calculate the changes in the X variables
gen delta_stdir = stdirafter - stdirbefore
gen delta_stalg = stalgafter - stalgbefore

* Calculate predicted new barY based on the marginal effects
gen pred_barY_stdir = barYbefore + (delta_stdir * me_stdir)
gen pred_barY_stalg = barYbefore + (delta_stalg * me_stalg)

* Calculate errors
gen prerr_barY_stdir = pred_barY_stdir - barYafter
gen prerr_barY_stalg = pred_barY_stalg - barYafter

* ---------------------------------------------------------
* 5. Clean up and Format Output
* ---------------------------------------------------------
keep state start_year me_stdir me_stalg ///
     stdirbefore stalgbefore barYbefore ///
     stdirafter stalgafter barYafter ///
     pred_barY_stdir pred_barY_stalg ///
	 prerr_barY_stdir prerr_barY_stalg

order state start_year me_stdir me_stalg ///
      stdirbefore stalgbefore barYbefore ///
      stdirafter stalgafter barYafter ///
      pred_barY_stdir pred_barY_stalg ///
	  prerr_barY_stdir prerr_barY_stalg

label var start_year "Year before election (t-1)"
label var me_stdir "Marginal Effect of STDIR"
label var me_stalg "Marginal Effect of STALG"
label var barYbefore "Actual Avg Stockhold (t-1)"
label var barYafter "Actual Avg Stockhold (t+1)"
label var pred_barY_stdir "Predicted Stockhold from STDIR Change"
label var pred_barY_stalg "Predicted Stockhold from STALG Change"

sort state start_year
save "state_predictions.dta", replace



********************************************
**# === LPM, STOCKHOLD VARIATIONS (1-12) ====
********************************************
use "basedata.dta", clear
eststo clear

* ==========================================
* DEPENDENT VARIABLE: stockhold_tot (1-4)
* ==========================================
* (1) No State FE, with stdir_pres_amt
regress stockhold_tot z_lnincome z_lnwealth college z_age male stdir_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm1

* (2) No State FE, With stdir_pres_npos
regress stockhold_tot z_lnincome z_lnwealth college z_age male stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm2

* (3) No State FE, With stalg_pres_amt
regress stockhold_tot z_lnincome z_lnwealth college z_age male stalg_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm3

* (4) No State FE, With stalg_pres_npos
regress stockhold_tot z_lnincome z_lnwealth college z_age male stalg_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm4

* ==========================================
* DEPENDENT VARIABLE: stockhold_ira (5-8)
* ==========================================
* (5) No State FE, with stdir_pres_amt
regress stockhold_ira z_lnincome z_lnwealth college z_age male stdir_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm5

* (6) No State FE, With stdir_pres_npos
regress stockhold_ira z_lnincome z_lnwealth college z_age male stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm6

* (7) No State FE, With stalg_pres_amt
regress stockhold_ira z_lnincome z_lnwealth college z_age male stalg_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm7

* (8) No State FE, With stalg_pres_npos
regress stockhold_ira z_lnincome z_lnwealth college z_age male stalg_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm8

* ==========================================
* DEPENDENT VARIABLE: stockhold_pen (9-12)
* ==========================================
* (9) No State FE, with stdir_pres_amt
regress stockhold_pen z_lnincome z_lnwealth college z_age male stdir_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm9

* (10) No State FE, With stdir_pres_npos
regress stockhold_pen z_lnincome z_lnwealth college z_age male stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm10

* (11) No State FE, With stalg_pres_amt
regress stockhold_pen z_lnincome z_lnwealth college z_age male stalg_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm11

* (12) No State FE, With stalg_pres_npos
regress stockhold_pen z_lnincome z_lnwealth college z_age male stalg_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm12

* Export LPM to LaTeX
esttab lpm1 lpm2 lpm3 lpm4 lpm5 lpm6 lpm7 lpm8 lpm9 lpm10 lpm11 lpm12 using "reg_stockhold_ext_lpm.tex", replace ///
    keep(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos) ///
    order(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               z_age "Age [1 SD]" ///
               stdir_pres_amt "FEC Amount" ///
               stdir_pres_npos "FEC N (Pos)" ///
               stalg_pres_amt "FEC Aligned Amt" ///
               stalg_pres_npos "FEC Aligned N (Pos)") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes ///
    scalars("r2_comp Adj R-sq") ///
    title("Linear Probability Models: Geographic and Political Effects on Stockholding")


********************************************
**# === PROBIT, STOCKHOLD VARIATIONS (13-24) ====
********************************************
use "basedata.dta", clear
eststo clear

* ==========================================
* DEPENDENT VARIABLE: stockhold_tot (13-16)
* ==========================================
* (13) No State FE, With stdir_pres_amt
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob1

* (14) No State FE, With stdir_pres_npos
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob2

* (15) No State FE, With stalg_pres_amt
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stalg_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob3

* (16) No State FE, With stalg_pres_npos
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob4

* ==========================================
* DEPENDENT VARIABLE: stockhold_ira (17-20)
* ==========================================
* (17) No State FE, With stdir_pres_amt
probit stockhold_ira z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob5

* (18) No State FE, With stdir_pres_npos
probit stockhold_ira z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob6

* (19) No State FE, With stalg_pres_amt
probit stockhold_ira z_lnincome z_lnwealth i.college z_age i.male stalg_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob7

* (20) No State FE, With stalg_pres_npos
probit stockhold_ira z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob8

* ==========================================
* DEPENDENT VARIABLE: stockhold_pen (21-24)
* ==========================================
* (21) No State FE, With stdir_pres_amt
probit stockhold_pen z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob9

* (22) No State FE, With stdir_pres_npos
probit stockhold_pen z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob10

* (23) No State FE, With stalg_pres_amt
probit stockhold_pen z_lnincome z_lnwealth i.college z_age i.male stalg_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob11

* (24) No State FE, With stalg_pres_npos
probit stockhold_pen z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob12

* Export Probit to LaTeX
esttab prob1 prob2 prob3 prob4 prob5 prob6 prob7 prob8 prob9 prob10 prob11 prob12 using "reg_stockhold_ext_probit.tex", replace ///
    keep(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos) ///
    order(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               z_age "Age [1 SD]" ///
               stdir_pres_amt "FEC Amount" ///
               stdir_pres_npos "FEC N (Pos)" ///
               stalg_pres_amt "FEC Aligned Amt" ///
               stalg_pres_npos "FEC Aligned N (Pos)") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes ///
    scalars("r2_comp Pseudo R-sq") ///
    title("Probit Marginal Effects: Geographic and Political Effects on Stockholding")
	
	
	
*************************************************
**# === STDIR: interactions w/ income & wealth
*************************************************
use "basedata.dta", clear
eststo clear

* (1) LPM, Y = stockhold, use stdir_pres_amt, interact with z_lnincome, no state FE
regress stockhold c.stdir_pres_amt##c.z_lnincome z_lnwealth college z_age male i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo recon1

* (2) LPM, Y = stockhold, use stdir_pres_npos, interact with z_lnincome, no state FE
regress stockhold c.stdir_pres_npos##c.z_lnincome z_lnwealth college z_age male i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo recon2

* (3) LPM, Y = stockhold, use stdir_pres_amt, interact with z_lnwealth, no state FE
regress stockhold c.stdir_pres_amt##c.z_lnwealth z_lnincome college z_age male i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo recon3

* (4) LPM, Y = stockhold, use stdir_pres_npos, interact with z_lnwealth, no state FE
regress stockhold c.stdir_pres_npos##c.z_lnwealth z_lnincome college z_age male i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo recon4

* (5) Probit version of (1) - interact with z_lnincome
probit stockhold c.stdir_pres_amt##c.z_lnincome z_lnwealth college z_age male i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_p)
eststo recon5

* (6) Probit version of (2) - interact with z_lnincome
probit stockhold c.stdir_pres_npos##c.z_lnincome z_lnwealth college z_age male i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_p)
eststo recon6

* (7) Probit version of (3) - interact with z_lnwealth
probit stockhold c.stdir_pres_amt##c.z_lnwealth z_lnincome college z_age male i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_p)
eststo recon7

* (8) Probit version of (4) - interact with z_lnwealth
probit stockhold c.stdir_pres_npos##c.z_lnwealth z_lnincome college z_age male i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_p)
eststo recon8

* Export all 8 models to LaTeX
esttab recon1 recon2 recon3 recon4 recon5 recon6 recon7 recon8 using "reg_stockhold_reconciliation.tex", replace ///
    keep(stdir_pres_amt c.stdir_pres_amt#c.z_lnincome c.stdir_pres_amt#c.z_lnwealth ///
         stdir_pres_npos c.stdir_pres_npos#c.z_lnincome c.stdir_pres_npos#c.z_lnwealth ///
         z_lnincome z_lnwealth college z_age male) ///
    order(stdir_pres_amt c.stdir_pres_amt#c.z_lnincome c.stdir_pres_amt#c.z_lnwealth ///
          stdir_pres_npos c.stdir_pres_npos#c.z_lnincome c.stdir_pres_npos#c.z_lnwealth ///
          z_lnincome z_lnwealth college z_age male) ///
    coeflabels(stdir_pres_amt "FEC Amount" ///
               c.stdir_pres_amt#c.z_lnincome "FEC Amt $\times$ Income" ///
               c.stdir_pres_amt#c.z_lnwealth "FEC Amt $\times$ Wealth" ///
               stdir_pres_npos "FEC N (Pos)" ///
               c.stdir_pres_npos#c.z_lnincome "FEC N (Pos) $\times$ Income" ///
               c.stdir_pres_npos#c.z_lnwealth "FEC N (Pos) $\times$ Wealth" ///
               z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               z_age "Age [1 SD]" ///
               college "College" ///
               male "Male") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes ///
    scalars("r2_comp Adj/Pseudo R-sq") ///
    title("Stockholding Reconciliation: Interactions with Income and Wealth")
	
*************************************************
**# === STDIR: age cohort
*************************************************
use "basedata.dta", clear
eststo clear

* filter for age cohort: aged 14-22 in 1979
* Calculate birth year as (survey year - age), then age in 1979 as (1979 - birth_year)
gen implied_birth_year = year - age
gen age_in_1979 = 1979 - implied_birth_year
keep if inrange(age_in_1979, 14, 22)

* ==========================================
* (1) - (6): LPM Models
* ==========================================

* (1) LPM, Y = stockhold, use stdir_pres_amt
regress stockhold z_lnincome z_lnwealth college z_age male stdir_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm1

* (2) LPM, Y = stockhold, use stdir_pres_npos
regress stockhold z_lnincome z_lnwealth college z_age male stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm2

* (3) LPM, Y = stockhold, use stdir_presvt
regress stockhold z_lnincome z_lnwealth college z_age male stdir_presvt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm3

* (4) LPM, Y = stockhold_tot, use stdir_pres_amt
regress stockhold_tot z_lnincome z_lnwealth college z_age male stdir_pres_amt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm4

* (5) LPM, Y = stockhold_tot, use stdir_pres_npos
regress stockhold_tot z_lnincome z_lnwealth college z_age male stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm5

* (6) LPM, Y = stockhold_tot, use stdir_presvt
regress stockhold_tot z_lnincome z_lnwealth college z_age male stdir_presvt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo lpm6


* ==========================================
* (7) - (12): Probit Models (Marginal Effects)
* ==========================================

* (7) Probit, Y = stockhold, use stdir_pres_amt
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob1

* (8) Probit, Y = stockhold, use stdir_pres_npos
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob2

* (9) Probit, Y = stockhold, use stdir_presvt
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_presvt) post
estadd scalar r2_comp = `p_r2'
eststo prob3

* (10) Probit, Y = stockhold_tot, use stdir_pres_amt
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_amt) post
estadd scalar r2_comp = `p_r2'
eststo prob4

* (11) Probit, Y = stockhold_tot, use stdir_pres_npos
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo prob5

* (12) Probit, Y = stockhold_tot, use stdir_presvt
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stdir_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_presvt) post
estadd scalar r2_comp = `p_r2'
eststo prob6


* ==========================================
* Export to single tex file
* ==========================================

* Export all 12 models to reg_stockhold_cohort.tex
esttab lpm1 lpm2 lpm3 lpm4 lpm5 lpm6 prob1 prob2 prob3 prob4 prob5 prob6 ///
    using "reg_stockhold_cohort.tex", replace ///
    keep(z_lnincome z_lnwealth college 1.college z_age male 1.male stdir_pres_amt stdir_pres_npos stdir_presvt) ///
    order(z_lnincome z_lnwealth college 1.college z_age male 1.male stdir_pres_amt stdir_pres_npos stdir_presvt) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               college "College" ///
               1.college "College" ///
               z_age "Age [1 SD]" ///
               male "Male" ///
               1.male "Male" ///
               stdir_pres_amt "FEC Amount" ///
               stdir_pres_npos "FEC N (Pos)" ///
               stdir_presvt "FEC Pres Vote") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes ///
    scalars("r2_comp R-sq") ///
    title("LPM and Probit Margins: Age Cohort (14-22 in 1979)")
	
	
*************************************************
**# === STDIR: full sample with birth year
*************************************************
use "basedata.dta", clear
eststo clear

* Calculate implied birth year 
gen implied_birth_year = year - age

* (1) LPM, Y = stockhold, use stdir_pres_npos
regress stockhold z_lnincome z_lnwealth i.college z_age i.male implied_birth_year stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
estadd local year_fe "Y"
eststo byear1

* (2) '' with interaction b/w birth year and stdir
regress stockhold z_lnincome z_lnwealth i.college z_age i.male c.implied_birth_year##c.stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
estadd local year_fe "Y"
eststo byear2

* (3) LPM, Y = stockhold_tot, use stdir_pres_npos
regress stockhold_tot z_lnincome z_lnwealth i.college z_age i.male implied_birth_year stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
estadd local year_fe "Y"
eststo byear3

* (4) '' with interaction b/w birth year and stdir
regress stockhold_tot z_lnincome z_lnwealth i.college z_age i.male c.implied_birth_year##c.stdir_pres_npos i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
estadd local year_fe "Y"
eststo byear4

* (5) Probit, Y = stockhold, use stdir_pres_npos
probit stockhold z_lnincome z_lnwealth i.college z_age i.male implied_birth_year stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male implied_birth_year stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
estadd local year_fe "Y"
eststo byear5

* (6) '' with interaction b/w birth year and stdir
* Note: margins post will save the AME of the main terms. The interaction term itself won't report a direct margin.
probit stockhold z_lnincome z_lnwealth i.college z_age i.male c.implied_birth_year##c.stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male implied_birth_year stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
estadd local year_fe "Y"
eststo byear6

* (7) Probit, Y = stockhold_tot, use stdir_pres_npos
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male implied_birth_year stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male implied_birth_year stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
estadd local year_fe "Y"
eststo byear7

* (8) '' with interaction b/w birth year and stdir
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male c.implied_birth_year##c.stdir_pres_npos i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male implied_birth_year stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
estadd local year_fe "Y"
eststo byear8


* ==========================================
* Export to single tex file
* ==========================================

* Export all 8 models to reg_stockhold_byear.tex
* - Added mtitles to explicitly state and escape the Y-variables across all 8 columns
* - Added model_type and year_fe to the scalars() list to create the requested rows
* - Removed substitute(\_ _) to ensure the backslash in stockhold\_tot makes it to the .tex file
esttab byear1 byear2 byear3 byear4 byear5 byear6 byear7 byear8 ///
    using "reg_stockhold_byear.tex", replace ///
    keep(z_lnincome z_lnwealth 1.college z_age 1.male implied_birth_year stdir_pres_npos c.implied_birth_year#c.stdir_pres_npos stdir_pres_amt stdir_presvt) ///
    order(z_lnincome z_lnwealth 1.college z_age 1.male implied_birth_year stdir_pres_npos c.implied_birth_year#c.stdir_pres_npos stdir_pres_amt stdir_presvt) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               1.college "College" ///
               z_age "Age [1 SD]" ///
               1.male "Male" ///
               implied_birth_year "Birth Year" ///
               stdir_pres_npos "FEC N (Pos)" ///
               c.implied_birth_year#c.stdir_pres_npos "Birth Year X FEC N (Pos)") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress ///
    mtitles("stockhold(base)" "stockhold(base)" "stockhold(tot)" "stockhold(tot)" "stockhold(base)" "stockhold(base)" "stockhold(tot)" "stockhold(tot)") ///
    scalars("model_type Model" "year_fe Year FE" "r2_comp R-sq") ///
    title("LPM and Probit Margins: Full Sample with Birth Year Control")
	
******************************************************
**# === STDIR: generation
*******************************************************
	
use "basedata.dta", clear
eststo clear

* Calculate implied birth year
gen implied_birth_year = year - age

* View the distribution of observations by birth year
tab implied_birth_year

* View percentiles (useful for splitting the data into equal halves or terciles)
summarize implied_birth_year, detail

* Optional: A visual histogram to see the density of the age cohorts
histogram implied_birth_year, discrete width(1) frequency title("Observations by Birth Year")

* oldgen vs newgen: split at birth year 1964 vs 1965

* ==========================================
* Old Generation: Birth Year <= 1964
* ==========================================

* (1) LPM, Y = stockhold, stdir_pres_npos, implied_birth_year <= 1964
regress stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if implied_birth_year <= 1964, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo gen1

* (2) LPM, Y = stockhold_tot, stdir_pres_npos, implied_birth_year <= 1964
regress stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if implied_birth_year <= 1964, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo gen2

* (3) Probit, Y = stockhold, stdir_pres_npos, implied_birth_year <= 1964
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if implied_birth_year <= 1964, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo gen3

* (4) Probit, Y = stockhold_tot, stdir_pres_npos, implied_birth_year <= 1964
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if implied_birth_year <= 1964, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo gen4


* ==========================================
* New Generation: Birth Year >= 1965
* ==========================================

* (5) LPM, Y = stockhold, stdir_pres_npos, implied_birth_year >= 1965
regress stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if implied_birth_year >= 1965, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo gen5

* (6) LPM, Y = stockhold_tot, stdir_pres_npos, implied_birth_year >= 1965
regress stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if implied_birth_year >= 1965, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
eststo gen6

* (7) Probit, Y = stockhold, stdir_pres_npos, implied_birth_year >= 1965
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if implied_birth_year >= 1965, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo gen7

* (8) Probit, Y = stockhold_tot, stdir_pres_npos, implied_birth_year >= 1965
probit stockhold_tot z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if implied_birth_year >= 1965, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos) post
estadd scalar r2_comp = `p_r2'
eststo gen8


* ==========================================
* Export to single tex file
* ==========================================

* export and save to "reg_stockhold_bygen.tex"
esttab gen1 gen2 gen3 gen4 gen5 gen6 gen7 gen8 ///
    using "reg_stockhold_bygen.tex", replace ///
    keep(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_npos) ///
    order(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_npos) ///
    coeflabels(z_lnincome "Log(Income) [1 SD]" ///
               z_lnwealth "Log(Wealth) [1 SD]" ///
               1.college "College" ///
               z_age "Age [1 SD]" ///
               1.male "Male" ///
               stdir_pres_npos "FEC N (Pos)") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    label booktabs nonotes compress substitute(\_ _) ///
    scalars("r2_comp R-sq") ///
    title("Split Sample by Generation: Pre-1965 vs Post-1965") ///
    mgroups("<= 1964" ">= 1965", pattern(1 0 0 0 1 0 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
    mtitles("LPM" "LPM (Tot)" "Probit" "Probit (Tot)" "LPM" "LPM (Tot)" "Probit" "Probit (Tot)")


	
*************************************************
**# === By state: STOCKHOLD, STDIR, LPM
*************************************************
use "basedata.dta", clear
eststo clear

* 1. Initialize postfile to include separate 'coef' and 'star' variables
tempname memhold
tempfile results
postfile `memhold' fips str2 state_str str15 coef str5 star nobs using `results', replace

* Automatically grab all unique state abbreviations in the dataset
levelsof state_str, local(all_states)

* 2. Loop through every state
foreach s of local all_states {
    display "Running regression for: `s'"
    
    * Extract the FIPS code for the current state
    quietly summarize state if state_str == "`s'", meanonly
    local current_fips = r(mean)
    
    * Run the baseline model, clustering by household
    quietly regress stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if state_str == "`s'", vce(cluster uniqueid)
    
    * Extract coefficient, standard error, and number of observations
    local b = _b[stdir_pres_npos]
    local se = _se[stdir_pres_npos]
    local current_n = e(N)
    
    * Calculate p-value to determine significance stars
    local t_stat = `b' / `se'
    local p_val = 2 * ttail(e(df_r), abs(`t_stat'))
    
    * Assign stars based on p-value thresholds
    local sig_star = ""
    if `p_val' < 0.10 local sig_star "*"
    if `p_val' < 0.05 local sig_star "**"
    if `p_val' < 0.01 local sig_star "***"
    
    * Format the coefficient strictly as a number
    local b_formatted = string(`b', "%9.3f")
    
    * Post these values as separate columns
    post `memhold' (`current_fips') ("`s'") ("`b_formatted'") ("`sig_star'") (`current_n')
}

* Close the postfile
postclose `memhold'

* ==========================================
* 3. Format and Export to a Wrapped LaTeX Table
* ==========================================
use `results', clear

* Sort by FIPS code instead of alphabetical state abbreviation
sort fips

* Generate grid coordinates to wrap the list into 3 column-blocks (17 rows for 51 jurisdictions)
gen row_num = mod(_n-1, 17) + 1
gen col_num = int((_n-1)/17) + 1

* Reshape to wide format
reshape wide fips state_str coef star nobs, i(row_num) j(col_num)

* Open text file to write custom LaTeX code
file open texfile using "bystate_stockhold_stdir_lpm.tex", write replace

* Write LaTeX header (5 columns per block: FIPS, State, Coef, Star, N)
* Using 'r' (right-align) for Coef and 'l' (left-align) for the empty Star column
file write texfile "\begin{table}[htbp]" _n "\centering" _n
file write texfile "\begin{tabular}{c l r l r | c l r l r | c l r l r}" _n "\toprule" _n
file write texfile "FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. \\" _n "\midrule" _n

* Loop through rows and write the data
count
forvalues i = 1/`r(N)' {
    * Block 1
    local f1 = string(fips1[`i'])
    local s1 = state_str1[`i']
    local c1 = coef1[`i']
    local st1 = star1[`i']
    local n1 = trim(string(nobs1[`i'], "%9.0fc"))
    
    * Block 2
    local f2 = cond(missing(state_str2[`i']), "", string(fips2[`i']))
    local s2 = state_str2[`i']
    local c2 = coef2[`i']
    local st2 = star2[`i']
    local n2 = cond(missing(state_str2[`i']), "", trim(string(nobs2[`i'], "%9.0fc")))
    
    * Block 3
    local f3 = cond(missing(state_str3[`i']), "", string(fips3[`i']))
    local s3 = state_str3[`i']
    local c3 = coef3[`i']
    local st3 = star3[`i']
    local n3 = cond(missing(state_str3[`i']), "", trim(string(nobs3[`i'], "%9.0fc")))
    
    file write texfile "`f1' & `s1' & `c1' & `st1' & `n1' & `f2' & `s2' & `c2' & `st2' & `n2' & `f3' & `s3' & `c3' & `st3' & `n3' \\" _n
}

* Write LaTeX footer
file write texfile "\bottomrule" _n "\end{tabular}" _n
file write texfile "\caption{State-level Coefficients on Political Direction (\texttt{stdir\_pres\_npos})}" _n
file write texfile "\end{table}" _n
file close texfile

*************************************************
**# === By state: STOCKHOLD, STALG, LPM
*************************************************
use "basedata.dta", clear
eststo clear

tempname memhold
tempfile results
postfile `memhold' fips str2 state_str str15 coef str5 star nobs using `results', replace

levelsof state_str, local(all_states)

foreach s of local all_states {
    display "Running regression for: `s'"
    
    quietly summarize state if state_str == "`s'", meanonly
    local current_fips = r(mean)
    
    * Changed variable to stalg_pres_npos
    quietly regress stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year if state_str == "`s'", vce(cluster uniqueid)
    
    local b = _b[stalg_pres_npos]
    local se = _se[stalg_pres_npos]
    local current_n = e(N)
    
    local t_stat = `b' / `se'
    local p_val = 2 * ttail(e(df_r), abs(`t_stat'))
    
    local sig_star = ""
    if `p_val' < 0.10 local sig_star "*"
    if `p_val' < 0.05 local sig_star "**"
    if `p_val' < 0.01 local sig_star "***"
    
    local b_formatted = string(`b', "%9.3f")
    
    post `memhold' (`current_fips') ("`s'") ("`b_formatted'") ("`sig_star'") (`current_n')
}

postclose `memhold'

* ==========================================
* Format and Export to a Wrapped LaTeX Table
* ==========================================
use `results', clear

* Sort by FIPS code instead of alphabetical state abbreviation
sort fips

gen row_num = mod(_n-1, 17) + 1
gen col_num = int((_n-1)/17) + 1
reshape wide fips state_str coef star nobs, i(row_num) j(col_num)

* Saving to a new file name for the 'stalg' variation
file open texfile using "bystate_stockhold_stalg_lpm.tex", write replace

file write texfile "\begin{table}[htbp]" _n "\centering" _n
file write texfile "\begin{tabular}{c l r l r | c l r l r | c l r l r}" _n "\toprule" _n
file write texfile "FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. \\" _n "\midrule" _n

count
forvalues i = 1/`r(N)' {
    local f1 = string(fips1[`i'])
    local s1 = state_str1[`i']
    local c1 = coef1[`i']
    local st1 = star1[`i']
    local n1 = trim(string(nobs1[`i'], "%9.0fc"))
    
    local f2 = cond(missing(state_str2[`i']), "", string(fips2[`i']))
    local s2 = state_str2[`i']
    local c2 = coef2[`i']
    local st2 = star2[`i']
    local n2 = cond(missing(state_str2[`i']), "", trim(string(nobs2[`i'], "%9.0fc")))
    
    local f3 = cond(missing(state_str3[`i']), "", string(fips3[`i']))
    local s3 = state_str3[`i']
    local c3 = coef3[`i']
    local st3 = star3[`i']
    local n3 = cond(missing(state_str3[`i']), "", trim(string(nobs3[`i'], "%9.0fc")))
    
    file write texfile "`f1' & `s1' & `c1' & `st1' & `n1' & `f2' & `s2' & `c2' & `st2' & `n2' & `f3' & `s3' & `c3' & `st3' & `n3' \\" _n
}

file write texfile "\bottomrule" _n "\end{tabular}" _n
file write texfile "\caption{State-level Coefficients on Political Alignment (\texttt{stalg\_pres\_npos})}" _n
file write texfile "\end{table}" _n
file close texfile
	

*************************************************
**# === By state: STOCKHOLD, STDIR, PROBIT
*************************************************
use "basedata.dta", clear
eststo clear

tempname memhold
tempfile results
postfile `memhold' fips str2 state_str str15 coef str5 star nobs using `results', replace

levelsof state_str, local(all_states)

foreach s of local all_states {
    display "Running regression for: `s'"
    
    quietly summarize state if state_str == "`s'", meanonly
    local current_fips = r(mean)
    
    quietly probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if state_str == "`s'", vce(cluster uniqueid)
    local current_n = e(N)
    
    quietly margins, dydx(stdir_pres_npos) post
    
    local b = _b[stdir_pres_npos]
    local se = _se[stdir_pres_npos]
    
    local t_stat = `b' / `se'
    capture local df = e(df_r)
    if _rc == 0 & !missing(e(df_r)) {
        local p_val = 2 * ttail(e(df_r), abs(`t_stat'))
    }
    else {
        local p_val = 2 * normal(-abs(`t_stat'))
    }
    
    local sig_star = ""
    if `p_val' < 0.10 local sig_star "*"
    if `p_val' < 0.05 local sig_star "**"
    if `p_val' < 0.01 local sig_star "***"
    
    local b_formatted = string(`b', "%9.3f")
    
    post `memhold' (`current_fips') ("`s'") ("`b_formatted'") ("`sig_star'") (`current_n')
}

postclose `memhold'

* ==========================================
* Format and Export to a Wrapped LaTeX Table
* ==========================================
use `results', clear

sort fips

gen row_num = mod(_n-1, 17) + 1
gen col_num = int((_n-1)/17) + 1
reshape wide fips state_str coef star nobs, i(row_num) j(col_num)

file open texfile using "bystate_stockhold_stdir_probit.tex", write replace

file write texfile "\begin{table}[htbp]" _n "\centering" _n
file write texfile "\begin{tabular}{c l r l r | c l r l r | c l r l r}" _n "\toprule" _n
file write texfile "FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. \\" _n "\midrule" _n

count
forvalues i = 1/`r(N)' {
    local f1 = string(fips1[`i'])
    local s1 = state_str1[`i']
    local c1 = coef1[`i']
    local st1 = star1[`i']
    local n1 = trim(string(nobs1[`i'], "%9.0fc"))
    
    local f2 = cond(missing(state_str2[`i']), "", string(fips2[`i']))
    local s2 = state_str2[`i']
    local c2 = coef2[`i']
    local st2 = star2[`i']
    local n2 = cond(missing(state_str2[`i']), "", trim(string(nobs2[`i'], "%9.0fc")))
    
    local f3 = cond(missing(state_str3[`i']), "", string(fips3[`i']))
    local s3 = state_str3[`i']
    local c3 = coef3[`i']
    local st3 = star3[`i']
    local n3 = cond(missing(state_str3[`i']), "", trim(string(nobs3[`i'], "%9.0fc")))
    
    file write texfile "`f1' & `s1' & `c1' & `st1' & `n1' & `f2' & `s2' & `c2' & `st2' & `n2' & `f3' & `s3' & `c3' & `st3' & `n3' \\" _n
}

file write texfile "\bottomrule" _n "\end{tabular}" _n
file write texfile "\caption{State-level Coefficients on Political Direction (\texttt{stdir\_pres\_npos}) - PROBIT}" _n
file write texfile "\end{table}" _n
file close texfile


*************************************************
**# === By state: STOCKHOLD, STALG, PROBIT
*************************************************
use "basedata.dta", clear
eststo clear

tempname memhold
tempfile results
postfile `memhold' fips str2 state_str str15 coef str5 star nobs using `results', replace

levelsof state_str, local(all_states)

foreach s of local all_states {
    display "Running regression for: `s'"
    
    quietly summarize state if state_str == "`s'", meanonly
    local current_fips = r(mean)
    
    quietly probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year if state_str == "`s'", vce(cluster uniqueid)
    local current_n = e(N)
    
    quietly margins, dydx(stalg_pres_npos) post
    
    local b = _b[stalg_pres_npos]
    local se = _se[stalg_pres_npos]
    
    local t_stat = `b' / `se'
    capture local df = e(df_r)
    if _rc == 0 & !missing(e(df_r)) {
        local p_val = 2 * ttail(e(df_r), abs(`t_stat'))
    }
    else {
        local p_val = 2 * normal(-abs(`t_stat'))
    }
    
    local sig_star = ""
    if `p_val' < 0.10 local sig_star "*"
    if `p_val' < 0.05 local sig_star "**"
    if `p_val' < 0.01 local sig_star "***"
    
    local b_formatted = string(`b', "%9.3f")
    
    post `memhold' (`current_fips') ("`s'") ("`b_formatted'") ("`sig_star'") (`current_n')
}

postclose `memhold'

* ==========================================
* Format and Export to a Wrapped LaTeX Table
* ==========================================
use `results', clear

sort fips

gen row_num = mod(_n-1, 17) + 1
gen col_num = int((_n-1)/17) + 1
reshape wide fips state_str coef star nobs, i(row_num) j(col_num)

file open texfile using "bystate_stockhold_stalg_probit.tex", write replace

file write texfile "\begin{table}[htbp]" _n "\centering" _n
file write texfile "\begin{tabular}{c l r l r | c l r l r | c l r l r}" _n "\toprule" _n
file write texfile "FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. \\" _n "\midrule" _n

count
forvalues i = 1/`r(N)' {
    local f1 = string(fips1[`i'])
    local s1 = state_str1[`i']
    local c1 = coef1[`i']
    local st1 = star1[`i']
    local n1 = trim(string(nobs1[`i'], "%9.0fc"))
    
    local f2 = cond(missing(state_str2[`i']), "", string(fips2[`i']))
    local s2 = state_str2[`i']
    local c2 = coef2[`i']
    local st2 = star2[`i']
    local n2 = cond(missing(state_str2[`i']), "", trim(string(nobs2[`i'], "%9.0fc")))
    
    local f3 = cond(missing(state_str3[`i']), "", string(fips3[`i']))
    local s3 = state_str3[`i']
    local c3 = coef3[`i']
    local st3 = star3[`i']
    local n3 = cond(missing(state_str3[`i']), "", trim(string(nobs3[`i'], "%9.0fc")))
    
    file write texfile "`f1' & `s1' & `c1' & `st1' & `n1' & `f2' & `s2' & `c2' & `st2' & `n2' & `f3' & `s3' & `c3' & `st3' & `n3' \\" _n
}

file write texfile "\bottomrule" _n "\end{tabular}" _n
file write texfile "\caption{State-level Coefficients on Political Alignment (\texttt{stalg\_pres\_npos}) - PROBIT}" _n
file write texfile "\end{table}" _n
file close texfile


*************************************************
**# === By state: STOCKSHARE, STDIR, LPM
*************************************************
use "basedata.dta", clear
eststo clear

tempname memhold
tempfile results
postfile `memhold' fips str2 state_str str15 coef str5 star nobs using `results', replace

levelsof state_str, local(all_states)

foreach s of local all_states {
    display "Running regression for: `s'"
    
    quietly summarize state if state_str == "`s'", meanonly
    local current_fips = r(mean)
    
    quietly regress stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if state_str == "`s'", vce(cluster uniqueid)
    local current_n = e(N)
    
    
    local b = _b[stdir_pres_npos]
    local se = _se[stdir_pres_npos]
    
    local t_stat = `b' / `se'
    capture local df = e(df_r)
    if _rc == 0 & !missing(e(df_r)) {
        local p_val = 2 * ttail(e(df_r), abs(`t_stat'))
    }
    else {
        local p_val = 2 * normal(-abs(`t_stat'))
    }
    
    local sig_star = ""
    if `p_val' < 0.10 local sig_star "*"
    if `p_val' < 0.05 local sig_star "**"
    if `p_val' < 0.01 local sig_star "***"
    
    local b_formatted = string(`b', "%9.3f")
    
    post `memhold' (`current_fips') ("`s'") ("`b_formatted'") ("`sig_star'") (`current_n')
}

postclose `memhold'

* ==========================================
* Format and Export to a Wrapped LaTeX Table
* ==========================================
use `results', clear

sort fips

gen row_num = mod(_n-1, 17) + 1
gen col_num = int((_n-1)/17) + 1
reshape wide fips state_str coef star nobs, i(row_num) j(col_num)

file open texfile using "bystate_stockshare_stdir_lpm.tex", write replace

file write texfile "\begin{table}[htbp]" _n "\centering" _n
file write texfile "\begin{tabular}{c l r l r | c l r l r | c l r l r}" _n "\toprule" _n
file write texfile "FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. \\" _n "\midrule" _n

count
forvalues i = 1/`r(N)' {
    local f1 = string(fips1[`i'])
    local s1 = state_str1[`i']
    local c1 = coef1[`i']
    local st1 = star1[`i']
    local n1 = trim(string(nobs1[`i'], "%9.0fc"))
    
    local f2 = cond(missing(state_str2[`i']), "", string(fips2[`i']))
    local s2 = state_str2[`i']
    local c2 = coef2[`i']
    local st2 = star2[`i']
    local n2 = cond(missing(state_str2[`i']), "", trim(string(nobs2[`i'], "%9.0fc")))
    
    local f3 = cond(missing(state_str3[`i']), "", string(fips3[`i']))
    local s3 = state_str3[`i']
    local c3 = coef3[`i']
    local st3 = star3[`i']
    local n3 = cond(missing(state_str3[`i']), "", trim(string(nobs3[`i'], "%9.0fc")))
    
    file write texfile "`f1' & `s1' & `c1' & `st1' & `n1' & `f2' & `s2' & `c2' & `st2' & `n2' & `f3' & `s3' & `c3' & `st3' & `n3' \\" _n
}

file write texfile "\bottomrule" _n "\end{tabular}" _n
file write texfile "\caption{State-level Coefficients on Political Direction (\texttt{stdir\_pres\_npos}) - LPM}" _n
file write texfile "\end{table}" _n
file close texfile


*************************************************
**# === By state: STOCKSHARE, STALG, LPM
*************************************************
use "basedata.dta", clear
eststo clear

tempname memhold
tempfile results
postfile `memhold' fips str2 state_str str15 coef str5 star nobs using `results', replace

levelsof state_str, local(all_states)

foreach s of local all_states {
    display "Running regression for: `s'"
    
    quietly summarize state if state_str == "`s'", meanonly
    local current_fips = r(mean)
    
    quietly regress stockshare z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year if state_str == "`s'", vce(cluster uniqueid)
    local current_n = e(N)
    
    
    local b = _b[stalg_pres_npos]
    local se = _se[stalg_pres_npos]
    
    local t_stat = `b' / `se'
    capture local df = e(df_r)
    if _rc == 0 & !missing(e(df_r)) {
        local p_val = 2 * ttail(e(df_r), abs(`t_stat'))
    }
    else {
        local p_val = 2 * normal(-abs(`t_stat'))
    }
    
    local sig_star = ""
    if `p_val' < 0.10 local sig_star "*"
    if `p_val' < 0.05 local sig_star "**"
    if `p_val' < 0.01 local sig_star "***"
    
    local b_formatted = string(`b', "%9.3f")
    
    post `memhold' (`current_fips') ("`s'") ("`b_formatted'") ("`sig_star'") (`current_n')
}

postclose `memhold'

* ==========================================
* Format and Export to a Wrapped LaTeX Table
* ==========================================
use `results', clear

sort fips

gen row_num = mod(_n-1, 17) + 1
gen col_num = int((_n-1)/17) + 1
reshape wide fips state_str coef star nobs, i(row_num) j(col_num)

file open texfile using "bystate_stockshare_stalg_lpm.tex", write replace

file write texfile "\begin{table}[htbp]" _n "\centering" _n
file write texfile "\begin{tabular}{c l r l r | c l r l r | c l r l r}" _n "\toprule" _n
file write texfile "FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. \\" _n "\midrule" _n

count
forvalues i = 1/`r(N)' {
    local f1 = string(fips1[`i'])
    local s1 = state_str1[`i']
    local c1 = coef1[`i']
    local st1 = star1[`i']
    local n1 = trim(string(nobs1[`i'], "%9.0fc"))
    
    local f2 = cond(missing(state_str2[`i']), "", string(fips2[`i']))
    local s2 = state_str2[`i']
    local c2 = coef2[`i']
    local st2 = star2[`i']
    local n2 = cond(missing(state_str2[`i']), "", trim(string(nobs2[`i'], "%9.0fc")))
    
    local f3 = cond(missing(state_str3[`i']), "", string(fips3[`i']))
    local s3 = state_str3[`i']
    local c3 = coef3[`i']
    local st3 = star3[`i']
    local n3 = cond(missing(state_str3[`i']), "", trim(string(nobs3[`i'], "%9.0fc")))
    
    file write texfile "`f1' & `s1' & `c1' & `st1' & `n1' & `f2' & `s2' & `c2' & `st2' & `n2' & `f3' & `s3' & `c3' & `st3' & `n3' \\" _n
}

file write texfile "\bottomrule" _n "\end{tabular}" _n
file write texfile "\caption{State-level Coefficients on Political Alignment (\texttt{stalg\_pres\_npos}) - LPM}" _n
file write texfile "\end{table}" _n
file close texfile


*************************************************
**# === By state: STOCKSHARE, STDIR, FRACREG PROBIT
*************************************************
use "basedata.dta", clear
eststo clear

tempname memhold
tempfile results
postfile `memhold' fips str2 state_str str15 coef str5 star nobs using `results', replace

levelsof state_str, local(all_states)

foreach s of local all_states {
    display "Running regression for: `s'"
    
    quietly summarize state if state_str == "`s'", meanonly
    local current_fips = r(mean)
    
    quietly fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if state_str == "`s'", vce(cluster uniqueid)
    local current_n = e(N)
    
    quietly margins, dydx(stdir_pres_npos) post
    
    local b = _b[stdir_pres_npos]
    local se = _se[stdir_pres_npos]
    
    local t_stat = `b' / `se'
    capture local df = e(df_r)
    if _rc == 0 & !missing(e(df_r)) {
        local p_val = 2 * ttail(e(df_r), abs(`t_stat'))
    }
    else {
        local p_val = 2 * normal(-abs(`t_stat'))
    }
    
    local sig_star = ""
    if `p_val' < 0.10 local sig_star "*"
    if `p_val' < 0.05 local sig_star "**"
    if `p_val' < 0.01 local sig_star "***"
    
    local b_formatted = string(`b', "%9.3f")
    
    post `memhold' (`current_fips') ("`s'") ("`b_formatted'") ("`sig_star'") (`current_n')
}

postclose `memhold'

* ==========================================
* Format and Export to a Wrapped LaTeX Table
* ==========================================
use `results', clear

sort fips

gen row_num = mod(_n-1, 17) + 1
gen col_num = int((_n-1)/17) + 1
reshape wide fips state_str coef star nobs, i(row_num) j(col_num)

file open texfile using "bystate_stockshare_stdir_fracreg.tex", write replace

file write texfile "\begin{table}[htbp]" _n "\centering" _n
file write texfile "\begin{tabular}{c l r l r | c l r l r | c l r l r}" _n "\toprule" _n
file write texfile "FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. \\" _n "\midrule" _n

count
forvalues i = 1/`r(N)' {
    local f1 = string(fips1[`i'])
    local s1 = state_str1[`i']
    local c1 = coef1[`i']
    local st1 = star1[`i']
    local n1 = trim(string(nobs1[`i'], "%9.0fc"))
    
    local f2 = cond(missing(state_str2[`i']), "", string(fips2[`i']))
    local s2 = state_str2[`i']
    local c2 = coef2[`i']
    local st2 = star2[`i']
    local n2 = cond(missing(state_str2[`i']), "", trim(string(nobs2[`i'], "%9.0fc")))
    
    local f3 = cond(missing(state_str3[`i']), "", string(fips3[`i']))
    local s3 = state_str3[`i']
    local c3 = coef3[`i']
    local st3 = star3[`i']
    local n3 = cond(missing(state_str3[`i']), "", trim(string(nobs3[`i'], "%9.0fc")))
    
    file write texfile "`f1' & `s1' & `c1' & `st1' & `n1' & `f2' & `s2' & `c2' & `st2' & `n2' & `f3' & `s3' & `c3' & `st3' & `n3' \\" _n
}

file write texfile "\bottomrule" _n "\end{tabular}" _n
file write texfile "\caption{State-level Coefficients on Political Direction (\texttt{stdir\_pres\_npos}) - FRACREG PROBIT}" _n
file write texfile "\end{table}" _n
file close texfile


*************************************************
**# === By state: STOCKSHARE, STALG, FRACREG PROBIT
*************************************************
use "basedata.dta", clear
eststo clear

tempname memhold
tempfile results
postfile `memhold' fips str2 state_str str15 coef str5 star nobs using `results', replace

levelsof state_str, local(all_states)

foreach s of local all_states {
    display "Running regression for: `s'"
    
    quietly summarize state if state_str == "`s'", meanonly
    local current_fips = r(mean)
    
    quietly fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stalg_pres_npos i.year if state_str == "`s'", vce(cluster uniqueid)
    local current_n = e(N)
    
    quietly margins, dydx(stalg_pres_npos) post
    
    local b = _b[stalg_pres_npos]
    local se = _se[stalg_pres_npos]
    
    local t_stat = `b' / `se'
    capture local df = e(df_r)
    if _rc == 0 & !missing(e(df_r)) {
        local p_val = 2 * ttail(e(df_r), abs(`t_stat'))
    }
    else {
        local p_val = 2 * normal(-abs(`t_stat'))
    }
    
    local sig_star = ""
    if `p_val' < 0.10 local sig_star "*"
    if `p_val' < 0.05 local sig_star "**"
    if `p_val' < 0.01 local sig_star "***"
    
    local b_formatted = string(`b', "%9.3f")
    
    post `memhold' (`current_fips') ("`s'") ("`b_formatted'") ("`sig_star'") (`current_n')
}

postclose `memhold'

* ==========================================
* Format and Export to a Wrapped LaTeX Table
* ==========================================
use `results', clear

sort fips

gen row_num = mod(_n-1, 17) + 1
gen col_num = int((_n-1)/17) + 1
reshape wide fips state_str coef star nobs, i(row_num) j(col_num)

file open texfile using "bystate_stockshare_stalg_fracreg.tex", write replace

file write texfile "\begin{table}[htbp]" _n "\centering" _n
file write texfile "\begin{tabular}{c l r l r | c l r l r | c l r l r}" _n "\toprule" _n
file write texfile "FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. & FIPS & State & Coef. & & Obs. \\" _n "\midrule" _n

count
forvalues i = 1/`r(N)' {
    local f1 = string(fips1[`i'])
    local s1 = state_str1[`i']
    local c1 = coef1[`i']
    local st1 = star1[`i']
    local n1 = trim(string(nobs1[`i'], "%9.0fc"))
    
    local f2 = cond(missing(state_str2[`i']), "", string(fips2[`i']))
    local s2 = state_str2[`i']
    local c2 = coef2[`i']
    local st2 = star2[`i']
    local n2 = cond(missing(state_str2[`i']), "", trim(string(nobs2[`i'], "%9.0fc")))
    
    local f3 = cond(missing(state_str3[`i']), "", string(fips3[`i']))
    local s3 = state_str3[`i']
    local c3 = coef3[`i']
    local st3 = star3[`i']
    local n3 = cond(missing(state_str3[`i']), "", trim(string(nobs3[`i'], "%9.0fc")))
    
    file write texfile "`f1' & `s1' & `c1' & `st1' & `n1' & `f2' & `s2' & `c2' & `st2' & `n2' & `f3' & `s3' & `c3' & `st3' & `n3' \\" _n
}

file write texfile "\bottomrule" _n "\end{tabular}" _n
file write texfile "\caption{State-level Coefficients on Political Alignment (\texttt{stalg\_pres\_npos}) - FRACREG PROBIT}" _n
file write texfile "\end{table}" _n
file close texfile


