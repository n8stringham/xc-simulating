library(magrittr)
library(rvest)
library(xml2)
library(stringi)
library(dplyr)
library(stringr)
urls <- c("https://www.tfrrs.org/results/xc/16561", "https://www.tfrrs.org/results/xc/16562",
           "https://www.tfrrs.org/results/xc/16563", "https://www.tfrrs.org/results/xc/16564",
          "https://www.tfrrs.org/results/xc/16565", "https://www.tfrrs.org/results/xc/16567", 
          "https://www.tfrrs.org/results/xc/16568", "https://www.tfrrs.org/results/xc/16724")

nationals_urls <- c("https://www.tfrrs.org/results/xc/15028", "https://www.tfrrs.org/results/xc/13424",
                    "https://www.tfrrs.org/results/xc/9349/", "https://www.tfrrs.org/results/xc/11260/",
                    "https://www.tfrrs.org/results/xc/6216/")

df <- data.frame(PL=integer(),
                 NAME=character(),
                 YEAR=character(),
                 TEAM=character(),
                 TIME=character(),
                 COURSE=character(),
                 DATE=character()
                 )

for(url in urls) {
  webpage <- read_html(url)
  print("read webpage")
  table_of_tables <- xml_find_all(webpage, "//table") %>% html_table
  titles <- html_nodes(webpage, "h3")
  courses <- html_nodes(webpage, ".inline-block")
  table_index <- 2
  for(i in 1:length(titles[])) {
    if(grepl("8K|8000|8,000|8k", titles[i][1])) {
      table_index <- i
      print(table_index)
      current_data <- table_of_tables[[table_index]] %>% select(NAME, YEAR, TEAM, TIME)
      current_data <- current_data %>% mutate(DATE=html_text(courses[4][1]))
      if(str_length(html_text(courses[5][1])) > 4) {
        current_data <- current_data %>% mutate(COURSE=html_text(courses[5][1]))
      } else {
        current_data <- current_data %>% mutate(COURSE="NA")
      }
      df <- rbind(df, current_data)
      break
    }
  }
}



