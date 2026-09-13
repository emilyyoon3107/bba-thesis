# Code Repository for Writing Sample

Author: Hyojeong (Emily) Yoon ([LinkedIn](https://www.linkedin.com/in/hyojeong-emily-yoon/))

This repository contains the original files and code used for my writing sample (BBA thesis).

```
bba-thesis
├───FEC
│   └───raw
├───PSID
└───thesis
    ├───chapters
    ├───figures
    └───tables
```

`tables.do` at the root directory handles the main regression analysis and LaTeX table generation.
- Inputs: `J362369.dta`, `STDIR_pres.csv`
- Side effects: `tabledata.dta`
- Outputs: `thesis/tables/*.tex`
    \item The R script employs basic NLP techniques to clean and classify text data to synthesize numerical variables used in the Stata code.
\end{itemize}

`smp.do` at the root directory is a legacy file used for the main analysis before writing `tables.do`.

## FEC
The raw data for FEC contributions in `FEC/raw` is not uploaded, but can be found at the [FEC website](https://www.fec.gov/data/browse-data/?tab=bulk-data). The list of specific files required can be found in `FEC/data_instructions.md`. The final processed file `STDIR_pres.csv` is uploaded.

`FEC/contributions.R` classifies committees employing numerical and text data manipulation and synthesizes numerical variables used in the Stata code.
- Inputs: `FEC/raw/*.csv`
- Side effects: `candidates_master.csv`, `comm_for_manual_screening.csv`, `committees_selected.csv`
- Outputs: `STDIR_pres.csv`

## PSID
The raw data from the [Panel Study of Income Dynamics](https://psidonline.isr.umich.edu/default.aspx) is not uploaded following their terms of use. Specific instructions for recovering `J362369.txt` and obtaining `J362369.dta` can be found in `PSID/raw/data_instructions.md`. 

