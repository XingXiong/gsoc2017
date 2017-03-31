
###############
# Almost the same as easy test2,I get ".SN li" from the website structure.
# 
    
crawl_species <- function(validurl,outputfilename1,outputfilename2){
  require(rvest)
  require(stringr)
  url1 <- validurl
  species <- url1 %>%
    read_html()%>%
    html_nodes(".SN li")
  species <- gsub("<i>|</i>|<li>","",species)
  species <- gsub("&amp;","&",species)
  species <- gsub("\\;.*","",species)
  # This step get the full scientific name.
  full_scientific_name <- species
  full_scientific_name <- gsub("=","",species)
  full_scientific_name <- sub("^\\s","",full_scientific_name)
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
  species <- gsub("\\s*","",species)
  subspecies <-as.character(subspecies)
  subspecies <- gsub("^\\s+|\\s+$","",subspecies)
  subspecies1 <- str_extract(subspecies,"^[A-z]+\\s?")
  restofspecies <- gsub("^[A-z]+\\s?"," ",subspecies)
  author <- paste(restofspecies,author)
  author <- as.character(author)
  author <- gsub("^\\s*|,","",author)
  year <- as.character(year)
  
  for (i in 1:a){if (genus[i] != "character(0)"){final[i,1] = genus[i]} else{final[i,1] = " 
"}
    if (species[i] != "character(0)"){final[i,2] = species[i]} else{species[i] = " "
    final[i,2] = " "}
    if (! is.na(subspecies1[i])){final[i,3] = subspecies1[i]} else{final[i,3] = " "}
    if (author[i] != "character(0)"){final[i,4] = author[i]} else{final[i,4] = " "}
    if (year[i] != "character(0)"){final[i,5] = year[i]} else{final[i,5] = " "}}
  write.csv(final,outputfilename1,row.names = FALSE)
  write.csv(full_scientific_name,outputfilename2,row.names = FALSE)
  species
}
crawl_species("http://ftp.funet.fi/pub/sci/bio/life/insecta/lepidoptera/ditrysia/papilionoidea/papilionidae/papilioninae/lamproptera/","allcomponents.csv","full sciname.csv")
