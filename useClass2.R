myClassVector = sapply(useXML, useClass2())


xmlClass = xml2::xml_child(useXML, search = 3)


useClass2 = function(xmlClass){
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
    class(newClass) <- className
  }
  return(newClass)
}
