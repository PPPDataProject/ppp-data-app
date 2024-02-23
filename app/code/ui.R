# Load Libraries
library(shiny)
library(shinycssloaders)
library(tidyverse)
library(shinylogs)

# General options
appDir <- getwd()

# Set app working directory and other configuration
options(spinner.type = 6, spinner.color = "#0dc5c1")
padding = "padding:5px; margin-bottom:5px"

ui <- fluidPage(
  # set error tracking
  use_tracking(app_name = "ppp_data_app"),
  
  # Title block
  titlePanel(img(src="PPP_icon.jpg")),

  # Sidebar layout
  sidebarLayout(
    # Sidebar panel for inputs with output definitions
    sidebarPanel(
      # Merge downloaded PEP columns into single Excel files
      div(
        img(src = "PEP.png", height = 20, width = 40, alt = "PEP"),
        "Merge PEP downloads to Excel files per data column",
        textInput(inputId = "pepDataPath", 
                  label = "Path to downloaded Pep data (main directory)",
                  value = paste0(appDir,"/data")),
        actionButton("btn1", "Merge data"),
        style = paste("border:1px solid grey;", padding)
      ),
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      verbatimTextOutput("feedback"),
      shinycssloaders::withSpinner(dataTableOutput("df"))
    )
  )
)