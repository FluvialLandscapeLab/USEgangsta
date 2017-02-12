# create newClass from an individual xmlClass

useClass2 = function(xmlClass = xmlClasses){
  searchStr = c("attributes", "operations", "constraints")
  # make a list of the children denoted in "seachStr"
  childList = lapply(searchStr, xml2::xml_child, x = xmlClass)
  # make a list of the extracted text from each child
  result = lapply(childList, xml2::xml_text, trim = T)
  names(result) <- searchStr
  # add the name attribute to the list
  result = c(list(name = xml2::xml_attrs(xmlClass)), result)

  return(result)
}






