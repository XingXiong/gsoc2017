

#################
create_csv <- function(inputfilename,outputfilename){
  require(stringr)
  # Read all lines
  data <- readLines(inputfilename)
  a <- length(data)
  # Create a new data frame with header.
  csvfile <- data.frame(Family = "",SciName = "",Distribution = "")
  # Set the intial value for the variable that is used to decide whether 
  # a new line is a Family word.
  familystatus = TRUE
  for (i in 1:a){
    # If a line withour space and the variable familystatus is TRUE,
    # then this line should  be a word of family.
    if (data[i] != ""){if (! str_detect(data[i],"[[:blank:]]") & familystatus == TRUE) {family = data[i] 
    familystatus = FALSE} 
      # If a line starts with numbers,then it belongs to sciname.
      else{ if (str_detect(data[i],"^[0-9]+")){sciname = gsub("^[0-9]*[.]{1}[[:blank:]]+","",data[i])
    } else { if (str_detect(data[i],"Distribution"))
      # When all distributions have been collected,the
      # write process will start.And only after the write
      # process finishes,the familystatus variable will
      # be True again.
      {if (str_detect(data[i],"[.]$") | str_detect(data[i+2],"^[0-9]+")) 
      {familystatus = TRUE 
      # A line contains two "Distribution:" can be solved
      # by this code.
    distribution = str_replace_all(data[i], "Distribution:", "")
    row = data.frame(Family = c(family),SciName = c(sciname),Distribution = c(distribution)) 
    csvfile = rbind(csvfile,row)
    } else {familystatus = FALSE 
    distribution = str_replace_all(data[i], "Distribution:", "") }} 
      else{if (str_detect(data[i],"[.]$") | str_detect(data[i+2],"^[0-9]+")) {familystatus = TRUE
    distribution = paste(distribution,data[i]) 
    row = data.frame(Family = c(family),SciName = c(sciname),Distribution = c(distribution)) 
    csvfile = rbind(csvfile,row)
    } else {distribution = paste(distribution,data[i])
    familystatus = FALSE}
      }}}}}
  # Do some tidy to make the output more cleaner.
  csvfile <- csvfile[-1,]
  csvfile$Distribution <- gsub("^[[:blank:]]+","",csvfile$Distribution)
  write.csv(csvfile,outputfilename,row.names = FALSE)
}
create_csv("taxo01.txt","taxo01_out by Xing.csv")
