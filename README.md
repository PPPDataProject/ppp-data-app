# ppp-data-app
Tool supplied along with data access. Developed by the PPP data team. 
Feb 2024, Research Support Radboudumc. 
Expertisecentrum Parkinson & Bewegingsstoornissen


	This app is supplied by the PPP data team in order to run R scripts. Double click on the file 'ppp_data_app.bat' in order to start the app.
	In this app you may: merge data downloaded from PEP into Excel files per type of data column downloaded.
	If you have any feedback or questions regarding this app, feel free to contact us at: ppp-data@radboudumc.nl
	
	Log files (.json) are stored in /app/code/logs
	
	ACTION
	Merge PEP downloads to Excel files per data column.
	
		REQUIRED INPUT
		Path to downloaded PEP data (main directory containing all subdirectories)
					
		OUTPUT
		Single Excel per downloaded filename with all data of the participants merged into that file. For example, if you have 2 data types downloaded (e.g. Castor.Visit1.Data1 & Castor.Visit1.Data2), 
		you get two Excel files; Castor.Visit1.Data1.xlsx & Castor.Visit1.Data2.xlsx
