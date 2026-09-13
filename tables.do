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

save "tabledata.dta", replace

*========================================================================================================
*========================================================================================================
*========================================================================================================

********************************************
**# ===Table 1: Summary Statistics Table====
****************************************
use "tabledata.dta", clear

* It is usually best to summarize the unstandardized continuous variables 
* (lnincome, lnwealth, age) alongside the binaries and shares.
local sumvars stockhold income wealth college age male  ///
	stdir_pres_amt stdir_pres_npos ///
	fedir ///
	stalg_pres_amt stalg_pres_npos

* Use estpost summarize with the detail option to capture quantiles
quietly estpost summarize `sumvars', detail

* Export to LaTeX using esttab
* The cells() option allows us to select specific statistics and set their formats
esttab . using "./thesis/tables/tb1.tex", replace ///
    cells("count(fmt(%9.0fc) label(N)) mean(fmt(3) label(Mean)) sd(fmt(3) label(SD)) p25(fmt(3) label(25th)) p50(fmt(3) label(Median)) p75(fmt(3) label(75th))") ///
    noobs nomtitle nonumber ///
    coeflabels(stockhold    "1(Stockhold)" ///
               lnincome     "Income" ///
               lnwealth     "Wealth" ///
               college      "1(College)" ///
               age          "Age" ///
               male         "1(Male)" ///
			   stdir_pres_amt "STDIR(A)" ///
			   stdir_pres_npos "STDIR(N)" ///
			   fedir        "FEDIR" ///
               stalg_pres_amt "STALG(A)" ///
			   stalg_pres_npos "STALG(N)" ) ///
    booktabs nonotes compress ///
    substitute("\begin{tabular}{l*{1}{cccccc}}" "\begin{tabular*}{\textwidth}{l@{\extracolsep{\fill}}*{6}{c}}" "\end{tabular}" "\end{tabular*}")




********************************************
**# ===Table 2: Baseline checking====
****************************************
use "tabledata.dta", clear

eststo clear

* (1) Controls + year FE, LPM
quietly regress stockhold z_lnincome z_lnwealth college z_age male i.year, vce(robust)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
estadd local state_fe "No"
estadd local year_fe "Yes"
estadd local state_stat "-"
estadd local state_pval "-"
eststo m1

* (2) Controls + state FE + year FE, LPM
quietly regress stockhold z_lnincome z_lnwealth college z_age male i.state i.year, vce(robust)
quietly testparm i.state
estadd local state_stat = string(r(F), "%8.2e")
estadd local state_pval = string(r(p), "%8.2e")
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
estadd local state_fe "Yes"
estadd local year_fe "Yes"
eststo m2

* (3) Controls + year FE, Probit
quietly probit stockhold z_lnincome z_lnwealth i.college z_age i.male i.year, vce(robust)
local p_r2 = e(r2_p)
quietly margins, dydx(z_lnincome z_lnwealth i.college z_age i.male) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
estadd local state_fe "No"
estadd local year_fe "Yes"
estadd local state_stat "-"
estadd local state_pval "-"
eststo m3

* (4) Controls + state FE + year FE, Probit
quietly probit stockhold z_lnincome z_lnwealth i.college z_age i.male i.state i.year, vce(robust)
quietly testparm i.state
* Save testparm scalars to locals before margins overwrites them
local stat_val = string(r(chi2), "%8.2e")
local p_val = string(r(p), "%8.2e")
local p_r2 = e(r2_p)

quietly margins, dydx(z_lnincome z_lnwealth i.college z_age i.male) post

estadd local state_stat = "`stat_val'"
estadd local state_pval = "`p_val'"
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
estadd local state_fe "Yes"
estadd local year_fe "Yes"
eststo m4

* Export Baseline Checking to LaTeX
esttab m1 m2 m3 m4 using "./thesis/tables/tb2.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male) ///
    coeflabels(z_lnincome "ln(Income)" ///
               z_lnwealth "ln(Wealth)" ///
               college    "1(College)" ///
               z_age      "Age" ///
               male       "1(Male)") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    mgroups("LPM" "Probit", pattern(1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
    mtitles("stockhold" "stockhold" "stockhold" "stockhold") ///
    scalars("state_fe State FE" ///
            "year_fe Year FE" ///
            "state_stat State Joint Stat." ///
            "state_pval State P-Value" ///
            "r2_comp R-sq") ///
    nobaselevels booktabs nonotes compress ///
    substitute("\begin{tabular}{l*{4}{c}}" "\begin{tabular*}{\textwidth}{l@{\extracolsep{\fill}}*{4}{c}}" "\end{tabular}" "\end{tabular*}")

********************************************
**# ===Table 3A: LPM, STOCKHOLD====
****************************************
use "tabledata.dta", clear

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
esttab lpm1 lpm2 lpm3 lpm4 lpm5 lpm6 using "./thesis/tables/tb3A.tex", replace ///
    keep(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    coeflabels(z_lnincome "ln(Income)" ///
               z_lnwealth "ln(Wealth)" ///
			   college "1(College)" ///
               z_age "Age" ///
			   male "1(Male)" ///
               stdir_pres_amt "STDIR(A)" ///
               stdir_pres_npos "STDIR(N)" ///
               stalg_pres_amt "STALG(A)" ///
               stalg_pres_npos "STALG(N)" ///
               fedir "FEDIR") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    mtitles("stockhold" "stockhold" "stockhold" "stockhold" "stockhold" "stockhold") ///
    label booktabs nonotes ///
    stats(N r2_comp, fmt(%9.0fc 3) labels("Obs." "R-sq"))


********************************************
**# ===Table 3B: Probit, STOCKHOLD====
****************************************
use "tabledata.dta", clear
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
esttab prob1 prob2 prob3 prob4 prob5 prob6 using "./thesis/tables/tb3B.tex", replace ///
    keep(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    order(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    coeflabels(z_lnincome "ln(Income)" ///
               z_lnwealth "ln(Wealth)" ///
               college "1(College)" ///
               z_age "Age" ///
			   male "1(Male)" ///
               stdir_pres_amt "STDIR(A)" ///
               stdir_pres_npos "STDIR(N)" ///
               stalg_pres_amt "STALG(A)" ///
               stalg_pres_npos "STALG(N)" ///
               fedir "FEDIR") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    mtitles("stockhold" "stockhold" "stockhold" "stockhold" "stockhold" "stockhold") ///
    label booktabs nonotes ///
    stats(N r2_comp, fmt(%9.0fc 3) labels("Obs." "R-sq"))


********************************************
**# ===Table 4A: LPM, STOCKSHARE ====
****************************************
use "tabledata.dta", clear

keep if stockhold == 1

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
esttab lpm1 lpm2 lpm3 lpm4 lpm5 lpm6 using "./thesis/tables/tb4A.tex", replace ///
    keep(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    coeflabels(z_lnincome "ln(Income)" ///
               z_lnwealth "ln(Wealth)" ///
               z_age "Age" ///
               stdir_pres_amt "STDIR(A)" ///
               stdir_pres_npos "STDIR(N)" ///
               stalg_pres_amt "STALG(A)" ///
               stalg_pres_npos "STALG(N)" ///
               fedir "FEDIR") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    mtitles("stockshare" "stockshare" "stockshare" "stockshare" "stockshare" "stockshare") ///
    label booktabs nonotes ///
    stats(N r2_comp, fmt(%9.0fc 3) labels("Obs." "R-sq"))


********************************************
**# ===Table 4B: Probit, STOCKSHARE====
****************************************

use "tabledata.dta", clear
eststo clear

keep if stockhold == 1

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
esttab prob1 prob2 prob3 prob4 prob5 prob6 using "./thesis/tables/tb4B.tex", replace ///
    keep(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    order(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos fedir) ///
    coeflabels(z_lnincome "ln(Income)" ///
               z_lnwealth "ln(Wealth)" ///
               z_age "Age" ///
               stdir_pres_amt "STDIR(A)" ///
               stdir_pres_npos "STDIR(N)" ///
               stalg_pres_amt "STALG(A)" ///
               stalg_pres_npos "STALG(N)" ///
               fedir "FEDIR") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    mtitles("stockshare" "stockshare" "stockshare" "stockshare" "stockshare" "stockshare") ///
    label booktabs nonotes ///
    stats(N r2_comp, fmt(%9.0fc 3) labels("Obs." "R-sq"))
	
	
********************************************
**# ===Table 5A: presvt, LPM (Panel A) ====
****************************************
use "tabledata.dta", clear
eststo clear

* --- Full Sample: stockhold ---

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

* --- Subsample: stockshare ---
keep if stockhold == 1

* (4) LPM, stdir_presvt (stockshare)
regress stockshare z_lnincome z_lnwealth college z_age male stdir_presvt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo s1

* (5) LPM, stalg_presvt (stockshare)
regress stockshare z_lnincome z_lnwealth college z_age male stalg_presvt i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo s2

* (6) LPM, stdir_presvt + stalg_presvt + fedir (stockshare)
regress stockshare z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir i.year, vce(cluster state)
estadd scalar r2_comp = e(r2_a)
estadd local model_type "LPM"
eststo s3

* Export Panel A (LPM only) to LaTeX
esttab m1 m2 m3 s1 s2 s3 using "./thesis/tables/tb5A.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir) ///
    coeflabels(z_lnincome "ln(Income)" ///
               z_lnwealth "ln(Wealth)" ///
               college "1(College)" ///
               z_age "Age" ///
               male "1(Male)" ///
               stdir_presvt "STDIR(V)" ///
               stalg_presvt "STALG(V)" ///
               fedir "FEDIR") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    mgroups("stockhold" "stockshare", pattern(1 0 0 1 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
    mtitles("LPM" "LPM" "LPM" "OLS" "OLS" "OLS") ///
    label booktabs nonotes compress ///
    stats(N r2_comp, fmt(%9.0fc 3) labels("Obs." "R-sq")) ///
	substitute("\begin{tabular}{l*{6}{c}}" "\begin{tabular*}{\textwidth}{l@{\extracolsep{\fill}}*{6}{c}}" "\end{tabular}" "\end{tabular*}")


********************************************
**# ===Table 5B: presvt, Probit/Fracreg (Panel B) ====
****************************************
* Reload full data for the stockhold probits
use "tabledata.dta", clear
eststo clear

* --- Full Sample: stockhold ---

* (1) Probit, stdir_presvt
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_presvt) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m4

* (2) Probit, stalg_presvt
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stalg_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stalg_presvt) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m5

* (3) Probit, stdir_presvt + stalg_presvt + fedir
probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_presvt stalg_presvt fedir i.year, vce(cluster state)
local p_r2 = e(r2_p)
margins, dydx(z_lnincome z_lnwealth i.college z_age i.male stdir_presvt stalg_presvt fedir) post
estadd scalar r2_comp = `p_r2'
estadd local model_type "Probit"
eststo m6

* --- Subsample: stockshare ---
keep if stockhold == 1

* (4) Fracreg, stdir_presvt
fracreg probit stockshare z_lnincome z_lnwealth i.college z_age i.male stdir_presvt i.year, vce(cluster state)
local p_r2 = e(r2_p)
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

* Export Panel B (Probit only) to LaTeX
esttab m4 m5 m6 s4 s5 s6 using "./thesis/tables/tb5B.tex", replace ///
    rename(1.college college 1.male male) ///
    keep(z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir) ///
    order(z_lnincome z_lnwealth college z_age male stdir_presvt stalg_presvt fedir) ///
    coeflabels(z_lnincome "ln(Income)" ///
               z_lnwealth "ln(Wealth)" ///
               college "1(College)" ///
               z_age "Age" ///
               male "1(Male)" ///
               stdir_presvt "STDIR(V)" ///
               stalg_presvt "STALG(V)" ///
               fedir "FEDIR") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    mgroups("stockhold" "stockshare", pattern(1 0 0 1 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
    mtitles("Probit" "Probit" "Probit" "Frac. Probit" "Frac. Probit" "Frac. Probit") ///
    label booktabs nonotes compress ///
    stats(N r2_comp, fmt(%9.0fc 3) labels("Obs." "R-sq")) ///
    substitute("\begin{tabular}{l*{6}{c}}" "\begin{tabular*}{\textwidth}{l@{\extracolsep{\fill}}*{6}{c}}" "\end{tabular}" "\end{tabular*}")


********************************************
**# ===Table 6A: LPM, STOCKHOLD VARIATIONS (1-12) ====
********************************************
use "tabledata.dta", clear
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
esttab lpm1 lpm2 lpm3 lpm4 lpm5 lpm6 lpm7 lpm8 lpm9 lpm10 lpm11 lpm12 using "./thesis/tables/tb6A.tex", replace ///
    keep(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos) ///
    order(z_lnincome z_lnwealth college z_age male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos) ///
    coeflabels(z_lnincome "ln(Income)" ///
               z_lnwealth "ln(Wealth)" ///
               z_age "Age" ///
               stdir_pres_amt "STDIR(A)" ///
               stdir_pres_npos "STDIR(N)" ///
               stalg_pres_amt "STALG(A)" ///
               stalg_pres_npos "STALG(N)") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    mgroups("Total Participation" "IRA Accounts" "Pension Plans", pattern(1 0 0 0 1 0 0 0 1 0 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
    nomtitles /// <-- This hides the repetitive column titles
    label booktabs nonotes compress ///
    stats(N r2_comp, fmt(%9.0fc 3) labels("Obs." "R-sq")) ///
    substitute("\begin{tabular}{l*{12}{c}}" "\begin{tabular*}{\linewidth}{l@{\extracolsep{\fill}}*{12}{c}}" "\end{tabular}" "\end{tabular*}")

********************************************
**# ===Table 6B: PROBIT, STOCKHOLD VARIATIONS (13-24) ====
********************************************
use "tabledata.dta", clear
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
esttab prob1 prob2 prob3 prob4 prob5 prob6 prob7 prob8 prob9 prob10 prob11 prob12 using "./thesis/tables/tb6B.tex", replace ///
    keep(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos) ///
    order(z_lnincome z_lnwealth 1.college z_age 1.male stdir_pres_amt stdir_pres_npos stalg_pres_amt stalg_pres_npos) ///
    coeflabels(z_lnincome "ln(Income)" ///
               z_lnwealth "ln(Wealth)" ///
               z_age "Age" ///
               stdir_pres_amt "STDIR(A)" ///
               stdir_pres_npos "STDIR(N)" ///
               stalg_pres_amt "STALG(A)" ///
               stalg_pres_npos "STALG(N)") ///
    b(3) se(3) star(* 0.10 ** 0.05 *** 0.01) ///
    mgroups("Total Participation" "IRA Accounts" "Pension Plans", pattern(1 0 0 0 1 0 0 0 1 0 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span) ///
    nomtitles /// <-- Hides column titles
    label booktabs nonotes compress ///
    stats(N r2_comp, fmt(%9.0fc 3) labels("Obs." "R-sq")) ///
    substitute("\begin{tabular}{l*{12}{c}}" "\begin{tabular*}{\linewidth}{l@{\extracolsep{\fill}}*{12}{c}}" "\end{tabular}" "\end{tabular*}")

*************************************************
**# ===Table 7A: By state, STOCKHOLD, STDIR, LPM
*************************************************
use "tabledata.dta", clear
eststo clear

* 1. Initialize postfile
tempname memhold
tempfile results
postfile `memhold' fips str2 state_str str15 coef str5 star str15 stderr nobs using `results', replace

* Automatically grab all unique state abbreviations
levelsof state_str, local(all_states)

* 2. Loop through every state
foreach s of local all_states {
    display "Running LPM for: `s'"
    
    * Extract the FIPS code
    quietly summarize state if state_str == "`s'", meanonly
    local current_fips = r(mean)
    
    * Run the LPM model
    quietly regress stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if state_str == "`s'", vce(cluster uniqueid)
    
    * Extract values
    local b = _b[stdir_pres_npos]
    local stderr_val = _se[stdir_pres_npos]
    local current_n = e(N)
    
    * Calculate p-value (t-distribution for regress)
    local t_stat = `b' / `stderr_val'
    local p_val = 2 * ttail(e(df_r), abs(`t_stat'))
    
    * Assign stars
    local sig_star = ""
    if `p_val' < 0.10 local sig_star "*"
    if `p_val' < 0.05 local sig_star "**"
    if `p_val' < 0.01 local sig_star "***"
    
    * Format outputs
    local b_formatted = string(`b', "%9.3f")
    local se_formatted = "(" + string(`stderr_val', "%9.3f") + ")"
    
    post `memhold' (`current_fips') ("`s'") ("`b_formatted'") ("`sig_star'") ("`se_formatted'") (`current_n')
}

postclose `memhold'

* ==========================================
* 3. Format and Export to tb7A.tex
* ==========================================
use `results', clear

sort fips

gen row_num = mod(_n-1, 17) + 1
gen col_num = int((_n-1)/17) + 1

* Reshape including the renamed 'stderr'
reshape wide fips state_str coef star stderr nobs, i(row_num) j(col_num)

file open texfile using "./thesis/tables/tb7A.tex", write replace

file write texfile "\begin{tabular}{c l r l r r | c l r l r r | c l r l r r}" _n "\hline" _n
file write texfile "FIPS & State & Coef. & & \multicolumn{1}{c}{SE} & Obs. & FIPS & State & Coef. & & \multicolumn{1}{c}{SE} & Obs. & FIPS & State & Coef. & & \multicolumn{1}{c}{SE} & Obs. \\" _n "\hline" _n

count
forvalues i = 1/`r(N)' {
    local f1 = string(fips1[`i'])
    local s1 = state_str1[`i']
    local c1 = coef1[`i']
    local st1 = star1[`i']
    local se1 = stderr1[`i']
    local n1 = trim(string(nobs1[`i'], "%9.0fc"))
    
    local f2 = cond(missing(state_str2[`i']), "", string(fips2[`i']))
    local s2 = state_str2[`i']
    local c2 = coef2[`i']
    local st2 = star2[`i']
    local se2 = cond(missing(state_str2[`i']), "", stderr2[`i'])
    local n2 = cond(missing(state_str2[`i']), "", trim(string(nobs2[`i'], "%9.0fc")))
    
    local f3 = cond(missing(state_str3[`i']), "", string(fips3[`i']))
    local s3 = state_str3[`i']
    local c3 = coef3[`i']
    local st3 = star3[`i']
    local se3 = cond(missing(state_str3[`i']), "", stderr3[`i'])
    local n3 = cond(missing(state_str3[`i']), "", trim(string(nobs3[`i'], "%9.0fc")))
    
    file write texfile "`f1' & `s1' & `c1' & `st1' & `se1' & `n1' & `f2' & `s2' & `c2' & `st2' & `se2' & `n2' & `f3' & `s3' & `c3' & `st3' & `se3' & `n3' \\" _n
}

file write texfile "\hline" _n "\end{tabular}" _n
file close texfile

*************************************************
**# ===Table 7B: By state, STOCKHOLD, STDIR, PROBIT
*************************************************
use "tabledata.dta", clear
eststo clear

* 1. Initialize postfile
tempname memhold
tempfile results
postfile `memhold' fips str2 state_str str15 coef str5 star str15 stderr nobs using `results', replace

levelsof state_str, local(all_states)

* 2. Loop through every state
foreach s of local all_states {
    display "Running Probit for: `s'"
    
    * Extract the FIPS code
    quietly summarize state if state_str == "`s'", meanonly
    local current_fips = r(mean)
    
    * Run the Probit model
    quietly probit stockhold z_lnincome z_lnwealth i.college z_age i.male stdir_pres_npos i.year if state_str == "`s'", vce(cluster uniqueid)
    
    * Extract values
    local b = _b[stdir_pres_npos]
    local stderr_val = _se[stdir_pres_npos]
    local current_n = e(N)
    
    * Calculate p-value (z-distribution for probit)
    local z_stat = `b' / `stderr_val'
    local p_val = 2 * normal(-abs(`z_stat'))
    
    * Assign stars
    local sig_star = ""
    if `p_val' < 0.10 local sig_star "*"
    if `p_val' < 0.05 local sig_star "**"
    if `p_val' < 0.01 local sig_star "***"
    
    * Format outputs
    local b_formatted = string(`b', "%9.3f")
    local se_formatted = "(" + string(`stderr_val', "%9.3f") + ")"
    
    post `memhold' (`current_fips') ("`s'") ("`b_formatted'") ("`sig_star'") ("`se_formatted'") (`current_n')
}

postclose `memhold'

* ==========================================
* 3. Format and Export to tb7B.tex
* ==========================================
use `results', clear

sort fips

gen row_num = mod(_n-1, 17) + 1
gen col_num = int((_n-1)/17) + 1

reshape wide fips state_str coef star stderr nobs, i(row_num) j(col_num)

file open texfile using "./thesis/tables/tb7B.tex", write replace

file write texfile "\begin{tabular}{c l r l r r | c l r l r r | c l r l r r}" _n "\hline" _n
file write texfile "FIPS & State & Coef. & & \multicolumn{1}{c}{SE} & Obs. & FIPS & State & Coef. & & \multicolumn{1}{c}{SE} & Obs. & FIPS & State & Coef. & & \multicolumn{1}{c}{SE} & Obs. \\" _n "\hline" _n

count
forvalues i = 1/`r(N)' {
    local f1 = string(fips1[`i'])
    local s1 = state_str1[`i']
    local c1 = coef1[`i']
    local st1 = star1[`i']
    local se1 = stderr1[`i']
    local n1 = trim(string(nobs1[`i'], "%9.0fc"))
    
    local f2 = cond(missing(state_str2[`i']), "", string(fips2[`i']))
    local s2 = state_str2[`i']
    local c2 = coef2[`i']
    local st2 = star2[`i']
    local se2 = cond(missing(state_str2[`i']), "", stderr2[`i'])
    local n2 = cond(missing(state_str2[`i']), "", trim(string(nobs2[`i'], "%9.0fc")))
    
    local f3 = cond(missing(state_str3[`i']), "", string(fips3[`i']))
    local s3 = state_str3[`i']
    local c3 = coef3[`i']
    local st3 = star3[`i']
    local se3 = cond(missing(state_str3[`i']), "", stderr3[`i'])
    local n3 = cond(missing(state_str3[`i']), "", trim(string(nobs3[`i'], "%9.0fc")))
    
    file write texfile "`f1' & `s1' & `c1' & `st1' & `se1' & `n1' & `f2' & `s2' & `c2' & `st2' & `se2' & `n2' & `f3' & `s3' & `c3' & `st3' & `se3' & `n3' \\" _n
}

file write texfile "\hline" _n "\end{tabular}" _n
file close texfile



* ==============================================================================
**# ===Table B1: screened committees
* ==============================================================================
* ==============================================================================
* STATA CODE: EXTRACT AND EXPORT CUSTOM PAGINATED TABLES TO LATEX
* ==============================================================================

clear all
set more off

// 1. Load the performance metrics data[cite: 1]
import delimited "./FEC/comm_for_manual_screening.csv", clear 
rename year cmte_election_year

tempfile metrics
save "`metrics'"

// 2. Load the finalized selected committees file[cite: 1]
import delimited "./FEC/committees_selected.csv", clear 

// 3. Merge files to retain only the finally selected committees[cite: 1]
merge 1:1 cmte_id cmte_election_year using "`metrics'", keep(match) nogenerate

// 4. Sort and calculate ranks within each election year by transaction counts[cite: 1]
gsort + cmte_election_year - n_trans
by cmte_election_year: gen Rank = _n

// 5. Filter for the top 10 committees per election year
keep if Rank <= 10

// 6. Keep and rename required columns (Dropping Rank as requested)
keep cmte_election_year cmte_nm cmte_party n_trans tot_amt
rename cmte_election_year Year
rename cmte_nm            Committee_Name
rename cmte_party         Party
rename n_trans            N
rename tot_amt            Amount

// 7. Clean up committee text for safe LaTeX rendering[cite: 1]
replace Committee_Name = subinstr(Committee_Name, "&", "\&", .)
replace Committee_Name = subinstr(Committee_Name, "%", "\%", .)

// 8. Create a 'print_year' variable that is blank for duplicate years
gen print_year = string(Year)
by Year: replace print_year = "" if _n > 1

// 9. Custom File Export to construct the specific LaTeX environments
capture file close texfile
file open texfile using "./thesis/tables/tbB1.tex", write replace

local N_obs = _N

// ---------------------------------------------------------
// TABLE 1: 1996 - 2000
// ---------------------------------------------------------
file write texfile "\begin{table}[tbp] \centering" _n
file write texfile "\newcolumntype{R}{>{\raggedleft\arraybackslash}X}" _n
file write texfile "\newcolumntype{L}{>{\raggedright\arraybackslash}X}" _n
file write texfile "\newcolumntype{C}{>{\centering\arraybackslash}X}" _n _n
file write texfile "\caption{Top 10 Selected Committees by Election Year}" _n
file write texfile "\label{tab:B1}" _n _n
file write texfile "\footnotesize" _n
file write texfile "\begin{tabularx}{\linewidth}{c L c r r}" _n _n // 5 columns
file write texfile "\toprule" _n
file write texfile "{Year}&{Committee Name}&{Party}&{N}&{Amount} \tabularnewline" _n
file write texfile "\midrule \addlinespace[\belowrulesep]" _n

forval i = 1/`N_obs' {
    if Year[`i'] <= 2004 {
        local yr = print_year[`i']
        local cm = Committee_Name[`i']
        local pt = Party[`i']
        local nn = N[`i']
        local am = Amount[`i']
        file write texfile "`yr'&`cm'&`pt'&`nn'&`am' \tabularnewline" _n
    }
}
file write texfile "\bottomrule" _n _n "\end{tabularx}" _n "\end{table}" _n _n _n


// ---------------------------------------------------------
// TABLE 2: 2004 - 2012
// ---------------------------------------------------------
file write texfile "\begin{table}[tbp] \centering" _n
file write texfile "\newcolumntype{R}{>{\raggedleft\arraybackslash}X}" _n
file write texfile "\newcolumntype{L}{>{\raggedright\arraybackslash}X}" _n
file write texfile "\newcolumntype{C}{>{\centering\arraybackslash}X}" _n _n
file write texfile "\ContinuedFloat" _n
file write texfile "\caption[]{Top 10 Selected Committees by Election Year}" _n
file write texfile "\footnotesize" _n
file write texfile "\begin{tabularx}{\linewidth}{c L c r r}" _n _n
file write texfile "\toprule" _n
file write texfile "{Year}&{Committee Name}&{Party}&{N}&{Amount} \tabularnewline" _n
file write texfile "\midrule \addlinespace[\belowrulesep]" _n

forval i = 1/`N_obs' {
    if Year[`i'] >= 2008 & Year[`i'] <= 2016 {
        local yr = print_year[`i']
        local cm = Committee_Name[`i']
        local pt = Party[`i']
        local nn = N[`i']
        local am = Amount[`i']
        file write texfile "`yr'&`cm'&`pt'&`nn'&`am' \tabularnewline" _n
    }
}
file write texfile "\bottomrule" _n _n "\end{tabularx}" _n "\end{table}" _n _n _n


// ---------------------------------------------------------
// TABLE 3: 2016 - 2020 (With ContinuedFloat)
// ---------------------------------------------------------
file write texfile "\begin{table}[tbp] \centering" _n
file write texfile "\newcolumntype{R}{>{\raggedleft\arraybackslash}X}" _n
file write texfile "\newcolumntype{L}{>{\raggedright\arraybackslash}X}" _n
file write texfile "\newcolumntype{C}{>{\centering\arraybackslash}X}" _n _n
file write texfile "\ContinuedFloat" _n
file write texfile "\caption[]{Top 10 Selected Committees by Election Year (Cont.)}" _n _n
file write texfile "\footnotesize" _n
file write texfile "\begin{tabularx}{\linewidth}{c L c r r}" _n _n
file write texfile "\toprule" _n
file write texfile "{Year}&{Committee Name}&{Party}&{N}&{Amount} \tabularnewline" _n
file write texfile "\midrule \addlinespace[\belowrulesep]" _n

forval i = 1/`N_obs' {
    if Year[`i'] >= 2020 {
        local yr = print_year[`i']
        local cm = Committee_Name[`i']
        local pt = Party[`i']
        local nn = N[`i']
        local am = Amount[`i']
        file write texfile "`yr'&`cm'&`pt'&`nn'&`am' \tabularnewline" _n
    }
}
file write texfile "\bottomrule" _n _n "\end{tabularx}" _n "\end{table}" _n

// Close the file output
file close texfile

display "LaTeX table exported successfully to ./thesis/tables/tbB1.tex"