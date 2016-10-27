# FOLLOW THESE INSTRUCTIONS!!!! http://r-pkgs.had.co.nz/intro.html#intro-get

# WHEN YOU INSTALL R TOOLS, be sure the check to box when is asks you if you
# want to update the system path!!!


# Choose the .use file to read
useFile = file.choose()
fileVector =
  as.character(
    read.table(useFile, header = F, sep= "~", blank.lines.skip = T)[[1]]
  )
### Clean fileVector ###
# clip leading and trailing blank space
fileVector = sub("^[[:space:]]+", "", fileVector)
fileVector = sub("[[:space:]]+$", "", fileVector)
# remove blank lines
fileVector = fileVector[!(fileVector == "")]
# remove comments
fileVector = fileVector[-(grep("^-", fileVector))]

makeTags = function(OCL) {
  # get the regular expressions that signify XML tags
  tags = unlist(options("USEgangsta.OCLtags"))
  # locate the lines of OCL that have tags
  matchList = lapply(tags, grep, x = OCL)
  # find the location of the beginning of each tag in each line
  matchLocList = lapply(tags, regexpr, text = OCL)
  # attributes of each vector in matchLocLis has a vector of the lengths of the
  # tags.  Get those lengths.
  lengthList = lapply(matchLocList, attr, "match.length")
  # calculate the stopping location of each tag = start + length - 1
  stopList = mapply("+", lengthList, matchLocList, SIMPLIFY = F)
  stopList = lapply(stopList, "-", 1)
  # extract the text of each tag from the OCL
  tagTextList = mapply(
    substr,
    start = matchLocList,
    stop = stopList,
    MoreArgs = list(x = OCL),
    SIMPLIFY = F
  )
  # add leading "<" and ">" to the tag of each text
  tagTextList = mapply(paste0, "<", tagTextList, ">", SIMPLIFY = F)
  # substitute "<tag>" for "tag" in each line of OCL
  for (i in 1:length(tags)) {
    OCL = mapply(sub, tags[i], tagTextList[[i]], OCL, USE.NAMES = F)
  }
}


### To get rid of the useless "ends" but keep the useful ones, make a list of
### tags that have "useless ends".  Insert the close tags (e.g., "<\class>") for
### each level of the hierarchy.  If an "end" appears directly above the close
### of a class with a usless end, delete it.
