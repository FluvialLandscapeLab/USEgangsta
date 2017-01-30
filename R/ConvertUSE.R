# replace end of a class with </class> tag by finding every line that starts with class, associaiton, composition or begin and giving them a 1. Then every end gets a -1. When the line is equal to 0 then the propoer closing tag is assigned

createParents = function(useFile = file.choose()) {
  # Choose the .use file to read
   useFile = file.choose()
  # convert the USE file to a vector
  fileVector =
    as.character(
      read.table(useFile, header = F, sep= "~", blank.lines.skip = T)[[1]]
    )
  ### Clean fileVector ###
  # clip leading and trailing blank space
  fileVector = sub("^[[:space:]]+", "", fileVector)
  fileVector = sub("[[:space:]]+$", "", fileVector)
  # remove commented lines
  fileVector = grep("^[-]+", fileVector, value = TRUE, invert =TRUE)
  # remove blank lines
  fileVector = fileVector[!(fileVector == "")]
  # remove symbols that violate xml
  fileVector = sub("&",";amp", fileVector)
  fileVector = sub("<", ";lt", fileVector)


  # create list of object tags
  objectTags = "^class\\>|^association\\>|^composition\\>"
  # locate objcet tags in fileVector
  matchObjectVector = grepl(objectTags, x = fileVector)

  # create list of open tags composed of all the object tags plus "begin"
  openTags = paste0(objectTags, "|^begin\\>")
  #match opening tags to fileVector
  matchOpenVector = as.numeric(grepl(openTags, x = fileVector))


  # identify lines that start with end
  allEndTags = "^end$"
  #match the lines of fileVector that consist of ends
  matchEndVector = -as.numeric(grepl(allEndTags, fileVector))

  # combine the two Numeric vectors
  matchGroup = matchOpenVector + matchEndVector
  # cumsum the matchGroup vector to determine where end tags go
  matchSum = cumsum(matchGroup)

  # find all end tags associated with open tags. End locations that correspond to
  # open tags are anywhere a 0 is preceded by a 1.
  shiftedMatchSum = c(0, matchSum[-length(matchSum)])
  matchCloseVector = matchSum == 0 & shiftedMatchSum == 1

  # locate the lines of fileVector that start with an object tag
  openText = strsplit(fileVector[matchObjectVector], " ", fixed = T)
  # pull out just the object tag from these lines
  closeText = sapply(openText, "[", 1)
  # replace object tags with <objectTag>
  openText =
    sapply(
      openText,
      function(x) {
        x[1] = paste0("<", x[1], '>')
        return(paste(x, collapse = " "))
      }
    )
  # insert </objectTag> to close out the corresponding<objectTag>
  closeText = paste0("</", closeText, ">")
  fileVector[matchObjectVector] = openText
  fileVector[matchCloseVector] = closeText

  # specify model tag
  modelTag = "^model\\>"
  # pull out the remaining lines and specify as lines that describe the model (model text). Determined by matchSum == 0 and shiftedMatchsum == 0
  matchModelVector = matchSum == 0 & shiftedMatchSum == 0

  modelText = fileVector[matchModelVector]

  # pull out the model tag from the model text
  modelTagVector = grep(modelTag, modelText)
  # locate lines of model text that start with a model tag
  modelTagLine = strsplit(modelText[modelTagVector], " ", fixed = T)
  # replace matching model tags with opening opening model tag
  openModel = sapply(
    modelTagLine,
    function(x) {
      x[1] = paste0("<", x[1], '>')
      return(paste(x, collapse = " "))
    }
  )
  modelText = gsub(modelText[modelTagVector], openModel, modelText)

  # apply to fileVector
  fileVector[matchModelVector] = modelText

  # surround model text in <modelcontraints> and </modelconstraints> to avoid xml error
  # replace <model> with <modelconstraints>
  modelText = sub("<model>", "<modelconstraints>", x= modelText)
  #insert <model> at the top of modelText
  openModelTag = "<model>"
  modelText = c(openModelTag, modelText)

  # insert </modelconstraints> at the end of modelText
  closeModelCTag = "</modelconstraints>"
  modelText = c(modelText, closeModelCTag)

  # group all modelText to the top of fileVector
  fileVector = c(modelText, fileVector[!matchModelVector])

  # add closing model tag <\model> to fileVector
  closeModelTag = "</model>"
  fileVector= c(fileVector, closeModelTag)
  return(fileVector)
}

