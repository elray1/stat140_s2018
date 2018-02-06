library(tidyverse)
setwd("C:/Users/eray/Documents/teaching/2018-spring-stat140/stat140_s2018/data/sdm4")

cloud_seeding <- read_csv("Cloud_seeding.csv") %>%
  gather("treatment", "rainfall_amount", Unseeded_Clouds, Seeded_Clouds)

cloud_seeding$treatment[cloud_seeding$treatment == "Unseeded_Clouds"] <- "unseeded"
cloud_seeding$treatment[cloud_seeding$treatment == "Seeded_Clouds"] <- "seeded"

write.csv(cloud_seeding, "Cloud_seeding_long.csv", row.names = FALSE)
