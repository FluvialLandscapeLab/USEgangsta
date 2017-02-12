rm(list = ls())

fileVector = createParents(useFile = file.choose())
fileVector = createChildNames(fileVector)
fileVector = createElementTags(fileVector)
fileVector = addTagsToElement(fileVector)
useXML = writeXML(fileVector)

xmlClasses = xml2:: xml_find_all(useXML, "//class")

newXMLClasses = lapply(xmlClasses, useClass2)



