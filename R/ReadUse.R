# Choose the .use file to read
useFile = file.choose()
fileLines = read.table(useFile, header = F, sep= "~", blank.lines.skip = T)
fileList = as.list(fileLines)


# Create R classes from USE file