# function to create element tags in useXML rather than fileVector

createElementTags2 = function(useXML) {
  # create element opening and closing tags
  tagRoots = c("attributes", "operations", "constraints")
  tags = "^attributes|^operations|^constraints"
  openTags = paste0("<", tagRoots, ">")
  closeTags = paste0("</", tagRoots, ">")

  # extract text from each child
  for (i in 1:length(xml_children(useXML))) {
    test = xml_text(xml_child(useXML, search = i))
    # string split the text from each child
    test2 = unlist(strsplit(test, split = "\n"))
    # locate tagRoots in the split text
    test3 = grep(tags, test2, value = T)
    if (TRUE %in% grepl(tags, test3)) {
      for(i in 1:length(test2)){
        if (test2[i] %in% tagRoots){
          test2[i] = paste0("<", test2[i], ">")
        }
      }
    }
  }
}

#extracting info from useXML

test = xml2::xml_child(useXML, search = 3)
test2 = xml2::xml_children(test)
test3 = xml2::xml_child(test, search = "attributes")
test4 = xml2::xml_text(test3)
test5 = unlist(strsplit(test4, split = "\n"))
test5 = test5[!(test5 == "")]

class(test5)<- "Compound"

className = xml2::xml_attrs(xml2::xml_child(useXML, search = 3))
test6 = xml2::xml_text(test2)
test7 = unlist(strsplit(test6, split = "\n"))
test7 = test7[!(test7 == "")]


class(test7) <- className

classChildren <- grepl("class", xml2::xml_children(useXML))

