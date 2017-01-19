writeXML = function(modFileVector) {
  # create an xml file from fileVector
  write(modFileVector, file = "fileVector.xml")
  #read in the filevector.xml file
  useXML = xml2::read_xml(x = "C:\\Users\\mathe\\Documents\\R\\R Projects\\USEgangsta\\fileVector.xml")
  return(useXML)
}



