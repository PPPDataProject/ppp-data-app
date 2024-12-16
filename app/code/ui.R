# Load Libraries
library(shiny)
library(shinycssloaders)
library(tidyverse)
library(shinylogs)

# General options
appDir <- getwd()

# Set other configuration
options(spinner.type = 6, spinner.color = "#0dc5c1")
padding = "padding:5px; margin-bottom:5px"

ui <- fluidPage(
  # set theme, error tracking
  theme = bslib::bs_theme(bootswatch = "pulse"),
  use_tracking(app_name = "ppp_data_app"),
  
  # Title block
  titlePanel(img(src="PPP_icon.jpg")),

  # Sidebar layout
  sidebarLayout(
    # Sidebar panel for inputs with output definitions
    sidebarPanel(
      # Text input to specify downloaded PEP data
      div(        
        textInput(inputId = "pepDataPath", 
        label = "Path to downloaded PPP data (main directory)",
        value = paste0(appDir,"/data"))
      ),

      div(
        img(src = "PEP.png", height = 20, width = 40, alt = "PEP"),
        # Merge downloaded PEP columns into single Excel files
        layout_columns(
          "Merge PPP downloads to Excel files per data column", 
          actionButton("btn1", "Merge data", class = "btn btn-primary"),
        ),
        hr(),

        # Merge downloaded dataset into single Excel file
        layout_columns(
          "Merge PPP dataset to single Excel file",
          actionButton("btn2", "Merge dataset",  class = "btn btn-primary"),
        ),
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