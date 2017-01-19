# create R objects using the information in useXML

createRObjects <- function(useXML){

}

test = as.character(xml2::xml_child(useXML, search = 3))
test = strsplit(test, split = "\n")

test2 = xml2::xml_child(useXML, search = 3)
test3 = xml2::xml_text(xml2::xml_children(test2))

XML::xmlToS4(test2)
