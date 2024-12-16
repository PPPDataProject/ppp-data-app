# Load Libraries
library(shiny)
library(shinycssloaders)
library(tidyverse)
library(shinylogs)

# Set general options 
appDir <- getwd()

# Load scripts used in app actions
source(paste0(appDir, "/scripts/PEP/LoadPepExportedData.R"))
source(paste0(appDir, "/scripts/PEP/MergeDataset.R"))

# Define server logic
server <- function(input, output, session) {
  # error logging
  track_usage(storage_mode = store_json(path = paste0(appDir,"/logs")), app_name = "ppp_data_app")
  
  # Define (default) output variables
  data <- reactiveValues(df = data.frame())
  output$df <- renderDataTable(data$df)

  # Merge downloaded PEP columns into single Excel files
  observeEvent(input$btn1, {
    pepDatapath <- input$pepDataPath
    outputFolder <- paste0(appDir,"/output")
    if(!dir.exists(outputFolder)){
      dir.create(outputFolder)
    }
    output$feedback <- renderText(paste0("Data merged (stored in ", outputFolder,"), files generated: "))
    output$df <- renderDataTable(LoadExportedPEPData(pepDatapath, outputFolder))
    shell.exec(outputFolder)
  })

  # Merge downloaded PEP dataset into single Excel file
  observeEvent(input$btn2, {
    pepDatapath <- input$pepDataPath
    outputFolder <- paste0(appDir,"/output")
    if(!dir.exists(outputFolder)){
      dir.create(outputFolder)
    }
    output$feedback <- renderText(paste0("Dataset merged (stored in ", outputFolder,"), file generated: "))
    output$df <- renderDataTable(MergeDataset(pepDatapath, outputFolder))
    shell.exec(outputFolder)
  })
  
  # Stop app on browser close
  session$onSessionEnded(function() {
    stopApp()
  })
}