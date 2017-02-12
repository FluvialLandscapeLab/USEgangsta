# create R "newClass" objects using the information in useXML


# classFinder = function(useXML = useXML){
#   for(i in 1:length(xml2::xml_children(useXML))){
#     xmlClass = xml2::xml_child(useXML, search = i)
#   }
#   return(xmlClass)
# }


useClass = function(useXML = useXML){
  newClassList <- list()
  for(i in 1:length(xml2::xml_children(useXML))){
    xmlClass = xml2::xml_child(useXML, search = i)
    if (grepl("class", xmlClass) == TRUE){
      a = unlist(
        strsplit(
          xml2::xml_text(
            xml2::xml_child(xmlClass, search = "attributes")
          )
          , split = "\n")
      )
      a = a[!(a == "")]

      o = unlist(
        strsplit(
          xml2::xml_text(
            xml2::xml_child(
              xmlClass, search = "operations")
          )
          , split = "\n")
      )
      o = o[!(o == "")]

      c = unlist(
        strsplit(
          xml2::xml_text(
            xml2::xml_child(
              xmlClass, search = "constraints")
          )
          , split = "\n")
      )
      c = c[!(c == "")]

      className = xml2::xml_attrs(xmlClass)

      newClass = structure(
        list(
          name = className,
          attributes = a,
          operations = o,
          constraints = c
        )
      )
      newClassList <- append(newClassList, newClass, after = length(newClassList))
    }
  }
  return(newClassList)
}





