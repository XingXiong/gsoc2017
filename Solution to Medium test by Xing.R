
###############
# Almost the same as easy test2,I get ".SN li" from the website structure.
# 
crawl_species <- function(x){
  require(rvest)
  url1 <- x
  species <- url1 %>%
    read_html()%>%
    html_nodes(".SN li")
  species <- gsub("<i>|</i>|<li>","",species)
  species <- gsub("&amp;","&",species)
  species <- gsub("\\;.*","",species)
  species <- gsub("=","",species)
  species <- gsub(",[[:blank:]][?[0-9]+]?","",species)
  write.csv(species,file="species by Xing.csv")
  species
}
crawl_species("http://ftp.funet.fi/pub/sci/bio/life/insecta/lepidoptera/ditrysia/papilionoidea/papilionidae/papilioninae/lamproptera/")
