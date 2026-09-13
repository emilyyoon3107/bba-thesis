
label define ER13001L  ///
       1 "Release number 1 - August 2001"  ///
       2 "Release number 2 - October 2001"  ///
       3 "Release number 3 - January 2002"  ///
       4 "Release number 4 - May 2008"  ///
       5 "Release number 5 - November 2013"  ///
       6 "Release number 6 - February 2014"  ///
       7 "Release number 7 - January 2016"  ///
       8 "Release number 8 - November 2017"  ///
       9 "Release number 9 - June 2023"

forvalues n = 1/56 {
    label define ER13005L `n' "Actual state (FIPS code)"  , modify
}
label define ER13005L       99 "DK; NA"  , modify
label define ER13005L        0 "Inap.:  U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER13009L `n' "Actual number"  , modify
}

label define ER13011L  ///
       1 "Male"  ///
       2 "Female"

label define ER13077L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER13079L  ///
       1 "1997"  ///
       2 "1998"  ///
       3 "1999"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.: has not moved"

label define ER14493L  ///
       1 "Yes"  ///
       5 "No"  ///
       0 "Wild code"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER14789L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU; did not receive any income in 1998"'

label define ER15013L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs"

label define ER15182L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  not currently employed; not covered by pension or retirement plan on current job; defined benefit formula"

label define ER15328L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU; not currently employed; not covered by pension or retirement plan on current job; defined benefit formula"'

label define ER15836L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no wife/"wife" in FU"'

label define ER15837L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       0 `"Inap.: no wife/"wife" in FU; no second mention; NA, DK to first mention"'

label define ER15838L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       0 `"Inap.: no wife/"wife" in FU; no third mention; NA, DK to first mention"'

label define ER15839L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       0 `"Inap.: no wife/"wife" in FU; no fourth mention; NA, DK to first mention"'

label define ER15856L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no wife/"wife" in FU; educated outside the U.S. only or no education"'

label define ER15860L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no wife/"wife" in FU; educated outside the U.S. only or no education; no college; completed less than one year"'

label define ER15890L  ///
       1 "Reinterview family and FU has new head this year; splitoff or recontact interview; immigrant recontact interview"  ///
       5 "All others (head is the same head as in 1997)"

label define ER15921L  ///
       1 "Farm; rural area; country"  ///
       2 "Small town; any size town, suburb"  ///
       3 "Large city; any size city"  ///
       4 "Other; several different places; combination of places"  ///
       8 "DK"  ///
       9 "NA; refused"

forvalues n = 1/56 {
    label define ER15922L `n' "Actual state (FIPS code)"  , modify
}
label define ER15922L       99 "DK; NA"  , modify
label define ER15922L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER15928L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER15929L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       0 "Inap.:  no second mention; NA, DK to first mention"

label define ER15930L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       0 "Inap.:  no third mention; NA, DK to first mention"

label define ER15931L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "Native American"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Latino origin or descent"  ///
       6 "Color besides black or white"  ///
       7 "Other"  ///
       0 "Inap.:  no fourth mention; NA, DK to first mention"

label define ER15948L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or no education"

label define ER15952L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or no education; no college; completed less than one year"

label define ER16431AL  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "DK; NA"

label define ER16431BL  ///
       1 "Same state at both times:  ER15922 equals ER13005"  ///
       2 "Same region, but different state:    ER15922 does not equal   ER13005 but   ER16430 equals   ER16431A"  ///
       3 "Different regions:  ER16430 does not equal ER16431A"  ///
       8 "DK"  ///
       9 "NA; ER13005 or ER15922 equals 99"
label define ER16516L        0 "Completed no grades of school"  , modify
forvalues n = 1/16 {
    label define ER16516L `n' "Actual number"  , modify
}
label define ER16516L       17 "At least some post-graduate work"  , modify
label define ER16516L       99 "NA; DK"  , modify

forvalues n = 1/16 {
    label define ER16517L `n' "Actual number"  , modify
}
label define ER16517L       17 "At least some post-graduate work"  , modify
label define ER16517L       99 "NA; DK"  , modify
label define ER16517L        0 `"Inap.:   no wife/"wife" in FU; completed no grades of school"'  , modify

label define ER17001L  ///
       1 "Release number 1 - November 2002"  ///
       2 "Release number 2 - May 2008"  ///
       3 "Release number 3 - November 2013"  ///
       4 "Release number 4 - February 2014"  ///
       5 "Release number 5 - January 2016"  ///
       6 "Release number 6 - November 2017"  ///
       7 "Release number 7 - June 2023"

forvalues n = 1/56 {
    label define ER17005L `n' "Actual state (FIPS code)"  , modify
}
label define ER17005L       99 "DK; NA"  , modify
label define ER17005L        0 "Inap.:  U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER17012L `n' "Actual number"  , modify
}

label define ER17014L  ///
       1 "Male"  ///
       2 "Female"

label define ER17088L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER17090L  ///
       1 "1999"  ///
       2 "2000"  ///
       3 "2001"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.: has not moved"

label define ER18649L  ///
       1 "Yes"  ///
       5 "No"  ///
       0 "Wild code (should be 5, No)"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER18965L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU; did not receive any income in 2000"'

label define ER19209L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs"

label define ER19350L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  not currently employed; not covered by pension or retirement plan on current job; defined benefit formula"

label define ER19493L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU; not currently employed; not covered by pension or retirement plan on current job; defined benefit formula"'

label define ER19897L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no wife/"wife" in FU"'

label define ER19898L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       0 `"Inap.: no wife/"wife" in FU; no second mention; NA, DK to first mention"'

label define ER19899L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       0 `"Inap.: no wife/"wife" in FU; no third mention; NA, DK to first mention"'

label define ER19900L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       0 `"Inap.: no wife/"wife" in FU; no fourth mention; NA, DK to first mention"'

label define ER19917L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no wife/"wife" in FU; educated outside the U.S. only or no education"'

label define ER19921L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no wife/"wife" in FU; educated outside the U.S. only or no education; no college; completed less than one year"'

label define ER19951L  ///
       1 "Reinterview family and FU has new head this year; splitoff or recontact interview"  ///
       5 "All others (head is the same head as in 1999)"

label define ER19982L  ///
       1 "Farm; rural area; country"  ///
       2 "Small town; any size town, suburb"  ///
       3 "Large city; any size city"  ///
       4 "Other; several different places; combination of places"  ///
       8 "DK"  ///
       9 "NA; refused"

forvalues n = 1/56 {
    label define ER19983L `n' "Actual state (FIPS code)"  , modify
}
label define ER19983L       99 "DK; NA; refused"  , modify
label define ER19983L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER19989L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER19990L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       0 "Inap.:  no second mention; NA, DK to first mention"

label define ER19991L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "American Indian, Aleut, Eskimo"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Mentions Latino origin or descent"  ///
       6 "Mentions color other than black or white"  ///
       7 "Other"  ///
       0 "Inap.:  no third mention; NA, DK to first mention"

label define ER19992L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "Native American"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Latino origin or descent"  ///
       6 "Color besides black or white"  ///
       7 "Other"  ///
       0 "Inap.:  no fourth mention; NA, DK to first mention"

label define ER20009L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or no education"

label define ER20013L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or no education; no college; completed less than one year"

label define ER20377AL  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "DK; NA"

label define ER20377BL  ///
       1 "Same state at both times:  ER19983 equals ER17005"  ///
       2 "Same region, but different state:    ER19983 does not equal   ER17005 but   ER20376 equals   ER20377A"  ///
       3 "Different regions:  ER20376 does not equal ER20377A"  ///
       8 "DK"  ///
       9 "NA; ER17005 or ER19983 equals 99"
label define ER20457L        0 "Completed no grades of school"  , modify
forvalues n = 1/16 {
    label define ER20457L `n' "Actual number"  , modify
}
label define ER20457L       17 "At least some post-graduate work"  , modify
label define ER20457L       99 "NA; DK"  , modify

forvalues n = 1/16 {
    label define ER20458L `n' "Actual number"  , modify
}
label define ER20458L       17 "At least some post-graduate work"  , modify
label define ER20458L       99 "NA; DK"  , modify
label define ER20458L        0 `"Inap.:   no wife/"wife" in FU; completed no grades of school"'  , modify

label define ER21001L  ///
       1 "Release number 1 - December 2004"  ///
       2 "Release number 2 - October 2005"  ///
       3 "Release number 3 - November 2005"  ///
       4 "Release number 4 - May 2008"  ///
       5 "Release number 5 - November 2013"  ///
       6 "Release number 6 - February 2014"  ///
       7 "Release number 7 - January 2016"  ///
       8 "Release number 8 - November 2017"  ///
       9 "Release number 9 - June 2023"

forvalues n = 1/56 {
    label define ER21004L `n' "Actual state (FIPS code)"  , modify
}
label define ER21004L       99 "DK; NA"  , modify
label define ER21004L        0 "Inap.:  U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER21016L `n' "Actual number"  , modify
}

label define ER21018L  ///
       1 "Male"  ///
       2 "Female"

label define ER21117L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER22019L  ///
       1 "Yes"  ///
       5 "No"  ///
       0 "Wild code (should be 5, No)"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER22352L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU; did not receive any income in 2002"'

label define ER22589L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs"

label define ER22745L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  has never worked for money; not currently employed; not covered by pension or retirement plan on current job and will not be; NA, DK whether covered by pension/retirement plan on current job; defined benefit formula only; NA, DK whether defined benefit formula, money accumulated or accrued, or both"

label define ER22889L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU; has never worked for money; not currently employed; not covered by pension or retirement plan on current job and will not be; NA, DK whether covered by pension/retirement plan on current job; defined benefit formula only; NA, DK whether defined benefit formula, money accumulated or accrued, or both"'

label define ER23334L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "Native American"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Latino origin or descent"  ///
       6 "Color besides black or white"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU"'

label define ER23335L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "Native American"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Latino origin or descent"  ///
       6 "Color besides black or white"  ///
       7 "Other"  ///
       0 `"Inap.:  no wife/"wife" in FU; no second mention; NA, DK to first mention"'

label define ER23336L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "Native American"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Latino origin or descent"  ///
       6 "Color besides black or white"  ///
       7 "Other"  ///
       0 `"Inap.:  no wife/"wife" in FU; fewer than three mentions; NA, DK to first mention"'

label define ER23337L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "Native American"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Latino origin or descent"  ///
       6 "Color besides black or white"  ///
       7 "Other"  ///
       0 `"Inap.:  no wife/"wife" in FU; fewer than four mentions; NA, DK to first mention"'

label define ER23354L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU; educated outside the U.S. only or no education"'

label define ER23358L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU; educated outside the U.S. only or no education; no college; completed less than one year"'

label define ER23388L  ///
       1 "Reinterview family and FU has new head this year; splitoff or recontact interview"  ///
       5 "All others (head is the same head as in 2001)"

label define ER23419L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       9 "NA; DK"

forvalues n = 1/56 {
    label define ER23420L `n' "Actual state (FIPS code)"  , modify
}
label define ER23420L       99 "DK; NA; refused"  , modify
label define ER23420L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER23426L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "Native American"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Latino origin or descent"  ///
       6 "Color besides black or white"  ///
       7 "Other"  ///
       9 "NA; DK"

label define ER23427L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "Native American"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Latino origin or descent"  ///
       6 "Color besides black or white"  ///
       7 "Other"  ///
       0 "Inap.:  no second mention; NA, DK to first mention"

label define ER23428L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "Native American"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Latino origin or descent"  ///
       6 "Color besides black or white"  ///
       7 "Other"  ///
       0 "Inap.:  fewer than three mentions; NA, DK to first mention"

label define ER23429L  ///
       1 "White"  ///
       2 "Black"  ///
       3 "Native American"  ///
       4 "Asian, Pacific Islander"  ///
       5 "Latino origin or descent"  ///
       6 "Color besides black or white"  ///
       7 "Other"  ///
       0 "Inap.:  fewer than four mentions; NA, DK to first mention"

label define ER23446L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 "Inap.:  educated outside the U.S. only or no education"

label define ER23450L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 "Inap.:  educated outside the U.S. only or no education; no college; completed less than one year"

label define ER24146L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "NA; DK"

label define ER24147L  ///
       1 "Same state at both times:  ER23420 equals ER21004"  ///
       2 "Same region, but different state:  ER23420 does not equal ER21004 but ER24143 equals ER24146"  ///
       3 "Different regions:  ER24143 does not equal ER24146"  ///
       8 "DK"  ///
       9 "NA; ER21004 or ER23420 equals 99"
label define ER24148L        0 "Completed no grades of school"  , modify
forvalues n = 1/16 {
    label define ER24148L `n' "Actual number"  , modify
}
label define ER24148L       17 "At least some post-graduate work"  , modify
label define ER24148L       99 "NA; DK"  , modify

forvalues n = 1/16 {
    label define ER24149L `n' "Actual number"  , modify
}
label define ER24149L       17 "At least some post-graduate work"  , modify
label define ER24149L       99 "NA; DK"  , modify
label define ER24149L        0 `"Inap.:   no wife/"wife" in FU; completed no grades of school"'  , modify

label define ER25001L  ///
       1 "Release number 1, March 2007"  ///
       2 "Release number 2, May 2007"  ///
       3 "Release number 3, November 2013"  ///
       4 "Release number 4, February 2014"  ///
       5 "Release number 5, January 2016"  ///
       6 "Release number 6, November 2017"  ///
       7 "Release number 7, June 2023"

forvalues n = 1/56 {
    label define ER25004L `n' "Actual state (FIPS code)"  , modify
}
label define ER25004L       99 "DK; NA"  , modify
label define ER25004L        0 "Inap.:  U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER25016L `n' "Actual number"  , modify
}

label define ER25018L  ///
       1 "Male"  ///
       2 "Female"

label define ER25098L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER26000L  ///
       1 "Yes"  ///
       5 "No"  ///
       0 "Wild code"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER26333L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU; did not receive any income in 2004"'

label define ER26570L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs"

label define ER26726L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  has never worked for money; not currently employed; not covered by pension or retirement plan on current job and will not be; NA, DK whether covered by pension/retirement plan on current job; defined benefit formula only; NA, DK whether defined benefit formula, money accumulated or accrued, or both"

label define ER26870L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU; has never worked for money; not currently employed; not covered by pension or retirement plan on current job and will not be; NA, DK whether covered by pension/retirement plan on current job; defined benefit formula only; NA, DK whether defined benefit formula, money accumulated or accrued, or both"'

label define ER27296L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no wife/"wife" in FU; not Spanish, Hispanic or Latino"'

label define ER27297L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU"'

label define ER27298L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU; no second mention; NA, DK to first mention"'

label define ER27299L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU; fewer than three mentions; NA, DK to first mention"'

label define ER27300L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU; fewer than four mentions; NA, DK to first mention"'

label define ER27317L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU; educated outside the U.S. only or no education"'

label define ER27321L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU; educated outside the U.S. only or no education; no college; completed less than one year"'

label define ER27352L  ///
       1 "Reinterview family and FU has new head this year; splitoff or recontact interview"  ///
       5 "FU has same head as last wave"

label define ER27385L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       9 "NA; DK"

forvalues n = 1/56 {
    label define ER27386L `n' "Actual state (FIPS code)"  , modify
}
label define ER27386L       99 "DK; NA"  , modify
label define ER27386L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER27392L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.: not Spanish, Hispanic or Latino"

label define ER27393L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       0 "Wild code"  ///
       9 "NA; DK"

label define ER27394L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 "Inap.:  no second mention; NA, DK to first mention"

label define ER27395L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 "Inap.:  fewer than three mentions; NA, DK to first mention"

label define ER27396L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 "Inap.:  fewer than four mentions; NA, DK to first mention"

label define ER27413L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 "Inap.:  educated outside the U.S. only or no education"

label define ER27417L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 "Inap.:  educated outside the U.S. only or no education; no college; completed less than one year"

label define ER28006L  ///
       0 "Actual value"  ///
       5 "Imputed using the median value for all non-zero cases in the current year"

label define ER28045L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "NA; DK"

label define ER28046L  ///
       1 "Same state at both times:  ER27386 equals ER25004"  ///
       2 "Same region, but different state:  ER27386 does not equal ER25004 but ER28042 equals ER28045"  ///
       3 "Different regions:  ER28042 does not equal ER28045"  ///
       8 "DK"  ///
       9 "NA; ER25004 or ER27386 equals 99"
label define ER28047L        0 "Completed no grades of school"  , modify
forvalues n = 1/16 {
    label define ER28047L `n' "Actual number"  , modify
}
label define ER28047L       17 "At least some post-graduate work"  , modify
label define ER28047L       99 "NA; DK"  , modify

forvalues n = 1/16 {
    label define ER28048L `n' "Actual number"  , modify
}
label define ER28048L       17 "At least some post-graduate work"  , modify
label define ER28048L       99 "NA; DK"  , modify
label define ER28048L        0 `"Inap.:   no wife/"wife" in FU; completed no grades of school"'  , modify

label define ER30000L  ///
       1 "Release number 1, May 2025"  ///
       2 "Release number 2, December 2025"

label define ER32000L  ///
       1 "Male"  ///
       2 "Female"  ///
       9 "NA"

label define ER32006L  ///
       0 "This individual is nonsample and not part of the elderly group (ER30002=170-229 and ER30609<64 and ER30645<64 and ER30692<64 and ER30736<64 and ER30809<64 and ER33104<64)"  ///
       1 "This individual is original sample (ER30002=001-026)"  ///
       2 "This individual is born-in sample (ER30002=030-169)"  ///
       3 "This individual is moved-in sample"  ///
       4 "This individual is joint inclusion sample"  ///
       5 "This individual was a followable nonsample parent"  ///
       6 "This individual is nonsample elderly (ER30002=170-229 and ER30609=64-120 or ER30645=64-120 or ER30692=64-120 or ER30736=64-120 or ER30809=64-120 or ER33104=64-120)"

forvalues n = 1/20 {
    label define ER33502L `n' "Individuals in the family at the time of the 1999 interview"  , modify
}
forvalues n = 51/59 {
    label define ER33502L `n' "Individuals in institutions at the time of the 1999 interview"  , modify
}
forvalues n = 71/80 {
    label define ER33502L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 1997 and 1999 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER33502L `n' "Individuals who were living in 1997 but died by the time of the 1999 interview"  , modify
}
label define ER33502L        0 "Inap.:  born or moved in after the 1999 interview; from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 1999 or mover-out nonresponse by 1997 (ER33501=0)"  , modify

label define ER33503L  ///
      10 "Head in 1999; 1997 Head who was mover-out nonresponse by the time of the 1999 interview"  ///
      20 "Legal Wife in 1999; 1997 Wife who was mover-out nonresponse by the time of the 1999 interview"  ///
      22 `""Wife"--female cohabitor who has lived with Head for 12 months or more; 1997 "Wife" who was mover-out nonresponse by the time of the 1999 interview"'  ///
      30 "Son or daughter of Head (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Head (children of legal Wife (code 20) who are not children of Head)"  ///
      35 `"Son or daughter of "Wife" but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)"'  ///
      37 "Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Head (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal Wife, or spouse of Head`=char(146)'s brother or sister."  ///
      48 "Brother or sister of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Head (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Head (includes parents of legal wives (code 20) only)"  ///
      58 "Father or mother of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Head (includes grandchildren of legal Wife (code 20), but those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal Wife (code 20), but those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Head (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Wife (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Head"  ///
      69 "Great-grandfather or great-grandmother of legal Wife (code 20)"  ///
      70 "Nephew or niece of Head"  ///
      71 "Nephew or niece of legal Wife (code 20)"  ///
      72 "Uncle or Aunt of Head"  ///
      73 "Uncle or Aunt of legal Wife (code 20)"  ///
      74 "Cousin of Head"  ///
      75 "Cousin of legal Wife (code 20)"  ///
      83 "Children of first-year cohabitor but not of Head (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Head"  ///
      90 "Legal husband of Head"  ///
      95 "Other relative of Head"  ///
      96 "Other relative of legal Wife (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes homosexual partners, friends of children of the FU, etc.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 1999 or mover-out nonresponse by 1997 (ER33501=0); born or moved in after the 1999 interview (ER33501>0 and ER33502=0)"

forvalues n = 1/20 {
    label define ER33602L `n' "Individuals in the family at the time of the 2001 interview"  , modify
}
forvalues n = 51/59 {
    label define ER33602L `n' "Individuals in institutions at the time of the 2001 interview"  , modify
}
forvalues n = 71/80 {
    label define ER33602L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 1999 and 2001 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER33602L `n' "Individuals who were living in 1999 but died by the time of the 2001 interview"  , modify
}
label define ER33602L        0 "Inap.:  born or moved in after the 2001 interview; from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2001 or mover-out nonresponse by 1999 (ER33601=0)"  , modify

label define ER33603L  ///
      10 "Head in 2001; 1999 Head who was mover-out nonresponse by the time of the 2001 interview"  ///
      20 "Legal Wife in 2001; 1999 Wife who was mover-out nonresponse by the time of the 2001 interview"  ///
      22 `""Wife"--female cohabitor who has lived with Head for 12 months or more; 1999 "Wife" who was mover-out nonresponse by the time of the 2001 interview"'  ///
      30 "Son or daughter of Head (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Head (children of legal Wife (code 20) who are not children of Head)"  ///
      35 `"Son or daughter of "Wife" but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)"'  ///
      37 "Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Head (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal Wife, or spouse of Head`=char(146)'s brother or sister."  ///
      48 "Brother or sister of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Head (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Head (includes parents of legal wives (code 20) only)"  ///
      58 "Father or mother of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Head (includes grandchildren of legal Wife (code 20), but those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal Wife (code 20), but those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Head (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Wife (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Head"  ///
      69 "Great-grandfather or great-grandmother of legal Wife (code 20)"  ///
      70 "Nephew or niece of Head"  ///
      71 "Nephew or niece of legal Wife (code 20)"  ///
      72 "Uncle or Aunt of Head"  ///
      73 "Uncle or Aunt of legal Wife (code 20)"  ///
      74 "Cousin of Head"  ///
      75 "Cousin of legal Wife (code 20)"  ///
      83 "Children of first-year cohabitor but not of Head (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Head"  ///
      90 "Legal husband of Head"  ///
      95 "Other relative of Head"  ///
      96 "Other relative of legal Wife (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes homosexual partners, friends of children of the FU, etc.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2001 or mover-out nonresponse by 1999 (ER33601=0); born or moved in after the 2001 interview (ER33601>0 and ER33602=0)"

forvalues n = 1/20 {
    label define ER33702L `n' "Individuals in the family at the time of the 2003 interview"  , modify
}
forvalues n = 51/59 {
    label define ER33702L `n' "Individuals in institutions at the time of the 2003 interview"  , modify
}
forvalues n = 71/80 {
    label define ER33702L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2001 and 2003 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER33702L `n' "Individuals who were living in 2001 but died by the time of the 2003 interview"  , modify
}
label define ER33702L        0 "Inap.:  born or moved in after the 2003 interview; from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2003 or mover-out nonresponse by 2001 (ER33701=0)"  , modify

label define ER33703L  ///
      10 "Head in 2003; 2001 Head who was mover-out nonresponse by the time of the 2003 interview"  ///
      20 "Legal Wife in 2003; 2001 Wife who was mover-out nonresponse by the time of the 2003 interview"  ///
      22 `""Wife"--female cohabitor who has lived with Head for 12 months or more; 2001 "Wife" who was mover-out nonresponse by the time of the 2003 interview"'  ///
      30 "Son or daughter of Head (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Head (children of legal Wife (code 20) who are not children of Head)"  ///
      35 `"Son or daughter of "Wife" but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)"'  ///
      37 "Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Head (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal Wife, or spouse of Head`=char(146)'s brother or sister."  ///
      48 "Brother or sister of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Head (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Head (includes parents of legal wives (code 20) only)"  ///
      58 "Father or mother of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Head (includes grandchildren of legal Wife (code 20); those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal Wife (code 20); those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Head (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Wife (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Head"  ///
      69 "Great-grandfather or great-grandmother of legal Wife (code 20)"  ///
      70 "Nephew or niece of Head"  ///
      71 "Nephew or niece of legal Wife (code 20)"  ///
      72 "Uncle or Aunt of Head"  ///
      73 "Uncle or Aunt of legal Wife (code 20)"  ///
      74 "Cousin of Head"  ///
      75 "Cousin of legal Wife (code 20)"  ///
      83 "Children of first-year cohabitor but not of Head (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Head"  ///
      90 "Legal husband of Head"  ///
      95 "Other relative of Head"  ///
      96 "Other relative of legal Wife (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes homosexual partners, friends of children of the FU, etc.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2003 or mover-out nonresponse by 2001 (ER33701=0); born or moved in after the 2003 interview (ER33701>0 and ER33702=0)"

forvalues n = 1/20 {
    label define ER33802L `n' "Individuals in the family at the time of the 2005 interview"  , modify
}
forvalues n = 51/59 {
    label define ER33802L `n' "Individuals in institutions at the time of the 2005 interview"  , modify
}
forvalues n = 71/80 {
    label define ER33802L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2003 and 2005 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER33802L `n' "Individuals who were living in 2003 but died by the time of the 2005 interview"  , modify
}
label define ER33802L        0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2005 or mover-out nonresponse by 2003 (ER33801=0)"  , modify

label define ER33803L  ///
      10 "Head in 2005; 2003 Head who was mover-out nonresponse by the time of the 2005 interview"  ///
      20 "Legal Wife in 2005; 2003 Wife who was mover-out nonresponse by the time of the 2005 interview"  ///
      22 `""Wife"--female cohabitor who has lived with Head for 12 months or more; 2003 "Wife" who was mover-out nonresponse by the time of the 2005 interview"'  ///
      30 "Son or daughter of Head (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Head (children of legal Wife [code 20] who are not children of Head)"  ///
      35 `"Son or daughter of "Wife" but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)"'  ///
      37 "Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Head (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal Wife, or spouse of Head`=char(146)'s brother or sister"  ///
      48 "Brother or sister of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Head (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Head (includes parents of legal wives [code 20] only)"  ///
      58 "Father or mother of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Head (includes grandchildren of legal Wife [code 20] only; those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal Wife [code 20]; those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Head (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Wife (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Head"  ///
      69 "Great-grandfather or great-grandmother of legal Wife (code 20)"  ///
      70 "Nephew or niece of Head"  ///
      71 "Nephew or niece of legal Wife (code 20)"  ///
      72 "Uncle or Aunt of Head"  ///
      73 "Uncle or Aunt of legal Wife (code 20)"  ///
      74 "Cousin of Head"  ///
      75 "Cousin of legal Wife (code 20)"  ///
      83 "Children of first-year cohabitor but not of Head (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Head"  ///
      90 "Legal husband of Head"  ///
      95 "Other relative of Head"  ///
      96 "Other relative of legal Wife (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes homosexual partners, friends of children of the FU, etc.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2005 or mover-out nonresponse by 2003 (ER33801=0)"

forvalues n = 1/20 {
    label define ER33902L `n' "Individuals in the family at the time of the 2007 interview"  , modify
}
forvalues n = 51/59 {
    label define ER33902L `n' "Individuals in institutions at the time of the 2007 interview"  , modify
}
forvalues n = 71/80 {
    label define ER33902L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2005 and 2007 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER33902L `n' "Individuals who were living in 2005 but died by the time of the 2007 interview"  , modify
}
label define ER33902L        0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2007 or mover-out nonresponse by 2005 (ER33901=0)"  , modify

label define ER33903L  ///
      10 "Head in 2007; 2005 Head who was mover-out nonresponse by the time of the 2007 interview"  ///
      20 "Legal Wife in 2007; 2005 Wife who was mover-out nonresponse by the time of the 2007 interview"  ///
      22 `""Wife"--female cohabitor who has lived with Head for 12 months or more; 2005 "Wife" who was mover-out nonresponse by the time of the 2007 interview"'  ///
      30 "Son or daughter of Head (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Head (children of legal Wife [code 20] who are not children of Head)"  ///
      35 `"Son or daughter of "Wife" but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)"'  ///
      37 "Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Head (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal Wife, or spouse of Head`=char(146)'s brother or sister"  ///
      48 "Brother or sister of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Head (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Head (includes parents of legal wives [code 20] only)"  ///
      58 "Father or mother of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Head (includes grandchildren of legal Wife [code 20] only; those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal Wife [code 20]; those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Head (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Wife (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Head"  ///
      69 "Great-grandfather or great-grandmother of legal Wife (code 20)"  ///
      70 "Nephew or niece of Head"  ///
      71 "Nephew or niece of legal Wife (code 20)"  ///
      72 "Uncle or Aunt of Head"  ///
      73 "Uncle or Aunt of legal Wife (code 20)"  ///
      74 "Cousin of Head"  ///
      75 "Cousin of legal Wife (code 20)"  ///
      83 "Children of first-year cohabitor but not of Head (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Head"  ///
      90 "Legal husband of Head"  ///
      95 "Other relative of Head"  ///
      96 "Other relative of legal Wife (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes homosexual partners, friends of children of the FU, etc.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2007 or mover-out nonresponse by 2005 (ER33901=0)"

forvalues n = 1/20 {
    label define ER34002L `n' "Individuals in the family at the time of the 2009 interview"  , modify
}
forvalues n = 51/59 {
    label define ER34002L `n' "Individuals in institutions at the time of the 2009 interview"  , modify
}
forvalues n = 71/80 {
    label define ER34002L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2007 and 2009 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER34002L `n' "Individuals who were living in 2007 but died by the time of the 2009 interview"  , modify
}
label define ER34002L        0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2009 or mover-out nonresponse by 2007 (ER34001=0)"  , modify

label define ER34003L  ///
      10 "Head in 2009; 2007 Head who was mover-out nonresponse by the time of the 2009 interview"  ///
      20 "Legal Wife in 2009; 2007 Wife who was mover-out nonresponse by the time of the 2009 interview"  ///
      22 `""Wife"--female cohabitor who has lived with Head for 12 months or more; 2007 "Wife" who was mover-out nonresponse by the time of the 2009 interview"'  ///
      30 "Son or daughter of Head (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Head (children of legal Wife [code 20] who are not children of Head)"  ///
      35 `"Son or daughter of "Wife" but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)"'  ///
      37 "Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Head (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal Wife, or spouse of Head`=char(146)'s brother or sister"  ///
      48 "Brother or sister of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Head (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Head (includes parents of legal wives [code 20] only)"  ///
      58 "Father or mother of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Head (includes grandchildren of legal Wife [code 20] only; those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal Wife [code 20]; those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Head (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Wife (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Head"  ///
      69 "Great-grandfather or great-grandmother of legal Wife (code 20)"  ///
      70 "Nephew or niece of Head"  ///
      71 "Nephew or niece of legal Wife (code 20)"  ///
      72 "Uncle or Aunt of Head"  ///
      73 "Uncle or Aunt of legal Wife (code 20)"  ///
      74 "Cousin of Head"  ///
      75 "Cousin of legal Wife (code 20)"  ///
      83 "Children of first-year cohabitor but not of Head (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Head"  ///
      90 "Legal husband of Head"  ///
      95 "Other relative of Head"  ///
      96 "Other relative of legal Wife (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes homosexual partners, friends of children of the FU, etc.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2009 or mover-out nonresponse by 2007 (ER34002=0)"

forvalues n = 1/20 {
    label define ER34102L `n' "Individuals in the family at the time of the 2011 interview"  , modify
}
forvalues n = 51/59 {
    label define ER34102L `n' "Individuals in institutions at the time of the 2011 interview"  , modify
}
forvalues n = 71/80 {
    label define ER34102L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2009 and 2011 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER34102L `n' "Individuals who were living in 2009 but died by the time of the 2011 interview"  , modify
}
label define ER34102L        0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2011 or mover-out nonresponse by 2009 (ER34101=0)"  , modify

label define ER34103L  ///
      10 "Head in 2011; 2009 Head who was mover-out nonresponse by the time of the 2011 interview"  ///
      20 "Legal Wife in 2011; 2009 Wife who was mover-out nonresponse by the time of the 2011 interview"  ///
      22 `""Wife"--female cohabitor who has lived with Head for 12 months or more; 2009 "Wife" who was mover-out nonresponse by the time of the 2011 interview"'  ///
      30 "Son or daughter of Head (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Head (children of legal Wife [code 20] who are not children of Head)"  ///
      35 `"Son or daughter of "Wife" but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)"'  ///
      37 "Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Head (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal Wife, or spouse of Head`=char(146)'s brother or sister"  ///
      48 "Brother or sister of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Head (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Head (includes parents of legal wives [code 20] only)"  ///
      58 "Father or mother of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Head (includes grandchildren of legal Wife [code 20] only; those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal Wife [code 20]; those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Head (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Wife (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Head"  ///
      69 "Great-grandfather or great-grandmother of legal Wife (code 20)"  ///
      70 "Nephew or niece of Head"  ///
      71 "Nephew or niece of legal Wife (code 20)"  ///
      72 "Uncle or Aunt of Head"  ///
      73 "Uncle or Aunt of legal Wife (code 20)"  ///
      74 "Cousin of Head"  ///
      75 "Cousin of legal Wife (code 20)"  ///
      83 "Children of first-year cohabitor but not of Head (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Head"  ///
      90 "Legal husband of Head"  ///
      95 "Other relative of Head"  ///
      96 "Other relative of legal Wife (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes homosexual partners, friends of children of the FU, etc.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2011 or mover-out nonresponse by 2009 (ER34102=0)"

forvalues n = 1/20 {
    label define ER34202L `n' "Individuals in the family at the time of the 2013 interview"  , modify
}
forvalues n = 51/59 {
    label define ER34202L `n' "Individuals in institutions at the time of the 2013 interview"  , modify
}
forvalues n = 71/80 {
    label define ER34202L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2011 and 2013 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER34202L `n' "Individuals who were living in 2011 but died by the time of the 2013 interview"  , modify
}
label define ER34202L        0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2013 or mover-out nonresponse by 2011 (ER34201=0)"  , modify

label define ER34203L  ///
      10 "Head in 2013; 2011 Head who was mover-out nonresponse by the time of the 2013 interview"  ///
      20 "Legal Wife in 2013; 2011 Wife who was mover-out nonresponse by the time of the 2013 interview"  ///
      22 `""Wife"--female cohabitor who has lived with Head for 12 months or more; 2011 "Wife" who was mover-out nonresponse by the time of the 2013 interview"'  ///
      30 "Son or daughter of Head (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Head (children of legal Wife [code 20] who are not children of Head)"  ///
      35 `"Son or daughter of "Wife" but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)"'  ///
      37 "Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Head (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal Wife, or spouse of Head`=char(146)'s brother or sister"  ///
      48 "Brother or sister of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Head (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Head (includes parents of legal wives [code 20] only)"  ///
      58 "Father or mother of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Head (includes grandchildren of legal Wife [code 20] only; those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal Wife [code 20]; those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Head (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Wife (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Head"  ///
      69 "Great-grandfather or great-grandmother of legal Wife (code 20)"  ///
      70 "Nephew or niece of Head"  ///
      71 "Nephew or niece of legal Wife (code 20)"  ///
      72 "Uncle or Aunt of Head"  ///
      73 "Uncle or Aunt of legal Wife (code 20)"  ///
      74 "Cousin of Head"  ///
      75 "Cousin of legal Wife (code 20)"  ///
      83 "Children of first-year cohabitor but not of Head (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Head"  ///
      90 "Legal husband of Head"  ///
      95 "Other relative of Head"  ///
      96 "Other relative of legal Wife (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes homosexual partners, friends of children of the FU, etc.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2013 or mover-out nonresponse by 2011 (ER34202=0)"

forvalues n = 1/20 {
    label define ER34302L `n' "Individuals in the family at the time of the 2015 interview"  , modify
}
forvalues n = 51/59 {
    label define ER34302L `n' "Individuals in institutions at the time of the 2015 interview"  , modify
}
forvalues n = 71/80 {
    label define ER34302L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2013 and 2015 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER34302L `n' "Individuals who were living in 2013 but died by the time of the 2015 interview"  , modify
}
label define ER34302L        0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2015 or mover-out nonresponse by 2013 (ER34301=0)"  , modify

label define ER34303L  ///
      10 "Head in 2015; 2013 Head who was mover-out nonresponse by the time of the 2015 interview"  ///
      20 "Legal Spouse in 2015; 2013 Spouse who was mover-out nonresponse by the time of the 2015 interview"  ///
      22 "Partner--female cohabitor who has lived with Head for 12 months or more; 2013 Partner who was mover-out nonresponse by the time of the 2015 interview"  ///
      30 "Son or daughter of Head (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Head (children of legal Spouse [code 20] who are not children of Head)"  ///
      35 "Son or daughter of Partner but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)"  ///
      37 "Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Head (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal Spouse, or spouse of Head`=char(146)'s brother or sister"  ///
      48 "Brother or sister of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Head (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Head (includes parents of legal spouses [code 20] only)"  ///
      58 "Father or mother of Head`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Head (includes grandchildren of legal Spouse [code 20] only; those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal Spouse [code 20]; those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Head (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Spouse (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Head"  ///
      69 "Great-grandfather or great-grandmother of legal Spouse (code 20)"  ///
      70 "Nephew or niece of Head"  ///
      71 "Nephew or niece of legal Spouse (code 20)"  ///
      72 "Uncle or Aunt of Head"  ///
      73 "Uncle or Aunt of legal Spouse (code 20)"  ///
      74 "Cousin of Head"  ///
      75 "Cousin of legal Spouse (code 20)"  ///
      83 "Children of first-year cohabitor but not of Head (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Head"  ///
      90 "Uncooperative legal spouse of Head (this individual is unable or unwilling to be designated as Head)"  ///
      95 "Other relative of Head"  ///
      96 "Other relative of legal Spouse (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes same-sex partners, friends of children of the FU, etc.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2015 or mover-out nonresponse by 2013 (ER34302=0)"

forvalues n = 1/20 {
    label define ER34502L `n' "Individuals in the family at the time of the 2017 interview"  , modify
}
forvalues n = 51/59 {
    label define ER34502L `n' "Individuals in institutions at the time of the 2017 interview"  , modify
}
forvalues n = 71/80 {
    label define ER34502L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2015 and 2017 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER34502L `n' "Individuals who were living in 2015 but died by the time of the 2017 interview"  , modify
}
label define ER34502L        0 "Inap.:  from Immigrant 17 recontact sample (ER30001=4700-4851) or Multiplicity sample (ER30001=4001-4462 and ER32052=2019); from Latino sample (ER30001=7001-9308); main family nonresponse by 2017 or mover-out nonresponse by 2015 (ER34501=0)"  , modify

label define ER34503L  ///
      10 "Reference Person in 2017; 2015 Reference Person who was mover-out nonresponse by the time of the 2017 interview"  ///
      20 "Legal Spouse in 2017; 2015 Spouse who was mover-out nonresponse by the time of the 2017 interview"  ///
      22 "Partner--cohabitor who has lived with Reference Person for 12 months or more; 2015 Partner who was mover-out nonresponse by the time of the 2017 interview"  ///
      30 "Son or daughter of Reference Person (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Reference Person (children of legal Spouse [code 20] who are not children of Reference Person)"  ///
      35 "Son or daughter of Partner but not Reference Person (includes only those children of mothers whose relationship to Reference Person is 22 but who are not children of Reference Person)"  ///
      37 "Son-in-law or daughter-in-law of Reference Person (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Reference Person (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Reference Person (i.e., brother or sister of legal Spouse; spouse of HD`=char(146)'s brother or sister; spouse of legal Spouse`=char(146)'s brother or sister)"  ///
      48 "Brother or sister of Reference Person`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Reference Person (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Reference Person (includes parents of legal spouses [code 20] only)"  ///
      58 "Father or mother of Reference Person`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Reference Person (includes grandchildren of legal Spouse [code 20] only; those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Reference Person (includes great-grandchildren of legal Spouse [code 20]; those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Reference Person (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Spouse (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Reference Person"  ///
      69 "Great-grandfather or great-grandmother of legal Spouse (code 20)"  ///
      70 "Nephew or niece of Reference Person"  ///
      71 "Nephew or niece of legal Spouse (code 20)"  ///
      72 "Uncle or Aunt of Reference Person"  ///
      73 "Uncle or Aunt of legal Spouse (code 20)"  ///
      74 "Cousin of Reference Person"  ///
      75 "Cousin of legal Spouse (code 20)"  ///
      83 "Children of first-year cohabitor but not of Reference Person (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Reference Person"  ///
      90 "Uncooperative legal spouse of Reference Person (this individual is unable or unwilling to be designated as Reference Person or Spouse)"  ///
      92 "Uncooperative partner of Reference Person (this individual is unable or unwilling to be designated as Partner)"  ///
      95 "Other relative of Reference Person"  ///
      96 "Other relative of legal Spouse (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes friends of children of the FU, boyfriend/girlfriend of son/daughter, et al.)"  ///
       0 "Inap.:  from Immigrant 17 recontact sample (ER30001=4700-4851) or Multiplicity sample (ER30001=4001-4462 and ER32052=2019); from Latino sample (ER30001=7001-9308); main family nonresponse by 2017 or mover-out nonresponse by 2015 (ER34502=0)"

forvalues n = 1/20 {
    label define ER34702L `n' "Individuals in the family at the time of the 2019 interview"  , modify
}
forvalues n = 51/59 {
    label define ER34702L `n' "Individuals in institutions at the time of the 2019 interview"  , modify
}
forvalues n = 71/80 {
    label define ER34702L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2017 and 2019 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER34702L `n' "Individuals who were living in 2017 but died by the time of the 2019 interview"  , modify
}
label define ER34702L        0 "Inap.:  from Latino sample (ER30001=7001-9308); main family nonresponse by 2019 or mover-out nonresponse by 2017 (ER34701=0)"  , modify

label define ER34703L  ///
      10 "Reference Person in 2019; 2017 Reference Person who was mover-out nonresponse by the time of the 2019 interview"  ///
      20 "Legal Spouse in 2019; 2017 Spouse who was mover-out nonresponse by the time of the 2019 interview"  ///
      22 "Partner--cohabitor who has lived with Reference Person for 12 months or more; 2017 Partner who was mover-out nonresponse by the time of the 2019 interview"  ///
      30 "Son or daughter of Reference Person (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Reference Person (children of legal Spouse [code 20] who are not children of Reference Person)"  ///
      35 "Son or daughter of Partner but not Reference Person (includes only those children of mothers whose relationship to Reference Person is 22 but who are not children of Reference Person)"  ///
      37 "Son-in-law or daughter-in-law of Reference Person (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Reference Person (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Reference Person (i.e., brother or sister of legal Spouse; spouse of HD`=char(146)'s brother or sister; spouse of legal Spouse`=char(146)'s brother or sister)"  ///
      48 "Brother or sister of Reference Person`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Reference Person (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Reference Person (includes parents of legal spouses [code 20] only)"  ///
      58 "Father or mother of Reference Person`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Reference Person (includes grandchildren of legal Spouse [code 20] only; those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Reference Person (includes great-grandchildren of legal Spouse [code 20]; those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Reference Person (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Spouse (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Reference Person"  ///
      69 "Great-grandfather or great-grandmother of legal Spouse (code 20)"  ///
      70 "Nephew or niece of Reference Person"  ///
      71 "Nephew or niece of legal Spouse (code 20)"  ///
      72 "Uncle or Aunt of Reference Person"  ///
      73 "Uncle or Aunt of legal Spouse (code 20)"  ///
      74 "Cousin of Reference Person"  ///
      75 "Cousin of legal Spouse (code 20)"  ///
      83 "Children of first-year cohabitor but not of Reference Person (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Reference Person"  ///
      90 "Uncooperative legal spouse of Reference Person (this individual is unable or unwilling to be designated as Reference Person or Spouse)"  ///
      92 "Uncooperative partner of Reference Person (this individual is unable or unwilling to be designated as Partner)"  ///
      95 "Other relative of Reference Person"  ///
      96 "Other relative of legal Spouse (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes friends of children of the FU, boyfriend/girlfriend of son/daughter, et al.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); main family nonresponse by 2019 or mover-out nonresponse by 2017 (ER34702=0)"

forvalues n = 1/20 {
    label define ER34902L `n' "Individuals in the family at the time of the 2021 interview"  , modify
}
forvalues n = 51/59 {
    label define ER34902L `n' "Individuals in institutions at the time of the 2021 interview"  , modify
}
forvalues n = 71/80 {
    label define ER34902L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2019 and 2021 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER34902L `n' "Individuals who were living in 2019 but died by the time of the 2021 interview"  , modify
}
label define ER34902L        0 "Inap.:  from Latino sample (ER30001=7001-9308); main family nonresponse by 2021 or mover-out nonresponse by 2019 (ER34901=0)"  , modify

label define ER34903L  ///
      10 "Reference Person in 2021; 2019 Reference Person who was mover-out nonresponse by the time of the 20121 interview"  ///
      20 "Legal Spouse in 2021; 2019 Spouse who was mover-out nonresponse by the time of the 2021 interview"  ///
      22 "Partner--cohabitor who has lived with Reference Person for 12 months or more; 2019 Partner who was mover-out nonresponse by the time of the 2021 interview"  ///
      30 "Son or daughter of Reference Person (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Reference Person (children of legal Spouse [code 20] who are not children of Reference Person)"  ///
      35 "Son or daughter of Partner but not Reference Person (includes only those children of mothers whose relationship to Reference Person is 22 but who are not children of Reference Person)"  ///
      37 "Son-in-law or daughter-in-law of Reference Person (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Reference Person (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Reference Person (i.e., brother or sister of legal Spouse; spouse of HD`=char(146)'s brother or sister; spouse of legal Spouse`=char(146)'s brother or sister)"  ///
      48 "Brother or sister of Reference Person`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Reference Person (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Reference Person (includes parents of legal spouses [code 20] only)"  ///
      58 "Father or mother of Reference Person`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Reference Person (includes grandchildren of legal Spouse [code 20] only; those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Reference Person (includes great-grandchildren of legal Spouse [code 20]; those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Reference Person (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Spouse (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Reference Person"  ///
      69 "Great-grandfather or great-grandmother of legal Spouse (code 20)"  ///
      70 "Nephew or niece of Reference Person"  ///
      71 "Nephew or niece of legal Spouse (code 20)"  ///
      72 "Uncle or Aunt of Reference Person"  ///
      73 "Uncle or Aunt of legal Spouse (code 20)"  ///
      74 "Cousin of Reference Person"  ///
      75 "Cousin of legal Spouse (code 20)"  ///
      83 "Children of first-year cohabitor but not of Reference Person (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Reference Person"  ///
      90 "Uncooperative legal spouse of Reference Person (this individual is unable or unwilling to be designated as Reference Person or Spouse)"  ///
      92 "Uncooperative partner of Reference Person (this individual is unable or unwilling to be designated as Partner)"  ///
      95 "Other relative of Reference Person"  ///
      96 "Other relative of legal Spouse (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes friends of children of the FU, boyfriend/girlfriend of son/daughter, et al.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); main family nonresponse by 2021 or mover-out nonresponse by 2019 (ER34902=0)"

forvalues n = 1/20 {
    label define ER35102L `n' "Individuals in the family at the time of the 2023 interview"  , modify
}
forvalues n = 51/59 {
    label define ER35102L `n' "Individuals in institutions at the time of the 2023 interview"  , modify
}
forvalues n = 71/80 {
    label define ER35102L `n' "Individuals who moved out of the FU or out of institutions and established their own households between the 2021 and 2023 interviews"  , modify
}
forvalues n = 81/89 {
    label define ER35102L `n' "Individuals who were living in 2021 but died by the time of the 2023 interview"  , modify
}
label define ER35102L        0 "Inap.:  from Latino sample (ER30001=7001-9308); main family nonresponse by 2023 or mover-out nonresponse by 2021 (ER35101=0)"  , modify

label define ER35103L  ///
      10 "Reference Person in 2023; 2021 Reference Person who was mover-out nonresponse by the time of the 20121 interview"  ///
      20 "Legal Spouse in 2023; 2021 Spouse who was mover-out nonresponse by the time of the 2023 interview"  ///
      22 "Partner--cohabitor who has lived with Reference Person for 12 months or more; 2021 Partner who was mover-out nonresponse by the time of the 2023 interview"  ///
      30 "Son or daughter of Reference Person (includes adopted children but not stepchildren)"  ///
      33 "Stepson or stepdaughter of Reference Person (children of legal Spouse [code 20] who are not children of Reference Person)"  ///
      35 "Son or daughter of Partner but not Reference Person (includes only those children of mothers whose relationship to Reference Person is 22 but who are not children of Reference Person)"  ///
      37 "Son-in-law or daughter-in-law of Reference Person (includes stepchildren-in-law)"  ///
      38 "Foster son or foster daughter, not legally adopted"  ///
      40 "Brother or sister of Reference Person (includes step and half sisters and brothers)"  ///
      47 "Brother-in-law or sister-in-law of Reference Person (i.e., brother or sister of legal Spouse; spouse of HD`=char(146)'s brother or sister; spouse of legal Spouse`=char(146)'s brother or sister)"  ///
      48 "Brother or sister of Reference Person`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      50 "Father or mother of Reference Person (includes stepparents)"  ///
      57 "Father-in-law or mother-in-law of Reference Person (includes parents of legal spouses [code 20] only)"  ///
      58 "Father or mother of Reference Person`=char(146)'s cohabitor (the cohabitor is coded 22 or 88)"  ///
      60 "Grandson or granddaughter of Reference Person (includes grandchildren of legal Spouse [code 20] only; those of a cohabitor are coded 97)"  ///
      65 "Great-grandson or great-granddaughter of Reference Person (includes great-grandchildren of legal Spouse [code 20]; those of a cohabitor are coded 97)"  ///
      66 "Grandfather or grandmother of Reference Person (includes stepgrandparents)"  ///
      67 "Grandfather or grandmother of legal Spouse (code 20)"  ///
      68 "Great-grandfather or great-grandmother of Reference Person"  ///
      69 "Great-grandfather or great-grandmother of legal Spouse (code 20)"  ///
      70 "Nephew or niece of Reference Person"  ///
      71 "Nephew or niece of legal Spouse (code 20)"  ///
      72 "Uncle or Aunt of Reference Person"  ///
      73 "Uncle or Aunt of legal Spouse (code 20)"  ///
      74 "Cousin of Reference Person"  ///
      75 "Cousin of legal Spouse (code 20)"  ///
      83 "Children of first-year cohabitor but not of Reference Person (the parent of this child is coded 88)"  ///
      88 "First-year cohabitor of Reference Person"  ///
      90 "Uncooperative legal spouse of Reference Person (this individual is unable or unwilling to be designated as Reference Person or Spouse)"  ///
      92 "Uncooperative partner of Reference Person (this individual is unable or unwilling to be designated as Partner)"  ///
      95 "Other relative of Reference Person"  ///
      96 "Other relative of legal Spouse (code 20)"  ///
      97 "Other relative of cohabitor (the cohabitor is code 22 or 88)"  ///
      98 "Other nonrelatives (includes friends of children of the FU, boyfriend/girlfriend of son/daughter, et al.)"  ///
       0 "Inap.:  from Latino sample (ER30001=7001-9308); main family nonresponse by 2023 or mover-out nonresponse by 2021 (ER35102=0)"

label define ER36001L  ///
       1 "Release number 1, June 2009"  ///
       2 "Release number 2, October 2009"  ///
       3 "Release number 3, January 2012"  ///
       4 "Release number 4, December 2013"  ///
       5 "Release number 5, February 2014"  ///
       6 "Release number 6, January 2016"  ///
       7 "Release number 7, November 2017"  ///
       8 "Release number 8, June 2023"

forvalues n = 1/56 {
    label define ER36004L `n' "Actual state (FIPS code)"  , modify
}
label define ER36004L       99 "DK; NA"  , modify
label define ER36004L        0 "Inap.:  U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER36016L `n' "Actual number"  , modify
}

label define ER36018L  ///
       1 "Male"  ///
       2 "Female"

label define ER36103L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER37018L  ///
       1 "Yes"  ///
       5 "No"  ///
       0 "Wild code"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER37351L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no wife/"wife" in FU; did not receive any income in 2006"'

label define ER37588L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.: does not have money in private annuities or IRAs"

label define ER37766L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.: has never worked for money; not currently employed; not covered by pension or retirement plan on current job and will not be; NA, DK, or RF whether covered by pension/retirement plan on current job; defined benefit formula only; NA, DK, or RF whether defined benefit formula, money accumulated or accrued, or both"

label define ER37998L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no wife/"wife" in FU; has never worked for money; not currently employed; not covered by pension or retirement plan on current job and will not be; NA, DK, or RF whether covered by pension/retirement plan on current job; defined benefit formula only; NA, DK, or RF whether defined benefit formula, money accumulated or accrued, or both"'

label define ER40471L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no wife/"wife" in FU; not Spanish, Hispanic or Latino"'

label define ER40472L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 `"Inap.: no wife/"wife" in FU;"'

label define ER40473L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU; no second mention; NA, DK to first mention"'

label define ER40474L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 `"Inap.:  no wife/"wife" in FU; fewer than three mentions; NA, DK to first mention"'

label define ER40475L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 `"Inap.: no wife/"wife" in FU; fewer than four mentions; NA, DK to first mention"'

label define ER40492L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 `"Inap.: no wife/"wife" in FU; educated outside the U.S. only or no education"'

label define ER40496L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 `"Inap.: no wife/"wife" in FU; educated outside the U.S. only or no education; no college; completed less than one year"'

label define ER40527L  ///
       1 "Reinterview family and FU has new head this year; splitoff or recontact interview"  ///
       5 "FU has same head as last wave"

label define ER40560L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       9 "NA; DK"

forvalues n = 1/56 {
    label define ER40561L `n' "Actual state (FIPS code)"  , modify
}
label define ER40561L       99 "DK; NA; refused"  , modify
label define ER40561L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER40564L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.: not Spanish, Hispanic or Latino"

label define ER40565L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       0 "Wild code"  ///
       9 "NA; DK"

label define ER40566L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 "Inap.: no second mention; NA, DK to first mention"

label define ER40567L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 "Inap.: fewer than three mentions; NA, DK to first mention"

label define ER40568L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "NA; DK"  ///
       0 "Inap.: fewer than four mentions; NA, DK to first mention"

label define ER40585L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 "Inap.: educated outside the U.S. only or no education"

label define ER40589L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "NA; DK"  ///
       0 "Inap.: educated outside the U.S. only or no education; no college; completed less than one year"

label define ER40996L  ///
       0 "Actual value"  ///
       5 "Imputed using the median value for all non-zero cases in the current year"

label define ER41035L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "NA; DK"

label define ER41036L  ///
       1 "Same state at both times:  ER40561 equals ER36004"  ///
       2 "Same region, but different state:  ER40561 does not equal ER36004 but ER41032 equals ER41035"  ///
       3 "Different regions:  ER41032 does not equal ER41035"  ///
       8 "DK"  ///
       9 "NA; ER36004 or ER40561 equals 99"
label define ER41037L        0 "Completed no grades of school"  , modify
forvalues n = 1/16 {
    label define ER41037L `n' "Actual number"  , modify
}
label define ER41037L       17 "At least some post-graduate work"  , modify
label define ER41037L       99 "NA; DK"  , modify

forvalues n = 1/16 {
    label define ER41038L `n' "Actual number"  , modify
}
label define ER41038L       17 "At least some post-graduate work"  , modify
label define ER41038L       99 "NA; DK"  , modify
label define ER41038L        0 `"Inap.:   no wife/"wife" in FU; completed no grades of school"'  , modify

label define ER42001L  ///
       1 "Release number 1, July 2011"  ///
       2 "Release number 2, November 2013"  ///
       3 "Release number 3, February 2014"  ///
       4 "Release number 4, January 2016"  ///
       5 "Release number 5, November 2017"  ///
       6 "Release number 6, June 2023"

forvalues n = 1/56 {
    label define ER42004L `n' "Actual state (FIPS code)"  , modify
}
label define ER42004L       99 "DK; NA"  , modify
label define ER42004L        0 "Inap.: U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER42016L `n' "Actual number"  , modify
}

label define ER42018L  ///
       1 "Male"  ///
       2 "Female"

label define ER42132L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER43009L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER43342L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU (ER42019=0) (ER43286=5); no income in 2008 (ER43287=5, 8, or 9)"'

label define ER43579L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs (ER43578=5, 8, or 9)"

label define ER43739L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  has never worked for money; not currently employed; not covered by pension or retirement plan on current job and will not be; DK, NA, or RF whether covered by pension/retirement plan on current job; defined benefit formula only; DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both"

label define ER43971L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU (ER42019=0); has never worked for money; not currently employed; not covered by pension or retirement plan on current job and will not be; DK, NA, or RF whether covered by pension/retirement plan on current job; defined benefit formula only; DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both"'

label define ER46448L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no wife/"wife" in FU (ER42019=0); not Spanish, Hispanic or Latino"'

label define ER46449L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA"  ///
       0 `"Inap.:  no wife/"wife" in FU (ER42019=0);"'

label define ER46450L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA"  ///
       0 `"Inap.:  no wife/"wife" in FU (ER42019=0); no second mention; NA, DK to first mention"'

label define ER46451L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA"  ///
       0 `"Inap.:  no wife/"wife" in FU (ER42019=0); fewer than three mentions; NA, DK to first mention"'

label define ER46452L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA"  ///
       0 `"Inap.:  no wife/"wife" in FU (ER42019=0); fewer than four mentions; NA, DK to first mention"'

label define ER46469L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA"  ///
       0 `"Inap.:  no wife/"wife" in FU (ER42019=0); educated outside the U.S. only or no education"'

label define ER46473L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA"  ///
       0 `"Inap.:  no wife/"wife" in FU (ER42019=0); educated outside the U.S. only or no education; no college; completed less than one year"'

label define ER46504L  ///
       1 "Reinterview family and FU has new head this year; splitoff or recontact interview"  ///
       5 "FU has same head as last wave"

label define ER46537L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       9 "DK; NA"

forvalues n = 1/56 {
    label define ER46538L `n' "Actual state (FIPS code)"  , modify
}
label define ER46538L       99 "DK; NA; refused"  , modify
label define ER46538L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER46542L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  not Spanish, Hispanic or Latino"

label define ER46543L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA"

label define ER46544L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA"  ///
       0 "Inap.:  no second mention; NA, DK to first mention"

label define ER46545L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA"  ///
       0 "Inap.:  fewer than three mentions; NA, DK to first mention"

label define ER46546L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA"  ///
       0 "Inap.:  fewer than four mentions; NA, DK to first mention"

label define ER46563L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA"  ///
       0 "Inap.:  educated outside the U.S. only or no education"

label define ER46567L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA"  ///
       0 "Inap.:  educated outside the U.S. only or no education; no college; completed less than one year"

label define ER46904L  ///
       0 "Actual value"  ///
       1 "Imputed by PSID staff during data cleaning and editing"  ///
       5 "Imputed using the median value for all non-zero cases in the current year"

label define ER46936L  ///
       0 "No"  ///
       1 "Yes"

label define ER46937L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46939L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46943L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46947L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46948L  ///
       0 "No"  ///
       1 "Yes"

label define ER46949L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46951L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46952L  ///
       0 "No"  ///
       1 "Yes"

label define ER46953L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46955L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46957L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46961L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46962L  ///
       0 "No"  ///
       1 "Yes"

label define ER46963L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46965L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46967L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46969L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46971L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER46977L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "DK; NA"

label define ER46978L  ///
       1 "Same state at both times:  ER46538 equals ER42004"  ///
       2 "Same region, but different state:  ER46538 does not equal ER42004 but ER46974 equals ER46977"  ///
       3 "Different regions:  ER46974 does not equal ER46977"  ///
       8 "DK"  ///
       9 "NA; ER42004 or ER46538 equals 99"
label define ER46981L        0 "Completed no grades of school"  , modify
forvalues n = 1/16 {
    label define ER46981L `n' "Actual number"  , modify
}
label define ER46981L       17 "At least some post-graduate work"  , modify
label define ER46981L       99 "DK; NA"  , modify

forvalues n = 1/16 {
    label define ER46982L `n' "Actual number"  , modify
}
label define ER46982L       17 "At least some post-graduate work"  , modify
label define ER46982L       99 "DK; NA"  , modify
label define ER46982L        0 `"Inap.:   no wife/"wife" in FU (ER42019=0); completed no grades of school"'  , modify

label define ER47301L  ///
       1 "Release number 1, July 2013"  ///
       2 "Release number 2, November 2013"  ///
       3 "Release number 3, February 2014"  ///
       4 "Release number 4, January 2016"  ///
       5 "Release number 5, November 2017"  ///
       6 "Release number 6, June 2023"

forvalues n = 1/56 {
    label define ER47304L `n' "Actual state (FIPS code)"  , modify
}
label define ER47304L       99 "DK; NA"  , modify
label define ER47304L        0 "Inap.: U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER47316L `n' "Actual number"  , modify
}

label define ER47318L  ///
       1 "Male"  ///
       2 "Female"

label define ER47440L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER48331L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER48667L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER47319=0) (ER48611=5); no income in 2010 (ER48612=5); NA, DK, RF whether received income in 2010 (ER48612=8 or 9)"'

label define ER48904L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs (ER48903=5); NA, DK, RF whether has money in private annuities or IRAs (ER48903=8 or 9)"

label define ER49085L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  not currently employed (ER47448,  ER47449, or  ER47450 does not = 1 or 2 and  ER47452=5); DK, NA, or RF whether currently employed (ER47448=99); DK, NA, or RF whether doing any work for money now (ER47452=8 or 9); has never worked for money (ER49056=2); is not participating in a pension or retirement plan through current job or union (ER49057=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER49057=8 or 9); defined benefit formula only (ER49074=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both (ER49074=8 or 9)"

label define ER49304L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no Wife/"Wife" in FU (ER47319=0); not currently employed (ER47705, ER47706, or ER47707 does not = 1 or 2 and ER47709=5); DK, NA, or RF whether currently employed (ER47705=99); DK, NA, or RF whether doing any work for money now (ER47709=8 or 9); has never worked for money (ER47946=5); DK, NA, or RF whether has ever worked (ER47946=8 or 9); not covered by pension or retirement plan through current job or union (ER49276=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER49276=8 or 9); defined benefit formula only (ER49293=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued (ER49293=8 or 9)"'

label define ER51809L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER47319=0); not Spanish, Hispanic or Latino"'

label define ER51810L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER47319=0)"'

label define ER51811L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER47319=0); NA, DK, RF to first mention (ER51810=8 or 9); no second mention"'

label define ER51812L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  fewer than three mentions; no Wife/"Wife" in FU (ER47319=0); NA, DK, RF to first mention (ER51810=8 or 9)"'

label define ER51813L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  fewer than four mentions; no Wife/"Wife" in FU (ER47319=0); NA, DK, RF to first mention (ER51810=8 or 9)"'

label define ER51830L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER47319=0); educated outside the U.S. only or had no education (ER51818=2 or 5); NA, RF where Wife/"Wife" received her education (ER51818=9)"'

label define ER51834L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER47319=0); educated outside the U.S. only or had no education (ER51818=2 or 5); NA, RF where Wife/"Wife" received her education (ER51818=9); did not attend college (ER51830=5); NA, DK, RF whether attended college (ER51830=8 or 9); completed less than one year of college (ER51833=0)"'

label define ER51865L  ///
       1 "reinterview family and FU has new head this year; splitoff or recontact interview"  ///
       5 "FU has same head as last wave"

label define ER51898L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"

forvalues n = 1/56 {
    label define ER51899L `n' "Actual state (FIPS code)"  , modify
}
label define ER51899L       99 "DK; NA; refused"  , modify
label define ER51899L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER51903L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  not Spanish, Hispanic or Latino"

label define ER51904L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER51905L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  NA, DK, RF to first mention (ER51904=8 or 9); no second mention"

label define ER51906L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  fewer than three mentions; NA, DK, RF to first mention (ER51904=8 or 9)"

label define ER51907L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  fewer than four mentions; NA, DK, RF to first mention (ER51904=8 or 9)"

label define ER51924L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER51912=2 or 5); NA, RF where Head received education (ER51912=9)"

label define ER51928L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER51912=2 or 5); NA, RF where Head received education (ER51912=9); did not attend college (ER51924=5); NA, DK, RF whether attended college (ER51924=8 or 9); completed less than one year of college (ER51927=0)"

label define ER52312L  ///
       0 "Actual value"  ///
       1 "Imputed by PSID staff during data cleaning and editing"  ///
       5 "Imputed using the median value for all non-zero cases of OFUM`=char(146)'s 2010 labor income"

label define ER52344L  ///
       0 "No"  ///
       1 "Yes"

label define ER52345L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52347L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52351L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52352L  ///
       0 "No"  ///
       1 "Yes"

label define ER52353L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52355L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52356L  ///
       0 "No"  ///
       1 "Yes"

label define ER52357L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52359L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52361L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52365L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52366L  ///
       0 "No"  ///
       1 "Yes"

label define ER52367L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52369L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52391L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52393L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52395L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER52401L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "DK; NA"

label define ER52402L  ///
       1 "Same state at both times: ER51899 equals ER47304"  ///
       2 "Same region, but different state:   ER51899 does not equal  ER47304 but  ER52398 equals  ER52401"  ///
       3 "Different regions: ER52398 does not equal ER52401"  ///
       8 "DK"  ///
       9 "NA; ER47304 or ER51899 equals 99"
label define ER52405L        0 "Completed no grades of school"  , modify
forvalues n = 1/16 {
    label define ER52405L `n' "Actual number"  , modify
}
label define ER52405L       17 "At least some post-graduate work"  , modify
label define ER52405L       99 "DK; NA"  , modify

forvalues n = 1/16 {
    label define ER52406L `n' "Actual number"  , modify
}
label define ER52406L       17 "At least some post-graduate work"  , modify
label define ER52406L       99 "DK; NA"  , modify
label define ER52406L        0 `"Inap.:   no Wife/"Wife" in FU (ER47319=0); completed no grades of school"'  , modify

label define ER53001L  ///
       1 "Release number 1, May 2015"  ///
       2 "Release number 2, January 2016"  ///
       3 "Release number 3, November 2017"  ///
       4 "Release number 4, June 2023"

forvalues n = 1/56 {
    label define ER53004L `n' "Actual state (FIPS code)"  , modify
}
label define ER53004L       99 "DK; NA"  , modify
label define ER53004L        0 "Inap.: U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER53016L `n' "Actual number"  , modify
}

label define ER53018L  ///
       1 "Male"  ///
       2 "Female"

label define ER53140L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER54008L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER54361L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU  (ER54305=5); no income in 2012 (ER54306=5); DK, NA, or RF whether received income in 2012 (ER54306=8 or 9)"'

label define ER54654L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs (ER54653=5); DK, NA, or RF whether has money in private annuities or IRAs (ER54653=8 or 9)"

label define ER54841L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  not currently employed (ER53148, ER53149, or ER53150 ne 1 or 2 and ER53152=5); DK, NA, or RF whether currently employed (ER53148=99); DK, NA, or RF whether doing any work for money now (ER53152=8 or 9); has never worked for money (ER54812=2); is not participating in a pension or retirement plan through current job or union (ER54813=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER54813=8 or 9); defined benefit formula only (ER54828=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both (ER54828=8 or 9)"

label define ER55057L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 `"Inap.: no Wife/"Wife" in FU (ER54305=5); not currently employed (ER53411, ER53412, or ER53413 ne 1 or 2 and ER53415=5); DK, NA, or RF whether currently employed (ER53411=99); DK, NA, or RF whether doing any work for money now (ER53415=8 or 9); has never worked for money (ER53652=5); DK, NA, or RF whether has ever worked (ER53652=8 or 9); not covered by pension or retirement plan through current job or union (ER55029=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER55029=8 or 9); defined benefit formula only (ER55044=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued (ER55044=8 or 9)"'

label define ER57548L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER54305=5); not Spanish, Hispanic or Latino"'

label define ER57549L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER54305=5)"'

label define ER57550L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER54305=5); DK, NA, or RF to first mention (ER57549=8 or 9); no second mention"'

label define ER57551L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 `"Inap.:  fewer than three mentions; no Wife/"Wife" in FU (ER54305=5); DK, NA, or RF to first mention (ER57549=8 or 9)"'

label define ER57552L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 `"Inap.:  fewer than four mentions; no Wife/"Wife" in FU (ER54305=5); DK, NA, or RF to first mention (ER57549=8 or 9)"'

label define ER57570L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER54305=5); educated outside the U.S. only or had no education (ER57558=2 or 5); NA, RF where Wife/"Wife" received her education (ER57558=9)"'

label define ER57574L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 `"Inap.:  no Wife/"Wife" in FU (ER54305=5); educated outside the U.S. only or had no education (ER57558=2 or 5); NA, RF where Wife/"Wife" received her education (ER57558=9); did not attend college (ER57570=5); DK, NA, or RF whether attended college (ER57570=8 or 9); completed less than one year of college (ER57573=0)"'

label define ER57618L  ///
       1 `"Reinterview Family and FU has a HD who was not a Head/Wife/"Wife" in a previous wave;  Splitoff or Recontact Interview"'  ///
       5 `"Head in the FU who has been a Head/Wife/"Wife" in a previous wave"'

label define ER57653L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       9 "DK; NA; refused"

forvalues n = 1/56 {
    label define ER57654L `n' "Actual state (FIPS code)"  , modify
}
label define ER57654L       99 "DK; NA; refused"  , modify
label define ER57654L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER57658L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  not Spanish, Hispanic or Latino"

label define ER57659L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"

label define ER57660L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER57659=8 or 9); no second mention"

label define ER57661L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  fewer than three mentions; DK, NA, or RF to first mention (ER57659=8 or 9)"

label define ER57662L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  fewer than four mentions; DK, NA, or RF to first mention (ER57659=8 or 9)"

label define ER57680L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER57668=2 or 5); NA, RF where Head received education (ER57668=9)"

label define ER57684L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER57668=2 or 5); NA, RF where Head received education (ER57668=9); did not attend college (ER57680=5); DK, NA, or RF whether attended college (ER57680=8 or 9); completed less than one year of college (ER57683=0)"

label define ER58121L  ///
       0 "Actual value"  ///
       1 "Imputed by PSID staff during data cleaning and editing"  ///
       5 "Imputed using the median value for all non-zero cases of OFUM`=char(146)'s 2012 labor income"

label define ER58153L  ///
       0 "No"  ///
       1 "Yes"

label define ER58154L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58156L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58158L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58162L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58163L  ///
       0 "No"  ///
       1 "Yes"

label define ER58164L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58169L  ///
       0 "No"  ///
       1 "Yes"

label define ER58170L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58172L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58174L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58178L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58179L  ///
       0 "No"  ///
       1 "Yes"

label define ER58180L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58182L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58208L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58210L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58212L  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define ER58219L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "DK; NA"

label define ER58220L  ///
       1 "Same state at both times:   ER57654 equals  ER53004"  ///
       2 "Same region, but different state:     ER57654 does not equal    ER53004 but    ER58215 equals    ER58219"  ///
       3 "Different regions:   ER58215 does not equal  ER58219"  ///
       8 "DK"  ///
       9 "NA;  ER53004 or  ER57654 equals 99"
label define ER58223L        0 "Completed no grades of school"  , modify
forvalues n = 1/17 {
    label define ER58223L `n' "Actual number"  , modify
}
label define ER58223L       99 "DK; NA"  , modify

forvalues n = 1/17 {
    label define ER58224L `n' "Actual number"  , modify
}
label define ER58224L       99 "DK; NA"  , modify
label define ER58224L        0 `"Inap.:   no Wife/"Wife" in FU (ER54305=5); completed no grades of school"'  , modify

label define ER60001L  ///
       1 "Release number 1, May 2017"  ///
       2 "Release number 2, June 2023"

forvalues n = 1/56 {
    label define ER60004L `n' "Actual state (FIPS code)"  , modify
}
label define ER60004L       99 "DK; NA"  , modify
label define ER60004L        0 "Inap.: U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER60016L `n' "Actual number"  , modify
}

label define ER60018L  ///
       1 "Male"  ///
       2 "Female"

label define ER60020L  ///
       2 "Female"  ///
       0 "Inap.:  Head is female or single male; no Spouse/Partner in FU (ER61347=5)"

label define ER60155L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER61050L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER61437L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER61347=5)"

label define ER61765L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs (ER61764=5); DK, NA, or RF whether has money in private annuities or IRAs (ER61764=8 or 9)"

label define ER61961L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  not currently employed (ER60163,  ER60164, or  ER60165 ne 1 or 2 and  ER60167=5); DK, NA, or RF whether currently employed (ER60163=99); DK, NA, or RF whether doing any work for money now (ER60167=8 or 9); has never worked for money (ER61932=2); is not participating in a pension or retirement plan through current job or union (ER61933=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER61933=8 or 9); defined benefit formula only (ER61948=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both (ER61948=8 or 9)"

label define ER62178L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.: no Spouse/Partner in FU (ER61347=5); not currently employed (ER60426,  ER60427, or  ER60428 ne 1 or 2 and  ER60430=5); DK, NA, or RF whether currently employed (ER60426=99); DK, NA, or RF whether doing any work for money now (ER60430=8 or 9); has never worked for money (ER60667=5); DK, NA, or RF whether has ever worked (ER60667=8 or 9); not covered by pension or retirement plan through current job or union (ER62150=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER62150=8 or 9); defined benefit formula only (ER62165=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued (ER62165=8 or 9)"

label define ER64670L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER61347=5); not Spanish, Hispanic or Latino"

label define ER64671L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER61347=5)"

label define ER64672L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER61347=5); DK, NA, or RF to first mention (ER64671=9); no second mention"

label define ER64673L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER61347=5); DK, NA, or RF to first mention (ER64671=9); fewer than three mentions"

label define ER64674L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER61347=5); DK, NA, or RF to first mention (ER64671=9); fewer than four mentions"

label define ER64693L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER61347=5); educated outside the U.S. only or had no education (ER64681=2 or 5); NA or RF where Spouse/Partner received education (ER64681=9)"

label define ER64697L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER61347=5); educated outside the U.S. only or had no education (ER64681=2 or 5); NA or RF where Spouse/Partner received education (ER64681=9); did not attend college (ER64693=5); DK, NA, or RF whether attended college (ER64693=9); completed less than one year of college (ER64696=0)"

label define ER64769L  ///
       1 "Reinterview Family and FU has a HD who was not a Head/Spouse/Partner in a previous wave; Splitoff or Recontact Interview"  ///
       5 "Head in the FU who has been a Head/Spouse/Partner in a previous wave"

label define ER64804L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       9 "DK; NA; refused"

forvalues n = 1/56 {
    label define ER64805L `n' "Actual state (FIPS code)"  , modify
}
label define ER64805L       99 "DK; NA; refused"  , modify
label define ER64805L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER64809L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  not Spanish, Hispanic or Latino"

label define ER64810L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"

label define ER64811L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER64810=9); no second mention"

label define ER64812L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER64810=9); fewer than three mentions"

label define ER64813L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER64810=9); fewer than four mentions"

label define ER64832L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER64820=2 or 5); NA or RF where Head received education (ER64820=9)"

label define ER64836L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER64820=2 or 5); NA or RF where Head received education (ER64820=9); did not attend college (ER64832=5); DK, NA, or RF whether attended college (ER64832=9); completed less than one year of college (ER64835=0)"

label define ER65318L  ///
       1 "Imputed by PSID staff during data cleaning and editing"  ///
       5 "Imputed using the median value for all non-zero cases of OFUM`=char(146)'s 2014 labor income"  ///
       0 "Inap.:  not imputed; no other family unit members; no other FU member with income in 2014"

label define ER65350L  ///
       0 "No"  ///
       1 "Yes"

label define ER65351L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part or all of a farm or business"

label define ER65353L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part or all of a farm or business"

label define ER65355L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part of all of a farm or business"

label define ER65359L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in any of the following:  checking or savings accounts, money market funds, certificates of deposit, government bonds, or treasury bills"

label define ER65360L  ///
       0 "No"  ///
       1 "Yes"

label define ER65361L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own any other real estate other than main home"

label define ER65366L  ///
       0 "No"  ///
       1 "Yes"

label define ER65367L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any shares of stock in publicly-held corporations, stock mutual funds, or investment trusts"

label define ER65369L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any shares of stock in publicly-held corporations, stock mutual funds, or investment trusts"

label define ER65371L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own anything on wheels"

label define ER65375L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any other savings or assets"

label define ER65376L  ///
       0 "No"  ///
       1 "Yes"

label define ER65377L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in private annuities or IRAs"

label define ER65379L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in private annuities or IRAs"

label define ER65405L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own a home"

label define ER65407L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any assets"

label define ER65409L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any assets or home equity"

label define ER65455L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "DK; NA"

label define ER65456L  ///
       1 "Same state at both times:  ER64805 equals ER60004"  ///
       2 "Same region but different state:  ER64805 does not equal ER60004 but     ER65451 equals ER65455"  ///
       3 "Different regions:  ER65451 does not equal ER65455"  ///
       8 "DK"  ///
       9 "NA; ER60004 or ER64805 equals 99"
label define ER65459L        0 "Completed no grades of school"  , modify
forvalues n = 1/17 {
    label define ER65459L `n' "Actual number"  , modify
}
label define ER65459L       99 "DK; NA"  , modify

forvalues n = 1/17 {
    label define ER65460L `n' "Actual number"  , modify
}
label define ER65460L       99 "DK; NA"  , modify
label define ER65460L        0 "Inap.:  completed no grades of school; no Spouse/Partner in FU (ER61347=5)"  , modify

label define ER66001L  ///
       1 "Release number 1, February 2019"  ///
       2 "Release number 2, August 2019"  ///
       3 "Release number 3, June 2023"

forvalues n = 1/56 {
    label define ER66004L `n' "Actual state (FIPS code)"  , modify
}
label define ER66004L       99 "DK; NA"  , modify
label define ER66004L        0 "Inap.: U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER66016L `n' "Actual number"  , modify
}

label define ER66018L  ///
       1 "Male"  ///
       2 "Female"

label define ER66020L  ///
       1 "Male"  ///
       2 "Female"  ///
       0 "Inap.:  Reference Person is single male or female; no Spouse/Partner in FU (ER67399=5)"

label define ER66156L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER67102L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER67457L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER67399=5)"

label define ER67818L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs (ER67817=5); DK, NA, or RF whether has money in private annuities or IRAs (ER67817=8 or 9)"

label define ER68015L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  not currently employed (ER66164,ER66165, orER66166 ne 1 or 2 andER66168=5); DK, NA, or RF whether currently employed (ER66164=99); DK, NA, or RF whether doing any work for money now (ER66168=8 or 9); has never worked for money (ER67986=2); is not participating in a pension or retirement plan through current job or union (ER67987=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER67987=8 or 9); defined benefit formula only (ER68002=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both (ER68002=8 or 9)"

label define ER68232L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER67399=5); not currently employed (ER66439,ER66440, orER66441 ne 1 or 2 andER66443=5); DK, NA, or RF whether currently employed (ER66439=99); DK, NA, or RF whether doing any work for money now (ER66443=8 or 9); has never worked for money (ER66688=5); DK, NA, or RF whether has ever worked (ER66688=8 or 9); not covered by pension or retirement plan through current job or union (ER68204=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER68204=8 or 9); defined benefit formula only (ER68219=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued (ER68219=8 or 9)"

label define ER70743L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER67399=5); not Spanish, Hispanic or Latino"

label define ER70744L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER67399=5)"

label define ER70745L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER67399=5); DK, NA, or RF to first mention (ER70744=9); no second mention"

label define ER70746L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER67399=5); DK, NA, or RF to first mention (ER70744=9); fewer than three mentions"

label define ER70747L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER67399=5); DK, NA, or RF to first mention (ER70744=9); fewer than four mentions"

label define ER70766L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER67399=5); educated outside the U.S. only or had no education (ER70754=2 or 5); NA or RF where Spouse/Partner received education (ER70754=9)"

label define ER70770L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER67399=5); educated outside the U.S. only or had no education (ER70754=2 or 5); NA or RF where Spouse/Partner received education (ER70754=9); did not attend college (ER70766=5); DK, NA, or RF whether attended college (ER70766=9); completed less than one year of college (ER70769=0)"

label define ER70841L  ///
       1 "Reinterview Family and FU has a RP who was not a Reference Person/Spouse/Partner in a previous wave; Splitoff or Recontact Interview"  ///
       5 "Reference Person in the FU who has been a Reference Person/Spouse/Partner in a previous wave"

label define ER70876L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       9 "DK; NA; refused"

forvalues n = 1/56 {
    label define ER70877L `n' "Actual state (FIPS code)"  , modify
}
label define ER70877L       99 "DK; NA; refused"  , modify
label define ER70877L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER70881L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  not Spanish, Hispanic or Latino"

label define ER70882L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"

label define ER70883L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER70882=9); no second mention"

label define ER70884L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER70882=9); fewer than three mentions"

label define ER70885L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER70882=9); fewer than four mentions"

label define ER70904L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER70892=2 or 5); NA or RF where Reference Person received education (ER70892=9)"

label define ER70908L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER70892=2 or 5); NA or RF where Reference Person received education (ER70892=9); did not attend college (ER70904=5); DK, NA, or RF whether attended college (ER70904=9); completed less than one year of college (ER70907=0)"

label define ER71395L  ///
       1 "Imputed by PSID staff during data cleaning and editing"  ///
       5 "Imputed using the median value for all non-zero cases of OFUM`=char(146)'s 2016 labor income"  ///
       0 "Inap.:  not imputed; no other family unit members; no other FU member with income in 2016"

label define ER71427L  ///
       0 "No"  ///
       1 "Yes"

label define ER71428L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part or all of a farm or business"

label define ER71430L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part or all of a farm or business"

label define ER71432L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part of all of a farm or business"

label define ER71436L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in any of the following:  checking or savings accounts, money market funds, certificates of deposit, government bonds, or treasury bills"

label define ER71437L  ///
       0 "No"  ///
       1 "Yes"

label define ER71438L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own any other real estate other than main home"

label define ER71443L  ///
       0 "No"  ///
       1 "Yes"

label define ER71444L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any shares of stock in publicly-held corporations, stock mutual funds, or investment trusts"

label define ER71446L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any shares of stock in publicly-held corporations, stock mutual funds, or investment trusts"

label define ER71448L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own anything on wheels"

label define ER71452L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any other savings or assets"

label define ER71453L  ///
       0 "No"  ///
       1 "Yes"

label define ER71454L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in private annuities or IRAs"

label define ER71456L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in private annuities or IRAs"

label define ER71482L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own a home"

label define ER71484L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any assets"

label define ER71486L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any assets or home equity"

label define ER71534L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "DK; NA"

label define ER71535L  ///
       1 "Same state at both times: ER70877 equals ER66004"  ///
       2 "Same region but different state: ER70877 does not equal ER66004 but ER71530 equals ER71534"  ///
       3 "Different regions: ER71530 does not equal ER71534"  ///
       8 "DK"  ///
       9 "NA; ER66004 or ER70877 equals 99"
label define ER71538L        0 "Completed no grades of school"  , modify
forvalues n = 1/17 {
    label define ER71538L `n' "Actual number"  , modify
}
label define ER71538L       99 "DK; NA"  , modify

forvalues n = 1/17 {
    label define ER71539L `n' "Actual number"  , modify
}
label define ER71539L       99 "DK; NA"  , modify
label define ER71539L        0 "Inap.:  completed no grades of school; no Spouse/Partner in FU (ER67399=5)"  , modify

label define ER72001L  ///
       1 "Release number 1, March 2021"

forvalues n = 1/56 {
    label define ER72004L `n' "Actual state (FIPS code)"  , modify
}
label define ER72004L       99 "DK; NA"  , modify
label define ER72004L        0 "Inap.: U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER72016L `n' "Actual number"  , modify
}

label define ER72018L  ///
       1 "Male"  ///
       2 "Female"

label define ER72020L  ///
       1 "Male"  ///
       2 "Female"  ///
       0 "Inap.:  Reference Person is single male or female; no Spouse/Partner in FU (ER73422=5)"

label define ER72156L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER73125L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER73480L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER73422=5)"

label define ER73841L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annunities or IRAs (ER73840=5); DK, NA, or RF whether has money in private annunities or IRAs (ER73840=8 or 9)"

label define ER74041L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.: not working now (ER74014=2, 3, or 5); is not participating in a pension or retirement plan through current job or union (ER74015=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER74015=8 or 9); defined benefit formula only (ER74030=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both (ER74030=8 or 9)"

label define ER74248L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER73422=5); not working now (ER74221=2, 3, or 5); is not participating in a pension or retirement plan through current job or union (ER74222=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER74222=8 or 9); defined benefit formula only (ER74237=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both (ER74237=8 or 9)"

label define ER76751L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER73422=5); not Spanish, Hispanic or Latino"

label define ER76752L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER73422=5)"

label define ER76753L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER73422=5); DK, NA, or RF to first mention (ER76752=9); no second mention"

label define ER76754L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER73422=5); DK, NA, or RF to first mention (ER76752=9); fewer than three mentions"

label define ER76755L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER73422=5); DK, NA, or RF to first mention (ER76752=9); fewer than four mentions"

label define ER76774L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER73422=5); educated outside the U.S. only or had no education (ER76762=2 or 5); NA or RF where Spouse/Partner received education (ER76762=9)"

label define ER76778L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER73422=5); educated outside the U.S. only or had no education (ER76762=2 or 5); NA or RF where Spouse/Partner received education (ER76762=9); did not attend college (ER76774=5); DK, NA, or RF whether attended college (ER76774=9); completed less than one year of college (ER76777=0)"

label define ER76856L  ///
       1 "Reinterview Family and FU has a RP who was not a Reference Person/Spouse/Partner in a previous wave; Splitoff or Recontact Interview"  ///
       5 "Reference Person in the FU who has been a Reference Person/Spouse/Partner in a previous wave"

label define ER76891L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       9 "DK; NA; refused"

forvalues n = 1/56 {
    label define ER76892L `n' "Actual state (FIPS code)"  , modify
}
label define ER76892L       99 "DK; NA; refused"  , modify
label define ER76892L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER76896L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  not Spanish, Hispanic or Latino"

label define ER76897L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"

label define ER76898L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER76897=9); no second mention"

label define ER76899L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER76897=9); fewer than three mentions"

label define ER76900L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER76897=9); fewer than four mentions"

label define ER76919L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER76907=2 or 5); NA or RF where Reference Person received education (ER76907=9)"

label define ER76923L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER76907=2 or 5); NA or RF where Reference Person received education (ER76907=9); did not attend college (ER76919=5); DK, NA, or RF whether attended college (ER76919=9); completed less than one year of college (ER76922=0)"

label define ER77417L  ///
       1 "Imputed by PSID staff during data cleaning and editing"  ///
       5 "Imputed using the median value for all non-zero cases of OFUM`=char(146)'s 2018 labor income"  ///
       0 "Inap.:  not imputed; no other family unit members; no other FU member with income in 2018"

label define ER77449L  ///
       0 "No"  ///
       1 "Yes"

label define ER77450L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part or all of a farm or business"

label define ER77452L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part or all of a farm or business"

label define ER77454L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part of all of a farm or business"

label define ER77458L  ///
       1 "Imputed"  ///
       0 "Inap.: not imputed; does not have money in a checking, savings or money market accounts"

label define ER77462L  ///
       1 "Imputed"  ///
       0 "Inap.: not imputed; does not have money in certficates of deposit, government bonds or treasury bills"

label define ER77463L  ///
       0 "No"  ///
       1 "Yes"

label define ER77464L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own any other real estate other than main home"

label define ER77469L  ///
       0 "No"  ///
       1 "Yes"

label define ER77470L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any shares of stock in publicly-held corporations, stock mutual funds, or investment trusts"

label define ER77472L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any shares of stock in publicly-held corporations, stock mutual funds, or investment trusts"

label define ER77474L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own anything on wheels"

label define ER77478L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any other savings or assets"

label define ER77479L  ///
       0 "No"  ///
       1 "Yes"

label define ER77480L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in private annuities or IRAs"

label define ER77482L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in private annuities or IRAs"

label define ER77508L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own a home"

label define ER77510L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any assets"

label define ER77512L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any assets or home equity"

label define ER77595L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "DK; NA"

label define ER77596L  ///
       1 "Same state at both times: ER76892 equals ER72004"  ///
       2 "Same region but different state: ER76892 does not equal ER72004 but ER77591 equals ER77595"  ///
       3 "Different regions: ER77591 does not equal ER77595"  ///
       8 "DK"  ///
       9 "NA; ER72004 or ER76892 equals 99"
label define ER77599L        0 "Completed no grades of school"  , modify
forvalues n = 1/17 {
    label define ER77599L `n' "Actual number"  , modify
}
label define ER77599L       99 "DK; NA"  , modify

forvalues n = 1/17 {
    label define ER77600L `n' "Actual number"  , modify
}
label define ER77600L       99 "DK; NA"  , modify
label define ER77600L        0 "Inap.:  completed no grades of school; no Spouse/Partner in FU (ER73422=5)"  , modify

label define ER78001L  ///
       1 "Release number 1, June 2023"  ///
       2 "Release number 2, October 2023"  ///
       3 "Release number 3, May 2025"

forvalues n = 1/56 {
    label define ER78004L `n' "Actual state (FIPS code)"  , modify
}
label define ER78004L       99 "DK; NA"  , modify
label define ER78004L        0 "Inap.: U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER78016L `n' "Actual number"  , modify
}

label define ER78018L  ///
       1 "Male"  ///
       2 "Female"

label define ER78020L  ///
       1 "Male"  ///
       2 "Female"  ///
       0 "Inap.:  Reference Person is single male or female; no Spouse/Partner in FU (ER79524=5)"

label define ER78158L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER79222L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER79602L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER79524=5)"

label define ER79963L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs (ER79962=5); DK, NA, or RF whether has money in private annuities or IRAs (ER79962=8 or 9)"

label define ER80164L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.: not working now (ER80137=2, 3, or 5); is not participating in a pension or retirement plan through current job or union (ER80138=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER80138=8 or 9); defined benefit formula only (ER80153=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both (ER80153=8 or 9)"

label define ER80370L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER79524=5); not working now (ER80343=2, 3, or 5); is not participating in a pension or retirement plan through current job or union (ER80344=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER80344=8 or 9); defined benefit formula only (ER80359=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both (ER80359=8 or 9)"

label define ER81016L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER79524=5); not Spanish, Hispanic or Latino"

label define ER81017L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER79524=5)"

label define ER81018L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER79524=5); DK, NA, or RF to first mention (ER81017=9); no second mention"

label define ER81019L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER79524=5); DK, NA, or RF to first mention (ER81017=9); fewer than three mentions"

label define ER81020L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER79524=5); DK, NA, or RF to first mention (ER81017=9); fewer than four mentions"

label define ER81039L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER79524=5); educated outside the U.S. only or had no education (ER81027=2 or 5); NA or RF where Spouse/Partner received education (ER81027=9)"

label define ER81043L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER79524=5); educated outside the U.S. only or had no education (ER81027=2 or 5); NA or RF where Spouse/Partner received education (ER81027=9); did not attend college (ER81039=5); DK, NA, or RF whether attended college (ER81039=9); completed less than one year of college (ER81042=0)"

label define ER81103L  ///
       1 "Reinterview Family and FU has a RP who was not a Reference Person/Spouse/Partner in a previous wave; Splitoff or Recontact Interview"  ///
       5 "Reference Person in the FU who has been a Reference Person/Spouse/Partner in a previous wave"

label define ER81138L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       9 "DK; NA; refused"

forvalues n = 1/56 {
    label define ER81139L `n' "Actual state (FIPS code)"  , modify
}
label define ER81139L       99 "DK; NA; refused"  , modify
label define ER81139L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER81143L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  not Spanish, Hispanic or Latino"

label define ER81144L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"

label define ER81145L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER81144=9); no second mention"

label define ER81146L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER81144=9); fewer than three mentions"

label define ER81147L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER81144=9); fewer than four mentions"

label define ER81166L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER81154=2 or 5); NA or RF where Reference Person received education (ER81154=9)"

label define ER81170L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER81154=2 or 5); NA or RF where Reference Person received education (ER81154=9); did not attend college (ER81166=5); DK, NA, or RF whether attended college (ER81166=9); completed less than one year of college (ER81169=0)"

label define ER81744L  ///
       1 "Imputed by PSID staff during data cleaning and editing"  ///
       5 "Imputed using the median value for all non-zero cases of OFUM`=char(146)'s 2020 labor income"  ///
       0 "Inap.:  not imputed; no other family unit members; no other FU member with income in 2020"

label define ER81776L  ///
       0 "No"  ///
       1 "Yes"

label define ER81777L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part or all of a farm or business"

label define ER81779L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part or all of a farm or business"

label define ER81781L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part of all of a farm or business"

label define ER81785L  ///
       1 "Imputed"  ///
       0 "Inap.: not imputed; does not have money in a checking, savings or money market accounts"

label define ER81789L  ///
       1 "Imputed"  ///
       0 "Inap.: not imputed; does not have money in certificates of deposit, government bonds or treasury bills"

label define ER81790L  ///
       0 "No"  ///
       1 "Yes"

label define ER81791L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own any other real estate other than main home"

label define ER81796L  ///
       0 "No"  ///
       1 "Yes"

label define ER81797L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any shares of stock in publicly-held corporations, stock mutual funds, or investment trusts"

label define ER81799L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any shares of stock in publicly-held corporations, stock mutual funds, or investment trusts"

label define ER81801L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own anything on wheels"

label define ER81805L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any other savings or assets"

label define ER81806L  ///
       0 "No"  ///
       1 "Yes"

label define ER81807L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in private annuities or IRAs"

label define ER81809L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in private annuities or IRAs"

label define ER81835L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own a home"

label define ER81837L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any assets"

label define ER81839L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any assets or home equity"

label define ER81922L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "DK; NA"

label define ER81923L  ///
       1 "Same state at both times: ER81139 equals ER78004"  ///
       2 "Same region but different state: ER81139 does not equal ER78004 but ER81918 equals ER81922"  ///
       3 "Different regions: ER81918 does not equal ER81922"  ///
       8 "DK"  ///
       9 "NA; ER78004 or ER81139 equals 99"
label define ER81926L        0 "Completed no grades of school"  , modify
forvalues n = 1/17 {
    label define ER81926L `n' "Actual number"  , modify
}
label define ER81926L       99 "DK; NA"  , modify

forvalues n = 1/17 {
    label define ER81927L `n' "Actual number"  , modify
}
label define ER81927L       99 "DK; NA"  , modify
label define ER81927L        0 "Inap.:  completed no grades of school; no Spouse/Partner in FU (ER79524=5)"  , modify

label define ER82001L  ///
       1 "Release number 1, May 2025"

forvalues n = 1/56 {
    label define ER82004L `n' "Actual state (FIPS code)"  , modify
}
label define ER82004L       99 "DK; NA"  , modify
label define ER82004L        0 "Inap.: U.S. territory or foreign country"  , modify

forvalues n = 1/20 {
    label define ER82017L `n' "Actual number"  , modify
}

label define ER82019L  ///
       1 "Male"  ///
       2 "Female"

label define ER82021L  ///
       1 "Male"  ///
       2 "Female"  ///
       0 "Inap.:  Reference Person is single male or female; no Spouse/Partner in FU (ER83493=5)"

label define ER82141L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER83197L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"

label define ER83571L  ///
       1 "Yes"  ///
       5 "No"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER83493=5)"

label define ER83932L  ///
       1 "Mostly stocks"  ///
       2 "Mostly interest earning"  ///
       3 "Split"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  does not have money in private annuities or IRAs (ER83931=5); DK, NA, or RF whether has money in private annuities or IRAs (ER83931=8 or 9)"

label define ER84134L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.: not working now (ER84107=2, 3, or 5); is not participating in a pension or retirement plan through current job or union (ER84108=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER84108=8 or 9); defined benefit formula only (ER84123=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both (ER84123=8 or 9)"

label define ER84340L  ///
       1 "Mostly (or all) stocks"  ///
       2 "Some of each"  ///
       3 "Mostly (or all) bonds and annuities"  ///
       7 "Other"  ///
       8 "DK"  ///
       9 "NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER83493=5); not working now (ER84313=2, 3, or 5); is not participating in a pension or retirement plan through current job or union (ER84314=5); DK, NA, or RF whether participating in a pension or retirement plan through current job or union (ER84314=8 or 9); defined benefit formula only (ER84329=1); DK, NA, or RF whether defined benefit formula, money accumulated or accrued, or both (ER84329=8 or 9)"

label define ER84993L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER83493=5); not Spanish, Hispanic or Latino"

label define ER84994L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER83493=5)"

label define ER84995L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER83493=5); DK, NA, or RF to first mention (ER84994=9); no second mention"

label define ER84996L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER83493=5); DK, NA, or RF to first mention (ER84994=9); fewer than three mentions"

label define ER84997L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER83493=5); DK, NA, or RF to first mention (ER84994=9); fewer than four mentions"

label define ER85016L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER83493=5); educated outside the U.S. only or had no education (ER85004=2 or 5); NA or RF where Spouse/Partner received education (ER85004=9)"

label define ER85020L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  no Spouse/Partner in FU (ER83493=5); educated outside the U.S. only or had no education (ER85004=2 or 5); NA or RF where Spouse/Partner received education (ER85004=9); did not attend college (ER85016=5); DK, NA, or RF whether attended college (ER85016=9); completed less than one year of college (ER85019=0)"

label define ER85080L  ///
       1 "Reinterview Family and FU has a RP who was not a Reference Person/Spouse/Partner in a previous wave; Splitoff or Recontact Interview"  ///
       5 "Reference Person in the FU who has been a Reference Person/Spouse/Partner in a previous wave"

label define ER85115L  ///
       1 "Farm; country"  ///
       2 "Small town; suburb"  ///
       3 "Large city"  ///
       4 "Other"  ///
       9 "DK; NA; refused"

forvalues n = 1/56 {
    label define ER85116L `n' "Actual state (FIPS code)"  , modify
}
label define ER85116L       99 "DK; NA; refused"  , modify
label define ER85116L        0 "Inap.:  U.S. territory or foreign country"  , modify

label define ER85120L  ///
       1 "Mexican"  ///
       2 "Mexican American"  ///
       3 "Chicano"  ///
       4 "Puerto Rican"  ///
       5 "Cuban"  ///
       7 "Other Spanish; Hispanic; Latino"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  not Spanish, Hispanic or Latino"

label define ER85121L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       9 "DK; NA; refused"

label define ER85122L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER85121=9); no second mention"

label define ER85123L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER85121=9); fewer than three mentions"

label define ER85124L  ///
       1 "White"  ///
       2 "Black, African-American, or Negro"  ///
       3 "American Indian or Alaska Native"  ///
       4 "Asian"  ///
       5 "Native Hawaiian or Pacific Islander"  ///
       7 "Other"  ///
       0 "Inap.:  DK, NA, or RF to first mention (ER85121=9); fewer than four mentions"

label define ER85143L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER85131=2 or 5); NA or RF where Reference Person received education (ER85131=9)"

label define ER85147L  ///
       1 "Yes"  ///
       5 "No"  ///
       9 "DK; NA; refused"  ///
       0 "Inap.:  educated outside the U.S. only or had no education (ER85131=2 or 5); NA or RF where Reference Person received education (ER85131=9); did not attend college (ER85143=5); DK, NA, or RF whether attended college (ER85143=9); completed less than one year of college (ER85146=0)"

label define ER85598L  ///
       1 "Imputed by PSID staff during data cleaning and editing"  ///
       5 "Imputed using the median value for all non-zero cases of OFUM`=char(146)'s 2022 labor income"  ///
       0 "Inap.:  not imputed; no other family unit members; no other FU member with income in 2022"

label define ER85630L  ///
       0 "No"  ///
       1 "Yes"

label define ER85631L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part or all of a farm or business"

label define ER85633L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part or all of a farm or business"

label define ER85635L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not currently own part of all of a farm or business"

label define ER85639L  ///
       1 "Imputed"  ///
       0 "Inap.: not imputed; does not have money in a checking, savings or money market accounts"

label define ER85643L  ///
       1 "Imputed"  ///
       0 "Inap.: not imputed; does not have money in certificates of deposit, government bonds or treasury bills"

label define ER85644L  ///
       0 "No"  ///
       1 "Yes"

label define ER85645L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own any other real estate other than main home"

label define ER85650L  ///
       0 "No"  ///
       1 "Yes"

label define ER85651L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any shares of stock in publicly-held corporations, stock mutual funds, or investment trusts"

label define ER85653L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any shares of stock in publicly-held corporations, stock mutual funds, or investment trusts"

label define ER85655L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own anything on wheels"

label define ER85659L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any other savings or assets"

label define ER85660L  ///
       0 "No"  ///
       1 "Yes"

label define ER85661L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in private annuities or IRAs"

label define ER85663L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any money in private annuities or IRAs"

label define ER85689L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not own a home"

label define ER85691L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any assets"

label define ER85693L  ///
       1 "Imputed"  ///
       0 "Inap.:  not imputed; does not have any assets or home equity"

label define ER85776L  ///
       1 "Northeast"  ///
       2 "North Central"  ///
       3 "South"  ///
       4 "West"  ///
       5 "Alaska, Hawaii"  ///
       6 "Foreign country"  ///
       9 "DK; NA"

label define ER85777L  ///
       1 "Same state at both times: ER85116 equals ER82004"  ///
       2 "Same region but different state: ER85116 does not equal ER82004 but ER85772 equals ER85776"  ///
       3 "Different regions: ER85772 does not equal ER85776"  ///
       8 "DK"  ///
       9 "NA; ER82004 or ER85116 equals 99"
label define ER85780L        0 "Completed no grades of school"  , modify
forvalues n = 1/17 {
    label define ER85780L `n' "Actual number"  , modify
}
label define ER85780L       99 "DK; NA"  , modify

forvalues n = 1/17 {
    label define ER85781L `n' "Actual number"  , modify
}
label define ER85781L       99 "DK; NA"  , modify
label define ER85781L        0 "Inap.:  completed no grades of school; no Spouse/Partner in FU (ER83493=5)"  , modify

label define S402L  ///
       0 "No"  ///
       1 "Yes"

label define S402AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S403AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S405AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S407AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S408L  ///
       0 "No"  ///
       1 "Yes"

label define S408AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S409AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S410L  ///
       0 "No"  ///
       1 "Yes"

label define S410AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S411AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S413AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S415AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S416AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S417AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S418L  ///
       0 "No"  ///
       1 "Yes"

label define S418AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S419AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S420AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S502L  ///
       0 "No"  ///
       1 "Yes"

label define S502AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S503AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S505AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S507AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S508L  ///
       0 "No"  ///
       1 "Yes"

label define S508AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S509AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S510L  ///
       0 "No"  ///
       1 "Yes"

label define S510AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S511AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S513AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S515AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S516AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S517AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S518L  ///
       0 "No"  ///
       1 "Yes"

label define S518AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S519AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S520AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S602L  ///
       0 "No"  ///
       1 "Yes"

label define S602AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S603AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S605AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S607AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S608L  ///
       0 "No"  ///
       1 "Yes"

label define S608AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S609AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S610L  ///
       0 "No"  ///
       1 "Yes"

label define S610AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S611AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S613AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S615AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S616AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S617AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S618L  ///
       0 "No"  ///
       1 "Yes"

label define S618AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S619AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S620AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S702L  ///
       0 "No"  ///
       1 "Yes"

label define S702AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S703AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S705AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S707AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S708L  ///
       0 "No"  ///
       1 "Yes"

label define S708AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S709AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S710L  ///
       0 "No"  ///
       1 "Yes"

label define S710AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S711AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S713AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S715AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S716AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S717AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S718L  ///
       0 "No"  ///
       1 "Yes"

label define S718AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S719AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S720AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S802L  ///
       0 "No"  ///
       1 "Yes"

label define S802AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S803AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S805AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S807AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S808L  ///
       0 "No"  ///
       1 "Yes"

label define S808AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S809AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S810L  ///
       0 "No"  ///
       1 "Yes"

label define S810AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S811AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S813AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S815AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S816AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S817AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S818L  ///
       0 "No"  ///
       1 "Yes"

label define S818AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S819AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label define S820AL  ///
       0 "Not Imputed"  ///
       1 "Imputed"

label values ER13001    ER13001L
label values ER13005    ER13005L
label values ER13009    ER13009L
label values ER13011    ER13011L
label values ER13077    ER13077L
label values ER13079    ER13079L
label values ER14493    ER14493L
label values ER14789    ER14789L
label values ER15013    ER15013L
label values ER15182    ER15182L
label values ER15328    ER15328L
label values ER15836    ER15836L
label values ER15837    ER15837L
label values ER15838    ER15838L
label values ER15839    ER15839L
label values ER15856    ER15856L
label values ER15860    ER15860L
label values ER15890    ER15890L
label values ER15921    ER15921L
label values ER15922    ER15922L
label values ER15928    ER15928L
label values ER15929    ER15929L
label values ER15930    ER15930L
label values ER15931    ER15931L
label values ER15948    ER15948L
label values ER15952    ER15952L
label values ER16431A   ER16431AL
label values ER16431B   ER16431BL
label values ER16516    ER16516L
label values ER16517    ER16517L
label values ER17001    ER17001L
label values ER17005    ER17005L
label values ER17012    ER17012L
label values ER17014    ER17014L
label values ER17088    ER17088L
label values ER17090    ER17090L
label values ER18649    ER18649L
label values ER18965    ER18965L
label values ER19209    ER19209L
label values ER19350    ER19350L
label values ER19493    ER19493L
label values ER19897    ER19897L
label values ER19898    ER19898L
label values ER19899    ER19899L
label values ER19900    ER19900L
label values ER19917    ER19917L
label values ER19921    ER19921L
label values ER19951    ER19951L
label values ER19982    ER19982L
label values ER19983    ER19983L
label values ER19989    ER19989L
label values ER19990    ER19990L
label values ER19991    ER19991L
label values ER19992    ER19992L
label values ER20009    ER20009L
label values ER20013    ER20013L
label values ER20377A   ER20377AL
label values ER20377B   ER20377BL
label values ER20457    ER20457L
label values ER20458    ER20458L
label values ER21001    ER21001L
label values ER21004    ER21004L
label values ER21016    ER21016L
label values ER21018    ER21018L
label values ER21117    ER21117L
label values ER22019    ER22019L
label values ER22352    ER22352L
label values ER22589    ER22589L
label values ER22745    ER22745L
label values ER22889    ER22889L
label values ER23334    ER23334L
label values ER23335    ER23335L
label values ER23336    ER23336L
label values ER23337    ER23337L
label values ER23354    ER23354L
label values ER23358    ER23358L
label values ER23388    ER23388L
label values ER23419    ER23419L
label values ER23420    ER23420L
label values ER23426    ER23426L
label values ER23427    ER23427L
label values ER23428    ER23428L
label values ER23429    ER23429L
label values ER23446    ER23446L
label values ER23450    ER23450L
label values ER24146    ER24146L
label values ER24147    ER24147L
label values ER24148    ER24148L
label values ER24149    ER24149L
label values ER25001    ER25001L
label values ER25004    ER25004L
label values ER25016    ER25016L
label values ER25018    ER25018L
label values ER25098    ER25098L
label values ER26000    ER26000L
label values ER26333    ER26333L
label values ER26570    ER26570L
label values ER26726    ER26726L
label values ER26870    ER26870L
label values ER27296    ER27296L
label values ER27297    ER27297L
label values ER27298    ER27298L
label values ER27299    ER27299L
label values ER27300    ER27300L
label values ER27317    ER27317L
label values ER27321    ER27321L
label values ER27352    ER27352L
label values ER27385    ER27385L
label values ER27386    ER27386L
label values ER27392    ER27392L
label values ER27393    ER27393L
label values ER27394    ER27394L
label values ER27395    ER27395L
label values ER27396    ER27396L
label values ER27413    ER27413L
label values ER27417    ER27417L
label values ER28006    ER28006L
label values ER28045    ER28045L
label values ER28046    ER28046L
label values ER28047    ER28047L
label values ER28048    ER28048L
label values ER30000    ER30000L
label values ER32000    ER32000L
label values ER32006    ER32006L
label values ER33502    ER33502L
label values ER33503    ER33503L
label values ER33602    ER33602L
label values ER33603    ER33603L
label values ER33702    ER33702L
label values ER33703    ER33703L
label values ER33802    ER33802L
label values ER33803    ER33803L
label values ER33902    ER33902L
label values ER33903    ER33903L
label values ER34002    ER34002L
label values ER34003    ER34003L
label values ER34102    ER34102L
label values ER34103    ER34103L
label values ER34202    ER34202L
label values ER34203    ER34203L
label values ER34302    ER34302L
label values ER34303    ER34303L
label values ER34502    ER34502L
label values ER34503    ER34503L
label values ER34702    ER34702L
label values ER34703    ER34703L
label values ER34902    ER34902L
label values ER34903    ER34903L
label values ER35102    ER35102L
label values ER35103    ER35103L
label values ER36001    ER36001L
label values ER36004    ER36004L
label values ER36016    ER36016L
label values ER36018    ER36018L
label values ER36103    ER36103L
label values ER37018    ER37018L
label values ER37351    ER37351L
label values ER37588    ER37588L
label values ER37766    ER37766L
label values ER37998    ER37998L
label values ER40471    ER40471L
label values ER40472    ER40472L
label values ER40473    ER40473L
label values ER40474    ER40474L
label values ER40475    ER40475L
label values ER40492    ER40492L
label values ER40496    ER40496L
label values ER40527    ER40527L
label values ER40560    ER40560L
label values ER40561    ER40561L
label values ER40564    ER40564L
label values ER40565    ER40565L
label values ER40566    ER40566L
label values ER40567    ER40567L
label values ER40568    ER40568L
label values ER40585    ER40585L
label values ER40589    ER40589L
label values ER40996    ER40996L
label values ER41035    ER41035L
label values ER41036    ER41036L
label values ER41037    ER41037L
label values ER41038    ER41038L
label values ER42001    ER42001L
label values ER42004    ER42004L
label values ER42016    ER42016L
label values ER42018    ER42018L
label values ER42132    ER42132L
label values ER43009    ER43009L
label values ER43342    ER43342L
label values ER43579    ER43579L
label values ER43739    ER43739L
label values ER43971    ER43971L
label values ER46448    ER46448L
label values ER46449    ER46449L
label values ER46450    ER46450L
label values ER46451    ER46451L
label values ER46452    ER46452L
label values ER46469    ER46469L
label values ER46473    ER46473L
label values ER46504    ER46504L
label values ER46537    ER46537L
label values ER46538    ER46538L
label values ER46542    ER46542L
label values ER46543    ER46543L
label values ER46544    ER46544L
label values ER46545    ER46545L
label values ER46546    ER46546L
label values ER46563    ER46563L
label values ER46567    ER46567L
label values ER46904    ER46904L
label values ER46936    ER46936L
label values ER46937    ER46937L
label values ER46939    ER46939L
label values ER46943    ER46943L
label values ER46947    ER46947L
label values ER46948    ER46948L
label values ER46949    ER46949L
label values ER46951    ER46951L
label values ER46952    ER46952L
label values ER46953    ER46953L
label values ER46955    ER46955L
label values ER46957    ER46957L
label values ER46961    ER46961L
label values ER46962    ER46962L
label values ER46963    ER46963L
label values ER46965    ER46965L
label values ER46967    ER46967L
label values ER46969    ER46969L
label values ER46971    ER46971L
label values ER46977    ER46977L
label values ER46978    ER46978L
label values ER46981    ER46981L
label values ER46982    ER46982L
label values ER47301    ER47301L
label values ER47304    ER47304L
label values ER47316    ER47316L
label values ER47318    ER47318L
label values ER47440    ER47440L
label values ER48331    ER48331L
label values ER48667    ER48667L
label values ER48904    ER48904L
label values ER49085    ER49085L
label values ER49304    ER49304L
label values ER51809    ER51809L
label values ER51810    ER51810L
label values ER51811    ER51811L
label values ER51812    ER51812L
label values ER51813    ER51813L
label values ER51830    ER51830L
label values ER51834    ER51834L
label values ER51865    ER51865L
label values ER51898    ER51898L
label values ER51899    ER51899L
label values ER51903    ER51903L
label values ER51904    ER51904L
label values ER51905    ER51905L
label values ER51906    ER51906L
label values ER51907    ER51907L
label values ER51924    ER51924L
label values ER51928    ER51928L
label values ER52312    ER52312L
label values ER52344    ER52344L
label values ER52345    ER52345L
label values ER52347    ER52347L
label values ER52351    ER52351L
label values ER52352    ER52352L
label values ER52353    ER52353L
label values ER52355    ER52355L
label values ER52356    ER52356L
label values ER52357    ER52357L
label values ER52359    ER52359L
label values ER52361    ER52361L
label values ER52365    ER52365L
label values ER52366    ER52366L
label values ER52367    ER52367L
label values ER52369    ER52369L
label values ER52391    ER52391L
label values ER52393    ER52393L
label values ER52395    ER52395L
label values ER52401    ER52401L
label values ER52402    ER52402L
label values ER52405    ER52405L
label values ER52406    ER52406L
label values ER53001    ER53001L
label values ER53004    ER53004L
label values ER53016    ER53016L
label values ER53018    ER53018L
label values ER53140    ER53140L
label values ER54008    ER54008L
label values ER54361    ER54361L
label values ER54654    ER54654L
label values ER54841    ER54841L
label values ER55057    ER55057L
label values ER57548    ER57548L
label values ER57549    ER57549L
label values ER57550    ER57550L
label values ER57551    ER57551L
label values ER57552    ER57552L
label values ER57570    ER57570L
label values ER57574    ER57574L
label values ER57618    ER57618L
label values ER57653    ER57653L
label values ER57654    ER57654L
label values ER57658    ER57658L
label values ER57659    ER57659L
label values ER57660    ER57660L
label values ER57661    ER57661L
label values ER57662    ER57662L
label values ER57680    ER57680L
label values ER57684    ER57684L
label values ER58121    ER58121L
label values ER58153    ER58153L
label values ER58154    ER58154L
label values ER58156    ER58156L
label values ER58158    ER58158L
label values ER58162    ER58162L
label values ER58163    ER58163L
label values ER58164    ER58164L
label values ER58169    ER58169L
label values ER58170    ER58170L
label values ER58172    ER58172L
label values ER58174    ER58174L
label values ER58178    ER58178L
label values ER58179    ER58179L
label values ER58180    ER58180L
label values ER58182    ER58182L
label values ER58208    ER58208L
label values ER58210    ER58210L
label values ER58212    ER58212L
label values ER58219    ER58219L
label values ER58220    ER58220L
label values ER58223    ER58223L
label values ER58224    ER58224L
label values ER60001    ER60001L
label values ER60004    ER60004L
label values ER60016    ER60016L
label values ER60018    ER60018L
label values ER60020    ER60020L
label values ER60155    ER60155L
label values ER61050    ER61050L
label values ER61437    ER61437L
label values ER61765    ER61765L
label values ER61961    ER61961L
label values ER62178    ER62178L
label values ER64670    ER64670L
label values ER64671    ER64671L
label values ER64672    ER64672L
label values ER64673    ER64673L
label values ER64674    ER64674L
label values ER64693    ER64693L
label values ER64697    ER64697L
label values ER64769    ER64769L
label values ER64804    ER64804L
label values ER64805    ER64805L
label values ER64809    ER64809L
label values ER64810    ER64810L
label values ER64811    ER64811L
label values ER64812    ER64812L
label values ER64813    ER64813L
label values ER64832    ER64832L
label values ER64836    ER64836L
label values ER65318    ER65318L
label values ER65350    ER65350L
label values ER65351    ER65351L
label values ER65353    ER65353L
label values ER65355    ER65355L
label values ER65359    ER65359L
label values ER65360    ER65360L
label values ER65361    ER65361L
label values ER65366    ER65366L
label values ER65367    ER65367L
label values ER65369    ER65369L
label values ER65371    ER65371L
label values ER65375    ER65375L
label values ER65376    ER65376L
label values ER65377    ER65377L
label values ER65379    ER65379L
label values ER65405    ER65405L
label values ER65407    ER65407L
label values ER65409    ER65409L
label values ER65455    ER65455L
label values ER65456    ER65456L
label values ER65459    ER65459L
label values ER65460    ER65460L
label values ER66001    ER66001L
label values ER66004    ER66004L
label values ER66016    ER66016L
label values ER66018    ER66018L
label values ER66020    ER66020L
label values ER66156    ER66156L
label values ER67102    ER67102L
label values ER67457    ER67457L
label values ER67818    ER67818L
label values ER68015    ER68015L
label values ER68232    ER68232L
label values ER70743    ER70743L
label values ER70744    ER70744L
label values ER70745    ER70745L
label values ER70746    ER70746L
label values ER70747    ER70747L
label values ER70766    ER70766L
label values ER70770    ER70770L
label values ER70841    ER70841L
label values ER70876    ER70876L
label values ER70877    ER70877L
label values ER70881    ER70881L
label values ER70882    ER70882L
label values ER70883    ER70883L
label values ER70884    ER70884L
label values ER70885    ER70885L
label values ER70904    ER70904L
label values ER70908    ER70908L
label values ER71395    ER71395L
label values ER71427    ER71427L
label values ER71428    ER71428L
label values ER71430    ER71430L
label values ER71432    ER71432L
label values ER71436    ER71436L
label values ER71437    ER71437L
label values ER71438    ER71438L
label values ER71443    ER71443L
label values ER71444    ER71444L
label values ER71446    ER71446L
label values ER71448    ER71448L
label values ER71452    ER71452L
label values ER71453    ER71453L
label values ER71454    ER71454L
label values ER71456    ER71456L
label values ER71482    ER71482L
label values ER71484    ER71484L
label values ER71486    ER71486L
label values ER71534    ER71534L
label values ER71535    ER71535L
label values ER71538    ER71538L
label values ER71539    ER71539L
label values ER72001    ER72001L
label values ER72004    ER72004L
label values ER72016    ER72016L
label values ER72018    ER72018L
label values ER72020    ER72020L
label values ER72156    ER72156L
label values ER73125    ER73125L
label values ER73480    ER73480L
label values ER73841    ER73841L
label values ER74041    ER74041L
label values ER74248    ER74248L
label values ER76751    ER76751L
label values ER76752    ER76752L
label values ER76753    ER76753L
label values ER76754    ER76754L
label values ER76755    ER76755L
label values ER76774    ER76774L
label values ER76778    ER76778L
label values ER76856    ER76856L
label values ER76891    ER76891L
label values ER76892    ER76892L
label values ER76896    ER76896L
label values ER76897    ER76897L
label values ER76898    ER76898L
label values ER76899    ER76899L
label values ER76900    ER76900L
label values ER76919    ER76919L
label values ER76923    ER76923L
label values ER77417    ER77417L
label values ER77449    ER77449L
label values ER77450    ER77450L
label values ER77452    ER77452L
label values ER77454    ER77454L
label values ER77458    ER77458L
label values ER77462    ER77462L
label values ER77463    ER77463L
label values ER77464    ER77464L
label values ER77469    ER77469L
label values ER77470    ER77470L
label values ER77472    ER77472L
label values ER77474    ER77474L
label values ER77478    ER77478L
label values ER77479    ER77479L
label values ER77480    ER77480L
label values ER77482    ER77482L
label values ER77508    ER77508L
label values ER77510    ER77510L
label values ER77512    ER77512L
label values ER77595    ER77595L
label values ER77596    ER77596L
label values ER77599    ER77599L
label values ER77600    ER77600L
label values ER78001    ER78001L
label values ER78004    ER78004L
label values ER78016    ER78016L
label values ER78018    ER78018L
label values ER78020    ER78020L
label values ER78158    ER78158L
label values ER79222    ER79222L
label values ER79602    ER79602L
label values ER79963    ER79963L
label values ER80164    ER80164L
label values ER80370    ER80370L
label values ER81016    ER81016L
label values ER81017    ER81017L
label values ER81018    ER81018L
label values ER81019    ER81019L
label values ER81020    ER81020L
label values ER81039    ER81039L
label values ER81043    ER81043L
label values ER81103    ER81103L
label values ER81138    ER81138L
label values ER81139    ER81139L
label values ER81143    ER81143L
label values ER81144    ER81144L
label values ER81145    ER81145L
label values ER81146    ER81146L
label values ER81147    ER81147L
label values ER81166    ER81166L
label values ER81170    ER81170L
label values ER81744    ER81744L
label values ER81776    ER81776L
label values ER81777    ER81777L
label values ER81779    ER81779L
label values ER81781    ER81781L
label values ER81785    ER81785L
label values ER81789    ER81789L
label values ER81790    ER81790L
label values ER81791    ER81791L
label values ER81796    ER81796L
label values ER81797    ER81797L
label values ER81799    ER81799L
label values ER81801    ER81801L
label values ER81805    ER81805L
label values ER81806    ER81806L
label values ER81807    ER81807L
label values ER81809    ER81809L
label values ER81835    ER81835L
label values ER81837    ER81837L
label values ER81839    ER81839L
label values ER81922    ER81922L
label values ER81923    ER81923L
label values ER81926    ER81926L
label values ER81927    ER81927L
label values ER82001    ER82001L
label values ER82004    ER82004L
label values ER82017    ER82017L
label values ER82019    ER82019L
label values ER82021    ER82021L
label values ER82141    ER82141L
label values ER83197    ER83197L
label values ER83571    ER83571L
label values ER83932    ER83932L
label values ER84134    ER84134L
label values ER84340    ER84340L
label values ER84993    ER84993L
label values ER84994    ER84994L
label values ER84995    ER84995L
label values ER84996    ER84996L
label values ER84997    ER84997L
label values ER85016    ER85016L
label values ER85020    ER85020L
label values ER85080    ER85080L
label values ER85115    ER85115L
label values ER85116    ER85116L
label values ER85120    ER85120L
label values ER85121    ER85121L
label values ER85122    ER85122L
label values ER85123    ER85123L
label values ER85124    ER85124L
label values ER85143    ER85143L
label values ER85147    ER85147L
label values ER85598    ER85598L
label values ER85630    ER85630L
label values ER85631    ER85631L
label values ER85633    ER85633L
label values ER85635    ER85635L
label values ER85639    ER85639L
label values ER85643    ER85643L
label values ER85644    ER85644L
label values ER85645    ER85645L
label values ER85650    ER85650L
label values ER85651    ER85651L
label values ER85653    ER85653L
label values ER85655    ER85655L
label values ER85659    ER85659L
label values ER85660    ER85660L
label values ER85661    ER85661L
label values ER85663    ER85663L
label values ER85689    ER85689L
label values ER85691    ER85691L
label values ER85693    ER85693L
label values ER85776    ER85776L
label values ER85777    ER85777L
label values ER85780    ER85780L
label values ER85781    ER85781L
label values S402       S402L
label values S402A      S402AL
label values S403A      S403AL
label values S405A      S405AL
label values S407A      S407AL
label values S408       S408L
label values S408A      S408AL
label values S409A      S409AL
label values S410       S410L
label values S410A      S410AL
label values S411A      S411AL
label values S413A      S413AL
label values S415A      S415AL
label values S416A      S416AL
label values S417A      S417AL
label values S418       S418L
label values S418A      S418AL
label values S419A      S419AL
label values S420A      S420AL
label values S502       S502L
label values S502A      S502AL
label values S503A      S503AL
label values S505A      S505AL
label values S507A      S507AL
label values S508       S508L
label values S508A      S508AL
label values S509A      S509AL
label values S510       S510L
label values S510A      S510AL
label values S511A      S511AL
label values S513A      S513AL
label values S515A      S515AL
label values S516A      S516AL
label values S517A      S517AL
label values S518       S518L
label values S518A      S518AL
label values S519A      S519AL
label values S520A      S520AL
label values S602       S602L
label values S602A      S602AL
label values S603A      S603AL
label values S605A      S605AL
label values S607A      S607AL
label values S608       S608L
label values S608A      S608AL
label values S609A      S609AL
label values S610       S610L
label values S610A      S610AL
label values S611A      S611AL
label values S613A      S613AL
label values S615A      S615AL
label values S616A      S616AL
label values S617A      S617AL
label values S618       S618L
label values S618A      S618AL
label values S619A      S619AL
label values S620A      S620AL
label values S702       S702L
label values S702A      S702AL
label values S703A      S703AL
label values S705A      S705AL
label values S707A      S707AL
label values S708       S708L
label values S708A      S708AL
label values S709A      S709AL
label values S710       S710L
label values S710A      S710AL
label values S711A      S711AL
label values S713A      S713AL
label values S715A      S715AL
label values S716A      S716AL
label values S717A      S717AL
label values S718       S718L
label values S718A      S718AL
label values S719A      S719AL
label values S720A      S720AL
label values S802       S802L
label values S802A      S802AL
label values S803A      S803AL
label values S805A      S805AL
label values S807A      S807AL
label values S808       S808L
label values S808A      S808AL
label values S809A      S809AL
label values S810       S810L
label values S810A      S810AL
label values S811A      S811AL
label values S813A      S813AL
label values S815A      S815AL
label values S816A      S816AL
label values S817A      S817AL
label values S818       S818L
label values S818A      S818AL
label values S819A      S819AL
label values S820A      S820AL
