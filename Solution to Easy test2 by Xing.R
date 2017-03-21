

####################
# Using the SelectorGadget plug-ins,I can get the input for html_nodes() directly
# and do some tidy.
library(rvest)
url2 <- "https://www.abdb-africa.org/genus/Papilio"
species <- url2 %>%
  read_html()%>%
  html_nodes(".specItem a")
species <- gsub("<i>|</i>|</a>","",species)
species <- gsub("<(.*?)>","",species)
species <- gsub("^[[:blank:]]+","",species)
species <- gsub("&amp;","&",species)
species <- gsub(",[[:blank:]][?(?[0-9]+)?]?","",species)
species
