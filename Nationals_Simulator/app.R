#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Men's NCAA DIII Cross Country National Meet Simulator"),
   helpText("This applet allows you to run simulations of 
            the NCAA DIII Men's Cross Country National Meet.
            Each race is simulated by sampling a result for each athlete
            from a distribution created based off of course-adjusted 
            performances from earlier in the season.
            These results are then aggregated and scored according to
            Cross Country rules. It should be noted that since simulating
            team score was the primary goal that individuals qualifiers have
            been excluded from the simulation."),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        # Input: Selector for choosing dataset ----
        selectInput(inputId = "dataset",
                    label = "Choose a year",
                    choices = c("2018", "2019")),
        
        helpText("Note: this field refers to the year
                  of the national meet to be simulated."),
        
        # Input: Numeric entry for number of obs to view ----
        selectInput(inputId = "sims",
                     label = "Number of simulations to run",
                     choices = c(50,100,250,500,1000)),
        helpText("Note: here each simulation represents",
                 "a single national meet."),
        
        # Input: Selector for choosing a team of interest
        selectInput(inputId = "selectedTeam",
                    label = "Choose a team of interest",
                    choices = c("All", "Pomona-Pitzer", "Williams", "North Central (Ill.)", ""))
      ),
      
      # Show a table of simulation statistics
      mainPanel(
         tableOutput("simStats")
      )
   )
)

# Define server logic required to run simulations
server <- function(input, output) {
  y2018 <- read_csv("2018_Results_Adjusted.csv")
  y2019<- read_csv("2019_Results_Adjusted.csv")
  # Return the requested dataset
   datasetInput <- reactive({
     switch(input$dataset,
            "2018" = y2018,
            "2019" = y2019)
   })

   # Generate output
   output$simStats <- renderTable({
     #set.seed(11)
     sim_stats<-list()
     total_stats<-list()
     for(count in seq(1, input$sims)) {
       # Get the mean and sd for each individual
       individuals <- datasetInput() %>% group_by(NAME) %>%
         summarize(MEAN=mean(ADJ_TIME, na.rm=TRUE),
                   SD=sd(ADJ_TIME, na.rm = TRUE))
       # Add join this data back to the full data set
       teams <- left_join(individuals, datasetInput())
       teams <- distinct(teams, NAME, SD, MEAN, TEAM)
       
       # simulate time for each individual and add to the data frame
       sims <- teams %>% mutate(SIMTIME = rnorm(nrow(teams), teams$MEAN, teams$SD))
       
       # order and score the meet
       ordered_results_simulated <- sims %>% arrange(SIMTIME)
       ordered_results_simulated$SCORE = seq(1,nrow(ordered_results_simulated))
       team_scores <- arrange(ordered_results_simulated %>% group_by(TEAM) %>% 
                                summarize(TEAM_SCORE=sum(head(SCORE, 5))), TEAM_SCORE)
       
       # store results of meet in lists
       # first list looking at podium finishers only
       sim_stats[[count]]<-data.frame(TEAMS=team_scores$TEAM[1:4], PLACES=seq(1:4), SCORES=team_scores$TEAM_SCORE[1:4])
       # second list looking at all finishers
       total_stats[[count]]<-data.frame(TEAMS=team_scores$TEAM, PLACES=seq(1:length(team_scores$TEAM)), SCORES=team_scores$TEAM_SCORE)
     }
     # Turn our lists into data frames
     sim_stats = do.call(rbind, sim_stats)
     total_stats=do.call(rbind, total_stats)
     
     # Stats to output
     
     if (input$selectedTeam == "All"){
       total_stats %>% group_by(TEAMS) %>%
         summarize(AVERAGE_PLACE = mean(PLACES), AVERAGE_SCORE = mean(SCORES)) %>%
         arrange(AVERAGE_PLACE) %>% mutate(RANK = seq(1,32)) %>%
         select(RANK, TEAMS, AVERAGE_PLACE, AVERAGE_SCORE)
       
     } else{
       total_stats %>% group_by(TEAMS) %>% filter(TEAMS == input$selectedTeam) %>%
         summarize(Average_Place = mean(PLACES), Average_Score = mean(SCORES)) %>%
         arrange(Average_Place)
     }
     
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

