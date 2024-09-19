library(jsonlite)
library(tidyverse)
library(writexl)
library(readr) 
library(plyr)
library(tools)

#init parameters used in error messages
path <- "path"

LoadExportedPEPData <- function(pepDataFolder, outputFolder){
  tryCatch(
    {
      subFolders <- list.dirs(pepDataFolder, recursive = FALSE)[-1]
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
        print(dfFiles[i,])       

        for (subFolder in subFolders) {
          id <- tail(strsplit(subFolder, "/")[[1]], 1)
          path <- paste0(subFolder, "/", dfFiles[i,])

          if(file.exists(path)){
            if(file_ext(path) == "json"){
              data <- as.data.frame(read_json(path))
            } else{
              data <- read_file(path)
            }
            row <- data.frame(ID = id, data)
            df <- rbind.fill(df, row)
          }
        }
        if(dfFiles[i,] != ""){
          xlsxPath <- paste0(outputFolder, "/", dfFiles[i,], ".xlsx")
          write_xlsx(df, xlsxPath)
        }
      }
      colnames(dfFiles) <- c("Filename")
      return(dfFiles)
    },
    error = function(error) {
      stop(paste0(error, " || ", path))
    }
  )
}