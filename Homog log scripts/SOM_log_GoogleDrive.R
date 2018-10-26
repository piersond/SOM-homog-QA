### Google Drive SOM homog log crawler to check folders for 
# key files, HMGZD files and QC files

#Derek Pierson: As of 10/25/18, still a work in progress. MAde it ~200 folders deep, but...
#...encountering numerous errors in loop along the way. Perhaps there's a better way...? 

library(googledrive)
library(dplyr)

#Call GDrive and get list of files in specified folder, convert to dataframe
GD.get <- drive_ls('Data_downloads')
GD.all <- as.data.frame(GD.get)

#Cut down to folders only
GD.fldrs <- filter(GD.all, grepl('folder', drive_resource))
fldr.list <- as.data.frame(GD.fldrs[,1:2],stringsAsFactors=FALSE)

#Add column to record folder parent
fldr.list$parent <- "Data_downloads"

#Add columns for data log checks
fldr.list$chkflg <- 0
fldr.list$Key <- 99
fldr.list$HMGZD <- 99
fldr.list$QC <- 99

#FOLDER CHECK CRAWL LOOP
  #Restart here-down if loop breaks by error
for (i in 1:1000) {   #1000 is simply a large number, loop will break when no folders remian to check

  #Stop if all folders in list have been checked
  ifelse(mean(fldr.list$chkflg) < 1, "OK",break)
  
  #Jump to next folder if current has been previously checked
    #Useful for restrating loop after error
  if(fldr.list$chkflg[i] == 1) {
   print(paste0("JUMP ",i))
   next   
  }
  
  #Skip specific folders or folders causing errors
    #Skip climate folders
    if(grepl("1_Climate_data",fldr.list[i,4])) {
      print(paste0("SKIP CLIMATE ",fldr.list[i,1]))
      next   
    }
  
    #Skip extras folders
    if(grepl("extra",fldr.list[i,1])) {
      print(paste0("SKIP EXTRA ",fldr.list[i,1]))
      next   
    }
  
  #Identify files in GDrive folders
  fnd <- NULL  #Clear var to avoid conflict from previous loop 
  fnd <- drive_ls(fldr.list[i,2],recursive = TRUE)
  
  #Find folders with given folder
  fnd.fldrs <- as.data.frame(filter(fnd, grepl('folder', drive_resource)))
  fnd.fldrs <- as.data.frame(fnd.fldrs[,1:2]) 
  
  #Add check columns for merginf the new found folders with the fldr.list
  if(nrow(fnd.fldrs) > 0) {
    fnd.fldrs$parent <- paste0(fldr.list[i,4],"\\",fldr.list[i,1])
    fnd.fldrs$chkflg <- 0
    fnd.fldrs$Key <- 88
    fnd.fldrs$HMGZD <- 88
    fnd.fldrs$QC <- 88
    
    #Add folders to folder list
    fldr.list <- rbind(fldr.list,fnd.fldrs)
  }
  
  ##Update check columns for current folder
  #If key file present, replace 0 with 1
  fldr.list$Key[i] <- ifelse(grepl('key',fnd[,1],ignore.case = TRUE),1,0)
  
  #If HMGZD present, replace 0 with 1 
  fldr.list$HMGZD[i] <- ifelse(grepl('HMGZD',fnd[,1],ignore.case = TRUE),1,0)
  
  #If QC.html present, replace 0 with 1 
  fldr.list$QC[i] <- ifelse(grepl('QC.html',fnd[,1],ignore.case = TRUE),1,0)
  
  #If folder check complete, replace 0 with 1 and print to console for progress tracking
  fldr.list$chkflg[i] <- 1
  print(paste0(i,"  Check Complete: ",fldr.list[i,1]))
}  
  
  
#Folders to manually skip due to errors, could be added within loop later...
#...but list still growing, errors still popping up, yada yada  
fldr.list <- fldr.list %>% filter(!grepl("log_test",name))
fldr.list <- fldr.list %>% filter(!grepl("cap_umbs_copy",name))
  
  
  
  
  
  
  
  
  

