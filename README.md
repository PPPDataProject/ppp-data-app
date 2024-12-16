# ppp-data-app
Tool supplied along with data access. Developed by the PPP data team. 
September 2024, Research Support Radboudumc. 
Expertisecentrum Parkinson & Bewegingsstoornissen


	This app is supplied by the PPP data team in order to run R scripts. Double click on the file 'ppp_data_app.bat' in order to start the app.

	*If you have access to RStudio yourself, it is also possible to run the app using the file in this location: "app/app.R". 
	*In order to do this, please edit the code in line 3 to: "shiny::runApp(appDir = "./code", launch.browser = TRUE)"

	In this app you may: merge data downloaded from PEP into Excel files per type of data column downloaded.
	If you have any feedback on or questions regarding this app, feel free to contact us at: ppp-data@radboudumc.nl
	Any tips for future updates or suggestions on how to improve the app functionality are also highly appreciated!
	
	*Log files (.json) are stored in /app/code/logs
	
	ACTION
	Merge PEP downloads to Excel files per data column.
	This script is developed for handling .json files, other filetypes may not render the expected output. 
	This is TODO in future app releases.
	
		REQUIRED INPUT
		Path to downloaded PEP data (main directory containing all subdirectories)
					
		OUTPUT
		Single Excel per downloaded filename with all data of the participants merged into that file. For example, if you have 2 data types downloaded (e.g. Castor.Visit1.Data1 & Castor.Visit1.Data2), 
		you get two Excel files; Castor.Visit1.Data1.xlsx & Castor.Visit1.Data2.xlsx

	ACTION
	Merge PEP dataset to single Excel file.
	This script is developed for handling .json, Excel and txt files, other filetypes may not render the expected output. 	
	
		REQUIRED INPUT
		Path to downloaded PEP data (main directory containing all subdirectories)
					
		OUTPUT
		Single Excel file with all data of the dataset merged into that file. In order to prevent variables to be overwritten, variables are prepended with the corresponding Visit (VisitX.variablename) or HomeQuestionnaire (HQX,variablename).