require(readr)
require(tidyr)
require(dplyr)
require(ggplot2)
require(knitr)
require(mvtnorm)

options(digits=4)

setwd("~/teaching/2018-spring-stat140/stat140_s2018/lecture/20180419_regression_inference/")

horses <- read_csv("https://mhc-stat140-2017.github.io/data/sdm4/Wild_Horses.csv")
head(horses)
nrow(horses)

png("sample.png", width = 4.25, height = 3, units = "in", res = 600)

ggplot() +
  geom_point(mapping = aes(x = Adults, y = Foals), color = "red", data = horses) +
  xlim(c(20, 280)) +
  ylim(c(-5, 50))

dev.off()

lm_fit <- lm(Foals ~ Adults, data = horses)

N <- 3 * nrow(horses)

set.seed(1)
population_coeffs <- c(-1, 0.138)

horses_population <- data.frame(
  Adults = runif(n = N, 25, 270)
)
horses_population$Foals <-
  population_coeffs[1] + population_coeffs[2] * horses_population$Adults + rnorm(N, mean = 0, sd = summary(lm_fit)$sigma)
horses_population$In_Sample = FALSE
horses_population <- bind_rows(horses_population,
  transmute(horses,
    Adults = Adults,
    Foals = Foals,
    In_Sample = TRUE)
)

png("population.png", width = 4.25, height = 3, units = "in", res = 600)

ggplot() +
  geom_point(mapping = aes(x = Adults, y = Foals), data = horses_population) +
  xlim(c(20, 280)) +
  ylim(c(-5, 50))

dev.off()
