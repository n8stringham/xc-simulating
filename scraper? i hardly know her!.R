library(magrittr)
library(rvest)
library(xml2)
library(stringi)
library(dplyr)
library(stringr)
library(tidyverse)
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


#####Pulling meet results for national qualifying teams
urls<-c("https://www.tfrrs.org/teams/CA_college_m_Claremont_Mudd_Scripps.html", 
        "https://www.tfrrs.org/teams/CA_college_m_Pomona_Pitzer.html", "https://www.tfrrs.org/teams/IL_college_m_North_Central_IL.html",
        "https://www.tfrrs.org/teams/MA_college_m_Williams.html", "https://www.tfrrs.org/teams/MO_college_m_Washington_U.html",
        "https://www.tfrrs.org/teams/MD_college_m_Johns_Hopkins.html", "https://www.tfrrs.org/teams/WI_college_m_Wis_La_Crosse.html",
        "https://www.tfrrs.org/teams/NY_college_m_Geneseo_St.html", "https://www.tfrrs.org/teams/MA_college_m_MIT.html",
        "https://www.tfrrs.org/teams/NY_college_m_RPI.html", "https://www.tfrrs.org/teams/MN_college_m_Carleton.html", 
        "https://www.tfrrs.org/teams/IL_college_m_U_of_Chicago.html", "https://www.tfrrs.org/teams/IA_college_m_Wartburg.html",
        "https://www.tfrrs.org/teams/xc/MI_college_m_Calvin.html", "https://www.tfrrs.org/teams/xc/NY_college_m_St_Lawrence.html",
        "https://www.tfrrs.org/teams/xc/ME_college_m_Colby.html", "https://www.tfrrs.org/teams/xc/GA_college_m_Emory.html", 
        "https://www.tfrrs.org/teams/xc/PA_college_m_Carnegie_Mellon.html", "https://www.tfrrs.org/teams/xc/OH_college_m_John_Carroll.html",
        "https://www.tfrrs.org/teams/xc/OH_college_m_Otterbein.html", "https://www.tfrrs.org/teams/xc/WI_college_m_Wis_Stout.html",
        "https://www.tfrrs.org/teams/xc/CA_college_m_UC_Santa_Cruz.html", "https://www.tfrrs.org/teams/xc/MA_college_m_Amherst.html",
        "https://www.tfrrs.org/teams/xc/OH_college_m_Case_Western.html", "https://www.tfrrs.org/teams/xc/MN_college_m_St_Olaf.html",
        "https://www.tfrrs.org/teams/xc/NY_college_m_Ithaca.html", "https://www.tfrrs.org/teams/xc/PA_college_m_Haverford.html",
        "https://www.tfrrs.org/teams/xc/MN_college_m_St_Thomas.html", "https://www.tfrrs.org/teams/xc/VT_college_m_Middlebury.html",
        "https://www.tfrrs.org/teams/xc/KY_college_m_Berea.html", "https://www.tfrrs.org/teams/xc/NY_college_m_Oneonta.html",
        "https://www.tfrrs.org/teams/xc/ME_college_m_Bates.html")

team_races<-list()
for(url in urls) {
  webpage <- read_html(url)
  print("read webpage")
  links_tmp=str_match_all(webpage, "<a href=\"(.*?)\"")
  links=links_tmp[[1]][,2]
  links=links[grepl("results/xc", links)]
  table_of_tables <- xml_find_all(webpage, "//table") %>% html_table
  dates=table_of_tables[[2]]$DATE[grepl("Nov|Oct|Sep|Aug", table_of_tables[[2]]$DATE)]
  dates_and_links<-cbind(dates, links)
  name=stringr::str_split(url, "_m_")[[1]][2]
  name=stringr::str_split(name, ".html")[[1]][1]
  dates_and_links=as.data.frame(dates_and_links)
  dates_and_links=dates_and_links %>% filter(grepl(2019, dates_and_links$dates))
  team_races[[name]]<-dates_and_links
}

####Pomona Pitzer Races
PPraces<-team_races$Pomona_Pitzer[grep("2019", team_races$Pomona_Pitzer[,1]),]
PPlinks<-paste("https:", gsub("%0A", "%250A", PPraces[,2]), sep="")

df <- data.frame(PL=integer(),
                 NAME=character(),
                 YEAR=character(),
                 TEAM=character(),
                 TIME=character(),
                 COURSE=character(),
                 DATE=character()
)

for(url in PPlinks) {
  print(url)
  webpage <- read_html(url)
  print("read webpage")
  table_of_tables <- xml_find_all(webpage, "//table") %>% html_table
  titles <- html_nodes(webpage, "h3")
  courses <- html_nodes(webpage, ".inline-block")
  table_index <- 2
    #generate possible indices
    
    if(length(titles)>length(table_of_tables)){titles=titles[2:length(titles)]}
    poss_indices=grep("8K|8000|8,000|8k|6k|6000|6,000|6K", titles)
    for(i in 1:length(poss_indices)) {
    if(grepl("Individual", titles[poss_indices[i]])) {
      table_index <- poss_indices[i]
      print(table_index)
      current_data <- table_of_tables[[table_index]] %>% select(NAME, YEAR, TEAM, TIME)
      current_data <- current_data %>% mutate(DATE=html_text(courses[4][1]))
      if(str_length(html_text(courses[5][1])) > 4) {
        current_data <- current_data %>% mutate(COURSE=html_text(courses[5][1]))
      } else {
        current_data <- current_data %>% mutate(COURSE="NA")
      }
      df <- rbind(df, current_data)
    }
  }
}

df %>% filter(TEAM=="Pomona-Pitzer") %>% View()

######Bijon Race Adjustments

webpage<-read_html("https://bijanmazaheri.wordpress.com/2019/11/18/2019-diii-meet-adjustments-men/")
table_of_tables <- xml_find_all(webpage, "//table") %>% html_table
course_corrections<-as.data.frame(table_of_tables[[1]])
colnames(course_corrections)<-c("Meet", "Score")
course_corrections<-course_corrections %>% filter(Meet!="Meet")

