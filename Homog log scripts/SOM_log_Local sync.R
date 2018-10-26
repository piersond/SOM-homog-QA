#Script to log LTER-SOM homogenization progress

som.dir <- 'C:/Users/Derek Pierson/Google Drive/LTER-SOM/Data_downloads'

#Read in current log
  #Download gsheet to working drive and then set name manually
old.log <- read.csv("LTER-SOM_old_log.csv")
old.log <- old.log[,c(1,6:8)]


#Compile homog log
dirs <- list.dirs(path=som.dir,full.names=TRUE, recursive=TRUE)

log <- data.frame("Folder" = dirs[1], "Key" = 'False', "HMGZD" = 'False', "QC"='False', "QA" = 'False')

for (i in 2:length(dirs)) {
  dir.info <- NULL
  dir.info <- data.frame("Folder" = dirs[i], 
                         "Key" = as.character(any(grepl('key',list.files(path=dirs[i]),ignore.case = TRUE))),
                         "HMGZD" = as.character(any(grepl('HMGZD',list.files(path=dirs[i]),ignore.case = TRUE))),
                         "QC" = as.character(any(grepl('HMGZD_QC',list.files(path=dirs[i]),ignore.case = TRUE))),
                         "QA" = as.character(any(grepl('homog_log',list.files(path=dirs[i]),ignore.case = TRUE))))

  log <- rbind(log,dir.info)
}


#If switching between different parent directories 
old.log$Folder <- gsub("Derek","Derek Pierson",old.log$Folder)

#Remove mistaken (1) from folder names
log$Folder <- gsub(" (1)","",log$Folder, fixed=TRUE)
old.log$Folder <- gsub(" (1)","",old.log$Folder, fixed=TRUE)

#Cut down file paths
log$Folder <- gsub("C:/Users/Derek Pierson/Google Drive/LTER-SOM/","",log$Folder, fixed=TRUE)
old.log$Folder <- gsub("C:/Users/Derek Pierson/Google Drive/LTER-SOM/","",old.log$Folder, fixed=TRUE)

log.final <- merge(log,old.log, by="Folder", all=TRUE)

write.csv(log.final,"LTER-SOM_Homog_log.csv", row.names = FALSE)


