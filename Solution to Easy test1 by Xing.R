

######################
library(rvest)
url1 <- "http://ftp.funet.fi/pub/sci/bio/life/insecta/lepidoptera/ditrysia/papilionoidea/papilionidae/papilioninae/lamproptera/"
genus <- url1 %>%
  read_html()%>%
  # The first table in this page shows the sciname of the genus which it is going
  # to talk about.With the help of the SelectorGadget plug-ins,I can get the 
  # specific loction on the website of the target word
  html_nodes("tr:nth-child(2) td:nth-child(4)")
genus <- gsub("<(.*?)>|\n","",genus)
genus


# I also do it in another way,as the first table shows genus which are on the
# previous page and next page.And it also tells the Finnish and English name of
# this genus.So I crawl all the table,do tidy and get all genus names.If you 
# only want one genus that this page is talking about,you can set finalgenus
# variable only equals to genus$Scientific.names[1].
genus <- url1 %>%
  read_html()%>%
  html_nodes("table")%>%
  html_table(fill = TRUE)
genus <- genus[1]
genus <- data.frame(genus)
finalgenus <- c(genus$prev[1:3],genus$next.[1:3],genus$Scientific.names[1:3],genus$Finnish.names[1:3],genus$English.names[1:3])
finalgenus <- gsub("\\(|\\)","",finalgenus)
finalgenus <- gsub("[[:blank:]]","",finalgenus)
finalgenus <- tolower(finalgenus)
finalgenus <- unique(finalgenus)
finalgenus <- sort(finalgenus)
if (finalgenus[1] == ""){finalgenus <- finalgenus[-1]}
finalgenus
