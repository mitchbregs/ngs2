## Created by Pablo Diego-Rosell, PhD, for Gallup inc.
## For any questions, contact pablo_diego-rosell@gallup.co.uk

# Set environment
rm(list = ls(all = TRUE))
LOCAL <- TRUE # change to FALSE if you want to run from data on the network drive

# load libraries
if (!require("pacman")) install.packages("pacman")
library ("pacman")
pacman::p_load(rstan, rstanarm, ggplot2, Hmisc, httr, bridgesampling, DT, dplyr, bayesplot, knitr, lme4, caret, pROC)

# set directories
if(Sys.info()['sysname'] == "Windows") {
    if(LOCAL) {
        dd <- 'C:/Users/c_pablo_diego-rosell/Desktop/Projects/DARPA/Cycle 2/Analytics/data'
        od <- 'C:/Users/c_pablo_diego-rosell/Desktop/Projects/DARPA/Cycle 2/Analytics/output'
    } else {
        dd <- '//gallup/dod_clients/DARPA_NGS2/CONSULTING/Analytics/cycle2/data'
        od <- '//gallup/dod_clients/DARPA_NGS2/CONSULTING/Analytics/cycle2/output'
    }
} else if(Sys.info()['sysname'] == 'Darwin') {
    if(LOCAL) {
        dd <- '/Users/matt_hoover/git/ngs2/cycle2/data'
        od <- '/Users/matt_hoover/git/ngs2/cycle2/output'
    } else {
        dd <- '/Volumes/dod_clients/DARPA_NGS2/CONSULTING/Analytics/cycle2/data'
        od <- '/Volumes/dod_clients/DARPA_NGS2/CONSULTING/Analytics/cycle2/output'
    }
}
set.seed(12345)

# run scripts in order
# source effects
source("effects.R")

# source data cleaning
source("wrangle.R")

#Set default number of iterations for Bayesian estimation
nIter = 10000
