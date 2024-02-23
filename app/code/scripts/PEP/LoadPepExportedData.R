library(jsonlite)
library(tidyverse)
library(writexl)
library(readr)

LoadExportedPEPData <- function(pepDataFolder, outputFolder){
  subFolders <- list.dirs(pepDataFolder)[-1]
  dfFiles <- data.frame()
  
  # Gather available files (data columns) from subfolders
  for (subFolder in subFolders) {
     id <- tail(strsplit(subFolder, "/")[[1]], 1)
  
     files <- list.files(subFolder)
     if(length(files) > 0){
       for (file in files){
         dfFiles <- rbind(dfFiles, c(file))
       }
     }
  }
  dfFiles <- unique(dfFiles)
  
  # Iterate over files and save merged data per file/data column
  for (i in 1:nrow(dfFiles)) {
    df <- data.frame()

    for (subFolder in subFolders) {
      id <- tail(strsplit(subFolder, "/")[[1]], 1)
      path <- paste0(subFolder, "/", dfFiles[i,])
      if(file.exists(path)){
        content <- read_file(path)
        row <- data.frame()
        print(content)
        if(jsonlite::validate(content)){
          data <- fromJSON(txt = content)
          row <- data.frame(ID = id, data$crf, data$reports)
          df <- bind_rows(df, row)
        } else{
          row <- data.frame(ID = id, content)
        }
        df <- bind_rows(df, row)
      }
    }
    if(dfFiles[i,] != ""){
      xlsxPath <- paste0(outputFolder, "/", dfFiles[i,], ".xlsx")
      write_xlsx(df, xlsxPath)
    }
  }
  
  return(dfFiles)
}