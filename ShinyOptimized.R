
####Now create split dataframe where each index is a runner and their races are included
#split_results<-split(filtered_results, f=filtered_results$NAME, drop=TRUE)

set.seed(11)
sim_stats<-list()
total_stats<-list()
filtered_results <- read.csv("2019_Results_Adjusted.csv")
results2018 <- read.csv("2018_Results_Adjusted.csv")

for(count in seq(1, 10)) {
  # Get the mean and sd for each individual
  individuals <- results2018 %>% group_by(NAME) %>%
    summarize(MEAN=mean(ADJ_TIME, na.rm=TRUE),
                        SD=sd(ADJ_TIME, na.rm = TRUE))
  # Add join this data back to the full data set
  teams <- left_join(individuals, results2018)
  teams <- distinct(teams, NAME, SD, MEAN, TEAM)
  
  # simulate time for each individual and add to the data frame
  sims <- teams %>% mutate(SIMTIME = rnorm(nrow(teams), teams$MEAN, teams$SD))
  ordered_results_simulated <- sims %>% arrange(SIMTIME)
  ordered_results_simulated$SCORE = seq(1,nrow(ordered_results_simulated))
  
  team_scores <- arrange(ordered_results_simulated %>% group_by(TEAM) %>% 
                           summarize(TEAM_SCORE=sum(head(SCORE, 5))), TEAM_SCORE)
  
  sim_stats[[count]]<-data.frame(TEAMS=team_scores$TEAM[1:4], PLACES=seq(1:4), SCORES=team_scores$TEAM_SCORE[1:4])
  
  total_stats[[count]]<-data.frame(TEAMS=team_scores$TEAM, PLACES=seq(1:length(team_scores$TEAM)), SCORES=team_scores$TEAM_SCORE)
}

sim_stats = do.call(rbind, sim_stats)

total_stats=do.call(rbind, total_stats)