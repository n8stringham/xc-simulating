# team-running

Group Members: Ethan Ashby, Danny Rosen, Nate Stringham
 
Title: Predicting Distance Running Success in College
 
Purpose: Recruiting is a cornerstone of building a successful athletic team on the collegiate level. However, NCAA coaches often assume that athletic success in high school will translate onto the collegiate level, but due to differences in maturation rates, issues related to injuries/burnout, adaptation to a new living/training environment, and many more factors, many high school athletes overperform or underperform relative to their high school achievements. Distance running poses a unique data-driven opportunity, predictive modeling of collegiate success from high school athletic background: “success” is quantifiable by race times or places, and training data is readily available through online applications like Strava (an online training log) and TFRRS (a database of collegiate race results). Thus, finding a way to better predict collegiate success from high school achievements could aid NCAA cross country coaches in their recruiting efforts and help construct better, championship-contending programs. 

Data:
• Collegiate Success Data- nationals start list (html, available on NCAA website), TFRRS (html, maybe .csv downloads), Tully Speed Ratings (for comparing performances across courses)

• Collegiate Racing Data- Athletic.net (?), TFRRS (?)

• High school training/location/mentality (?) Data- Strava (?)
Weather - https://www.climate.gov/maps-data/dataset/past-weather-zip-code-data-table
Air quailty/air pollution

Variables (to consider):
Trying to predict: collegiate success (qualifying for nationals, place at nationals, times)
Predictors:
·      High school times/speed ratings
·      Places at high profile high school meets
·      School (program may over/undertrain athletes)
·      Level of competition- running in competitive California meets or are they the fastest kid in their small Midwest town?
·      Geography- where they lived in HS & where they live & train now
 
Potential end products:
 	-- build a classifier (random forest, bayesian classifier?) of NCAA qualifiers
		--input variables 
			--high school times/speed ratings
				--800, 1600, 3200 , avg speed rating from senior season
				-- junior season progression?
			--places in high profile races
			--state 
			--”competition coefficient” - quality of races
			-- weather (avg temp, humidity, air quality, etc)
		--output
			--whether or not they qualify for nationals in XC/Track
			--likelihood of qualifying?
	-- shiny app 
			

https://www.ncbi.nlm.nih.gov/pubmed/29291269/
https://www.researchgate.net/publication/332769237_World-Class_Long-Distance_Running_Performances_Are_Best_Predicted_by_Volume_of_Easy_Runs_and_Deliberate_Practice_of_Short-Interval_and_Tempo_Runs
 
Strava API
http://developers.strava.com/
 

