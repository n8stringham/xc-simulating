library(magrittr)
library(rvest)
library(xml2)
library(stringi)
library(dplyr)

urls <- c("https://www.tfrrs.org/results/xc/16561", "https://www.tfrrs.org/results/xc/16562",
           "https://www.tfrrs.org/results/xc/16563", "https://www.tfrrs.org/results/xc/16564",
          "https://www.tfrrs.org/results/xc/16565", "https://www.tfrrs.org/results/xc/16567", 
          "https://www.tfrrs.org/results/xc/16568", "https://www.tfrrs.org/results/xc/16724")

df <- data.frame(PL=integer(),
                 NAME=character(),
                 YEAR=character(),
                 TEAM=character(),
                 TIME=character()
                 )

for(url in urls) {
  webpage <- read_html(url)
  print("read webpage")
  table_of_tables <- xml_find_all(webpage, "//table") %>% html_table
  titles <- html_nodes(webpage, "h3")
  table_index <- 2
  for(i in 1:length(titles[])) {
    if(grepl("8K|8000|8,000", titles[i][1])) {
      table_index <- i
      print(table_index)
      current_data <- table_of_tables[[table_index]] %>% select(NAME, YEAR, TEAM, TIME)
      df <- rbind(df, current_data)
      break
    }
  }
}



