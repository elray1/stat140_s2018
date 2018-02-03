library(readr)

write_csv(anscombe, "anscombe.csv")

names(faithful) <- c("eruption_duration_min", "time_to_next_eruption_min")
write_csv(faithful, "faithful.csv")

