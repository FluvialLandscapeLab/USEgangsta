rm(list = ls())

fileVector = createParents(useFile = file.choose())
fileVector = createChildNames(fileVector)
fileVector = createElementTags(fileVector)
fileVector = addTagsToElement(fileVector)
useXML = writeXML(fileVector)
