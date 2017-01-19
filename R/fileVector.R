createChildNames = function(modFileVector) {
  # create children tags
  childTags = "^<class>|^<association>|^<composition>|^<modelconstraints>"
  # identify locations where child tags are present
  childTagsIdx = grepl(childTags, modFileVector)
  # add attribute "name =" to tag
  modFileVector[childTagsIdx] = sub(">", paste0(" name = ",'"'), modFileVector[childTagsIdx])
  # close tag
  modFileVector[childTagsIdx] = paste0(modFileVector[childTagsIdx], paste0('"', ">"))
  return(modFileVector)
}

createElementTags = function(fileVector) {
  # create open element tags for fileVector
  elementTags = "^attributes$|^operations$|^constraints$"
  # match element tags to fileVector
  elementTagsMatch = grep(elementTags, fileVector, value = TRUE)
  elementTagsIdx = grepl(elementTags, fileVector)
  # replace elementtag with <elementtag>
  fileVector[elementTagsIdx] = paste0("<",elementTagsMatch,">")
  return(fileVector)
}

addTagsToElement = function(fileVector) {
  tagRoots = c("attributes", "operations", "constraints")
  openTags = paste0("<", tagRoots, ">")
  closeTags = paste0("</", tagRoots, ">")
  closeElementTags = "</class>|</modelconstraints>|</association>|</composition"

  newFileVector = fileVector
  priorTagIdx = NULL
  addCount = -1
  for(i in 1:length(fileVector)) {
    tag = fileVector[i]
    tagIdx = which(openTags == tag)
    if(length(tagIdx) > 0) {
      if(!is.null(priorTagIdx)) {
        newFileVector = append(newFileVector, closeTags[priorTagIdx], i + addCount)
        addCount =addCount +1
      }
      priorTagIdx = tagIdx
    }
    else if (grepl(closeElementTags, tag) == TRUE){
      if(!is.null(priorTagIdx)) {
        newFileVector = append(newFileVector, closeTags[priorTagIdx], i + addCount)
        addCount =addCount +1
      }
      priorTagIdx = NULL
    }
  }
  return(newFileVector)
}
