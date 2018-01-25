library(tidyverse)

NHANES_subset <- NHANES %>%
  filter(SurveyYr == "2011_12") %>%
  select(ID, Gender, Age, Race3, Education, MaritalStatus, HHIncome, Poverty, Weight, Length, Height, Diabetes, nPregnancies, nBabies, PregnantNow)
colnames(NHANES_subset)[4] <- "Race"

write_csv(NHANES_subset, "lecture/20180125_intro_to_r/nhanes.csv")

