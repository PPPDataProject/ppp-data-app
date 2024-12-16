#Load R libraries
library(jsonlite) #used to read JSON format
library(plyr) # possibly run install.packages("plyr") first
library(tools)
library(readxl)
library(readr)
library(writexl)

#init parameters used in error messages
path <- "path"

MergeDataset <- function(pepDataFolder, outputFolder){
  tryCatch ({
    # Load all folders downloaded from PEP and init dataframe to store data
    subFolders <- list.dirs(pepDataFolder, recursive = FALSE)[-1]
    dfFiles <- data.frame()

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

    # Iterate over participant data and save merged data
    df <- data.frame()

    for (subFolder in subFolders) {
      # determine participant ID and init row to save participant data in
      id <- tail(strsplit(subFolder, "/")[[1]], 1)
      row <- data.frame(ID = id)
      print(id)
      # iterate over all available files and build merged record
      for (i in 1:nrow(dfFiles)){#) {
        path <- paste0(subFolder, "/", dfFiles[i,])
        
        # check if file exists and read data
        if(file.exists(path)){
          if(grepl("Castor.", path) || grepl("DD_", path)){
            data <- as.data.frame(read_json(path))
          } else if(grepl("LEDD", path)){
            data <- read_excel(path)
          } else{
            data <- read_file(path)
            row <- cbind(row, data)
            names(row)[ncol(row)] <- dfFiles[i,]
            next
          }
          
          # Append visit or HQ number to prevent overwritten variable values 
          if(grepl("Visit1", dfFiles[i,], fixed = TRUE)){
              names(data) <- paste("Visit1", names(data), sep = ".")
              names(data) <- gsub("crf.", "", names(data))
              names(data) <- gsub("reports.", "", names(data))            
          }
          if(grepl("Visit2", dfFiles[i,], fixed = TRUE)){
              names(data) <- paste("Visit2", names(data), sep = ".")
              names(data) <- gsub("crf.", "", names(data))
              names(data) <- gsub("reports.", "", names(data))            
          }
          if(grepl("Visit3", dfFiles[i,], fixed = TRUE)){
              names(data) <- paste("Visit3", names(data), sep = ".")
              names(data) <- gsub("crf.", "", names(data))
              names(data) <- gsub("reports.", "", names(data))            
          }
          if(grepl("HomeQuestionnaires1", dfFiles[i,], fixed = TRUE)){
              names(data) <- paste("HQ1", names(data), sep = ".")
              names(data) <- gsub("crf.", "", names(data))
              names(data) <- gsub("reports.", "", names(data))            
          }
          if(grepl("HomeQuestionnaires2", dfFiles[i,], fixed = TRUE)){
              names(data) <- paste("HQ2", names(data), sep = ".")
              names(data) <- gsub("crf.", "", names(data))
              names(data) <- gsub("reports.", "", names(data))            
          }
          if(grepl("HomeQuestionnaires3", dfFiles[i,], fixed = TRUE)){
              names(data) <- paste("HQ3", names(data), sep = ".")
              names(data) <- gsub("crf.", "", names(data))
              names(data) <- gsub("reports.", "", names(data))            
          }
          
          #append data to merged participant data
          row <- cbind(row, data)
        }
      }
      # done processing participant data, store to general file
      df <- rbind.fill(df, row)
    }

    colnames(df) <- gsub("crf.", "", colnames(df))
    colnames(df) <- gsub("reports.", "", colnames(df))
    write_xlsx(df, paste0(outputFolder, "/merged-ppp-dataset.xlsx"))
    return(df)
  },
  error = function(error) {
    stop(paste0(error, " || ", path))
  })
}


