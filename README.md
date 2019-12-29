# team-running

Group Members: Ethan Ashby, Danny Rosen, Nate Stringham
 
Title: Simulating a NCAA DIII National Cross Country Meet

Goal: Use simulations of the national meet to assess how well different college programs "peak"
 

Background and Method: The ability of a program to peak its runners well at the end of the season is often what determines national champions. To determine how well programs peak their athletes, we will use simulations of cross country results to score a hypothetical "national meet". To run the simulation, we first standardize the times run at various races  leading up to the national meet for each athlete on a qualifying team. These adjusted times from the current season are used to create a normal distribution for each athlete; then, to simulate a national meet we simply sample from each athlete's distribution to get their national meet performance, sort the athletes into a meet ranking, and score the results as a cross country meet. We compare the actual nationals result from that year to our simulated result to determine how well a team peaked. We can do this over a number of years to evaluate different programs. We assign a score to each program based on how consistently they peaked at the national meet and how far they exceeded our simulated expectation of their finish at the national meet. IF we have time we'll make a shiny app!
 
Data:
All race data obtained from https://tfrrs.org/

Check out our simulation applet at https://n8stringham.shinyapps.io/CrossCountry_Simulator

			



