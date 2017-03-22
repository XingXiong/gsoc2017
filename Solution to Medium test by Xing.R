
###############
# Almost the same as easy test2,I get ".SN li" from the website structure.
# 

crawl_species <- function(x,y,z){
  require(rvest)
  require(stringr)
  url1 <- x
  species <- url1 %>%
    read_html()%>%
    html_nodes(".SN li")
  species <- gsub("<i>|</i>|<li>","",species)
  species <- gsub("&amp;","&",species)
  species <- gsub("\\;.*","",species)
  # This step get the full scientific name.
  full_scientific_name <- species
  full_scientific_name <- gsub("=","",species)
  # Following steps are fetching genus,author,year,species,subspecies in order.
  genus <- str_extract_all(full_scientific_name,"^[[:blank:]]?[A-z]+")
  rest1 <- gsub("^[[:blank:]]?[A-z]+","",full_scientific_name)
  author <- str_extract_all(rest1,"[A-Z]{1}.?\\s?&?\\s?[A-z]+.?(.*?)?,")
  year <- str_extract_all(full_scientific_name,"\\s?[0-9]+")
  rest2 <- gsub("[A-Z]{1}.?\\s?&?\\s?[A-z]+.?(.*?)?,","",rest1)
  rest3 <- gsub("[?[0-9]+]?","",rest2)
  species <- str_extract_all(rest3,"^\\s?[A-z]+")
  subspecies <- gsub("^\\s?[A-z]+","",rest3)
  
  a <- length(full_scientific_name)
  final <- data.frame(genus = c(rep(0,a)),species = c(rep(0,a)),subspecies = c(rep
                                                                               (0,a)),author = c(rep(0,a)),year = c(rep(0,a)))
  genus <- as.character(genus)
  species <- as.character(species)
  subspecies <-as.character(subspecies)
  subspecies <- gsub("^\\s+|\\s+$","",subspecies)
  author <- as.character(author)
  author <- gsub(",","",author)
  year <- as.character(year)
  
  for (i in 1:a){if (genus[i] != "character(0)"){final[i,1] = genus[i]} else{final[i,1] = " 
"}
    if (species[i] != "character(0)"){final[i,2] = species[i]} else{final[i,2] = " "}
    if (subspecies[i] != "character(0)"){final[i,3] = subspecies[i]} else{final[i,3] = " "}
    if (author[i] != "character(0)"){final[i,4] = author[i]} else{final[i,4] = " "}
    if (year[i] != "character(0)"){final[i,5] = year[i]} else{final[i,5] = " "}}
  write.csv(final,y,row.names = FALSE)
  write.csv(full_scientific_name,z,row.names = FALSE)
}
crawl_species("http://ftp.funet.fi/pub/sci/bio/life/insecta/lepidoptera/ditrysia/papilionoidea/papilionidae/papilioninae/lamproptera/","allcomponents.csv","full sciname.csv")
