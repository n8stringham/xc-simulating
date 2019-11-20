# team-running

Group Members: Ethan Ashby, Danny Rosen, Nate Stringham
 
Title: Using Simulations to Determine How Well Different Programs "Peak"
 

Purpose: The ability of a program to peak its runners well at the end of the season is often what determines national champions. To determine how well programs peak their athletes, we will use simulations of cross country results to score a hypothetical "national meet". To run the simulation, we determine a "speed rating" for each athlete in the Divison at each meet. For each athlete, we maintain a vector of speed ratings from the current season, with more recent performances weighted more heavily than early season -- either we do this or we assume the performances are normally distributed and sample from a normal distribution with a variance calculated from our speed ratings. Then we sample from each athlete's vector and sort the athletes into a meet ranking, which we then score as a cross country meet. We compare the actual nationals result from that year to our simulated result to determine how well a team peaked. We can do this over a number of years to evaluate different programs. We assign a score to each program based on how consistently they peaked at the national meet and how far they exceeded our simulated expectation of their finish at the national meet. IF we have time we'll make a shiny app!
 


Data:

• TFRRS 



Trying to assess College Program Peaking Success

 
Potential end products:
 	-- List of teams ranked by how well they peaked each season.
	-- shiny app 
			
Warlock of Wrangling: Danny Rosen

Sultan of Statistical Analysis: Ethan Ashby 

Magister of Modeling: Nate Stringham

https://www.ncbi.nlm.nih.gov/pubmed/29291269/
https://www.researchgate.net/publication/332769237_World-Class_Long-Distance_Running_Performances_Are_Best_Predicted_by_Volume_of_Easy_Runs_and_Deliberate_Practice_of_Short-Interval_and_Tempo_Runs
 
Strava API
http://developers.strava.com/
 

