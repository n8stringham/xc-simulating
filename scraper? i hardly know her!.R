library(magrittr)
library(rvest)
library(xml2)
library(stringi)
library(dplyr)
library(stringr)
library(tidyverse)


###Initial codestuff
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


###########
##Meet Results for National Qualifiers
###########

#first get team names
df <- data.frame(PL=integer(),
                 NAME=character(),
                 YEAR=character(),
                 TEAM=character(),
                 TIME=character(),
                 COURSE=character(),
                 DATE=character(),
                 MEETNAME=character()
)

url="https://www.tfrrs.org/results/xc/16726/NCAA_Division_III_Cross_Country_Championships"
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

teamnames<-unique(df$TEAM)

#####Pulling meet results for national qualifiers
urls<-c("https://www.tfrrs.org/teams/MD_college_m_Stevenson.html", "https://www.tfrrs.org/teams/MN_college_m_Carleton.html", 
        "https://www.tfrrs.org/teams/CA_college_m_Claremont_Mudd_Scripps.html", "https://www.tfrrs.org/teams/MD_college_m_Johns_Hopkins.html",
        "https://www.tfrrs.org/teams/WI_college_m_Wis_La_Crosse.html", "https://www.tfrrs.org/teams/WI_college_m_Wis_Whitewater.html",
        "https://www.tfrrs.org/teams/CA_college_m_Pomona_Pitzer.html", "https://www.tfrrs.org/teams/IL_college_m_U_of_Chicago.html",
        "https://www.tfrrs.org/teams/MA_college_m_Williams.html", "https://www.tfrrs.org/teams/IL_college_m_North_Central_IL.html", 
        "https://www.tfrrs.org/teams/OH_college_m_Otterbein.html", "https://www.tfrrs.org/teams/WI_college_m_Wis_Platteville.html",
        "https://www.tfrrs.org/teams/xc/GA_college_m_Emory.html", "https://www.tfrrs.org/teams/xc/OH_college_m_John_Carroll.html",
        "https://www.tfrrs.org/teams/NY_college_m_RPI.html", "https://www.tfrrs.org/teams/xc/MI_college_m_Calvin.html", 
        "https://www.tfrrs.org/teams/MO_college_m_Washington_U.html", "https://www.tfrrs.org/teams/WI_college_m_Wis_Oshkosh.html",
        "https://www.tfrrs.org/teams/IA_college_m_Wartburg.html", "https://www.tfrrs.org/teams/NY_college_m_Geneseo_St.html", 
        "https://www.tfrrs.org/teams/CA_college_m_Redlands.html", "https://www.tfrrs.org/teams/xc/NY_college_m_St_Lawrence.html",
        "https://www.tfrrs.org/teams/PA_college_m_Elizabethtown.html", "https://www.tfrrs.org/teams/MA_college_m_MIT.html",
        "https://www.tfrrs.org/teams/MN_college_m_Hamline.html", "https://www.tfrrs.org/teams/xc/VT_college_m_Middlebury.html",
        "https://www.tfrrs.org/teams/xc/ME_college_m_Colby.html", "https://www.tfrrs.org/teams/WI_college_m_Wis_Eau_Claire.html",
        "https://www.tfrrs.org/teams/xc/PA_college_m_Haverford.html", "https://www.tfrrs.org/teams/OH_college_m_Franciscan-OH.html",
        "https://www.tfrrs.org/teams/CT_college_m_Conn_College.html", "https://www.tfrrs.org/teams/xc/PA_college_m_Carnegie_Mellon.html",
        "https://www.tfrrs.org/teams/xc/MN_college_m_St_Thomas.html", "https://www.tfrrs.org/teams/WI_college_m_Lawrence.html",
        "https://www.tfrrs.org/teams/xc/WI_college_m_Wis_Stout.html", "https://www.tfrrs.org/teams/NY_college_m_Brockport_St.html",
        "https://www.tfrrs.org/teams/xc/MA_college_m_Amherst.html", "https://www.tfrrs.org/teams/NJ_college_m_Rowan.html",
        "https://www.tfrrs.org/teams/xc/KY_college_m_Berea.html", "https://www.tfrrs.org/teams/xc/CA_college_m_UC_Santa_Cruz.html",
        "https://www.tfrrs.org/teams/MN_college_m_Gustavus_Adolphus.html", "https://www.tfrrs.org/teams/OH_college_m_Mount_Union.html",
        "https://www.tfrrs.org/teams/PA_college_m_Marywood.html", "https://www.tfrrs.org/teams/PA_college_m_Moravian.html",
        "https://www.tfrrs.org/teams/IN_college_m_DePauw.html", "https://www.tfrrs.org/teams/MA_college_m_Bridgewater_St.html",
        "https://www.tfrrs.org/teams/xc/MN_college_m_St_Olaf.html", "https://www.tfrrs.org/teams/VA_college_m_Southern_Virginia.html",
        "https://www.tfrrs.org/teams/xc/NY_college_m_Ithaca.html", "https://www.tfrrs.org/teams/CA_college_m_Caltech.html",
        "https://www.tfrrs.org/teams/xc/NY_college_m_Oneonta.html","https://www.tfrrs.org/teams/xc/OH_college_m_Case_Western.html",
        "https://www.tfrrs.org/teams/TX_college_m_Trinity_TX.html", "https://www.tfrrs.org/teams/IA_college_m_Loras.html",
        "https://www.tfrrs.org/teams/MA_college_m_WPI.html", "https://www.tfrrs.org/teams/PA_college_m_Widener.html",
        "https://www.tfrrs.org/teams/WI_college_m_Wis_Stevens_Point.html", "https://www.tfrrs.org/teams/VA_college_m_Mary_Washington.html",
        "https://www.tfrrs.org/teams/OR_college_m_Lewis__Clark.html", "https://www.tfrrs.org/teams/xc/ME_college_m_Bates.html",
        "https://www.tfrrs.org/teams/IA_college_m_Luther.html", "https://www.tfrrs.org/teams/VA_college_m_Lynchburg.html",
        "https://www.tfrrs.org/teams/VA_college_m_Virginia_Wesleyan.html", "https://www.tfrrs.org/teams/IN_college_m_Trine.html",
        "https://www.tfrrs.org/teams/MA_college_m_Suffolk.html", "https://www.tfrrs.org/teams/TN_college_m_Rhodes.html",
        "https://www.tfrrs.org/teams/ME_college_m_U_of_New_England.html", "https://www.tfrrs.org/teams/PA_college_m_Muhlenberg.html",
        "https://www.tfrrs.org/teams/ME_college_m_Bowdoin.html", "https://www.tfrrs.org/teams/NJ_college_m_Ramapo.html",
        "https://www.tfrrs.org/teams/CT_college_m_Trinity_CT.html", "https://www.tfrrs.org/teams/CA_college_m_Occidental.html",
        "https://www.tfrrs.org/teams/CO_college_m_Colorado_College.html", "https://www.tfrrs.org/teams/WA_college_m_Puget_Sound.html",
        "https://www.tfrrs.org/teams/NY_college_m_New_Paltz_St.html", "https://www.tfrrs.org/teams/IL_college_m_Benedictine_IL.html",
        "https://www.tfrrs.org/teams/CA_college_m_La_Verne.html", "https://www.tfrrs.org/teams/NJ_college_m_TCNJ.html",
        "https://www.tfrrs.org/teams/AR_college_m_Ozarks.html", "https://www.tfrrs.org/teams/MN_college_m_Bethel_MN.html",
        "https://www.tfrrs.org/teams/NY_college_m_NYU.html", "https://www.tfrrs.org/teams/OH_college_m_Heidelberg.html"
        )

team_races<-list()
for(url in urls) {
  print(url)
  webpage <- read_html(url)
  print("read webpage")
  links_tmp=str_match_all(webpage, "<a href=\"(.*?)\"")
  links=links_tmp[[1]][,2]
  links=links[grepl("/results/", links)]
  links=unique(links)
  links=links[setdiff(1:length(links), grep('[[:digit:]]{5}/[[:digit:]]{6}', links))]
  table_of_tables <- xml_find_all(webpage, "//table") %>% html_table
  index=grep("DATE", table_of_tables)
  dates_and_links=table_of_tables[[index]]
  dates_and_links<-cbind(dates_and_links, links)
  dates_and_links<-dates_and_links %>% filter(grepl("/results/xc/", dates_and_links$links))
  name=stringr::str_split(url, "_m_")[[1]][2]
  name=stringr::str_split(name, ".html")[[1]][1]
  dates_and_links=dates_and_links %>% filter(grepl(2019, dates_and_links$DATE))
  dates_and_links$links<-paste("https:", gsub("%0A", "%250A", dates_and_links$links), sep="")
  team_races[[name]]<-dates_and_links
}

names(team_races)<-teamnames

#Now we have a list 'team_races' that contains dates, meets, and links to results for every race run in 2019 for
#all national qualifiers
  
#####Construct list of race times for qualifying teams 
season_results<-list()

for (j in 1:length(team_races)){
racelinks<-team_races[[j]]$links
print(names(team_races)[j])

resdf <- data.frame(PL=integer(),
                 NAME=character(),
                 YEAR=character(),
                 TEAM=character(),
                 TIME=character(),
                 COURSE=character(),
                 DATE=character(),
                 MEETNAME=character()
)

for(url in racelinks) {
  print(url)
  webpage <- read_html(url)
  print("read webpage")
  table_of_tables <- xml_find_all(webpage, "//table") %>% html_table
  titles <- html_nodes(webpage, "h3")
  meetnamelinks <-html_nodes(webpage, "a")
  courses <- html_nodes(webpage, ".inline-block")
  table_index <- 2
    #generate possible indices
    
    if(length(titles)>length(table_of_tables)){titles=titles[2:length(titles)]}
    poss_indices=grep("8K|8000|8,000|8k", titles)
    if (length(poss_indices)==0){break}
    else{
    for(i in 1:length(poss_indices)) {
    if(grepl("Individual", titles[poss_indices[i]])) {
      table_index <- poss_indices[i]
      print(table_index)
      current_data <- table_of_tables[[table_index]] %>% select(NAME, YEAR, TEAM, TIME)
      current_data <- current_data %>% mutate(DATE=html_text(courses[4][1]))
      current_data <- current_data %>% mutate(MEETNAME=html_text(meetnamelinks[[14]]))
      if(str_length(html_text(courses[5][1])) > 4) {
        current_data <- current_data %>% mutate(COURSE=html_text(courses[5][1]))
      } else {
        current_data <- current_data %>% mutate(COURSE="NA")
      }
      resdf <- rbind(resdf, current_data)
    }
  }
}
}
season_results[[j]]<-resdf %>% filter(TEAM==names(team_races)[j])
}

teamnames

######Bijon Race Adjustments

webpage<-read_html("https://bijanmazaheri.wordpress.com/2019/11/18/2019-diii-meet-adjustments-men/")
table_of_tables <- xml_find_all(webpage, "//table") %>% html_table
course_corrections<-as.data.frame(table_of_tables[[1]])
colnames(course_corrections)<-c("Meet", "Score")
course_corrections<-course_corrections %>% filter(Meet!="Meet")

