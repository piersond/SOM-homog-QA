**SoilHarmonization QA** 

This standalone script is for quality assurance (QA) following the homogenization of a LTER-SOM Google Drive folder.  

The script verifies that the soilHarmonization function has correctly produced a homogenized data file with all 
the specified location and profile data given by the corresponding keykey file. 

Output QA files include a log text file of data check flags and .png plots of data 
variables by experiment and treatments levels.

The script contains one primary function with two inputs: 1) The name of the Google Drive folder containing the 
homogenized files; 2) The local address for temporary file storage. 

Example function use:
```
homogenization.qa(directoryName=GDrive.folder, temp.folder=local.temp)
```
