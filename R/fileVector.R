modFileVector = fileVector
# create children tags
childTags = "^<class>|^<association>|^<composition>|^<modelconstraints>"
# identify locations where child tags are present
childTagsIdx = grepl(childTags, modFileVector)
# add attribute "name =" to tag
modFileVector[childTagsIdx] = sub(">", paste0(" name = ",'"'), modFileVector[childTagsIdx])
# close tag
modFileVector[childTagsIdx] = paste0(modFileVector[childTagsIdx], paste0('"', ">"))


# create open element tags for modFileVector
elementTags = "^attributes$|^operations$|^constraints$"
# match element tags to fileVector
elementTagsMatch = grep(elementTags, modFileVector, value = TRUE)
elementTagsIdx = grepl(elementTags, modFileVector)
# replace elementtag with <elementtag>
modFileVector[elementTagsIdx] = paste0("<",elementTagsMatch,">")

#create closing element tags for modfileVector




