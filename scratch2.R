library(XML)
library(xml2)

doc = xmlTreeParse(file.choose(), useInternalNodes = T)
classes = getNodeSet(doc, "//class")


 attributes = lapply(classes, function(xmlClass) xmlChildren(xmlClass)$attributes)
 operations = lapply(classes, function(xmlClass) xmlChildren(xmlClass)$operations)
 constraints = lapply(classes, function(xmlClass) xmlChildren(xmlClass)$constraints)
 #className = lapply(classes, functionxml(xmlClass) xmlGetAttr(xmlClass))



 classesChildren = lapply(classes, xmlChildren)
lapply(classes, function(xmlClass) xmlChildren(xmlClass)$attributes)

lapply(classes, function(xmlClass) xmlChildren(xmlClass)$attributes = myChildModifier(xmlChildren(xmlClass)$attributes))

useClass2(classes[1])

xmlClass = xml2::xml_child(useXML, search = 3)
