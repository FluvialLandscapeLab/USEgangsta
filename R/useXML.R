# Load packages
library(xml2)
library(XML)

# create an xml file from fileVector
write(modFileVector, file = "fileVector.xml")
#read in the filevector.xml file
useXML = read_xml(x = "C:\\Users\\mathe\\Documents\\R\\R Projects\\USEgangsta\\fileVector.xml")


