#Script for LTER-SOM dataset harmonization

library('soilHarmonization')
library('devtools')

#Install soilHarmonization package if needed
devtools::install_github("srearl/soilHarmonization")

#Read SoilHomog_QA.R script from github
source_url("https://raw.githubusercontent.com/piersond/SOM-homog-QA/master/SoilHomog_QA.R")


### Required User Inputs ###
###############################################################
# Input LTER-SOM folder name to homogenize 
GD.folder <- 'BNZ1'

# Local temporary directory address
temp.files <- "C:/Users/Derek/Google Drive/Code/R/temp"
###############################################################

# Data homogenization
data_homogenization(directoryName = GD.folder, 
                    temporaryDirectory = temp.files)

# Homogenization QA
homogenization.qa(directoryName=GD.folder, temp.folder=temp.files)
