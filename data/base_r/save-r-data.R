library(readr)

write_csv(anscombe, "anscombe.csv")

names(faithful) <- c("eruption_duration_min", "time_to_next_eruption_min")
write_csv(faithful, "faithful.csv")

LakeHuron <- data.frame(
  year = seq(from = 1875, to = 1972),
  water_level = LakeHuron
)
write_csv(LakeHuron, "lake_huron.csv")
