devtools::install_github("srearl/soilHarmonization")

library('soilHarmonization')

# Set working directory
setwd("C:/Users/Derek/Google Drive/Code/R")

# Note: Make sure the homogenization QA script file is in your working directory
source("SoilHomog_standalone_data_check_v2.R")

### User input ###
###############################################################

# Input LTER-SOM folder name to homogenize 
GD.folder <- 'UMBS_DIRT_Bulk_Den_2004_2009'

# Local temporary directory address
temp.files <- "C:/Users/Derek/Google Drive/Code/R/temp"
###############################################################

# Data homogenization
data_homogenization(directoryName = GD.folder, 
                    temporaryDirectory = temp.files)

# Homogenization QA
homogenization.qa(directoryName=GD.folder, temp.folder=temp.files)