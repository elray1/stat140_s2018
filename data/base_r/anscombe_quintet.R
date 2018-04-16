library(readr)
library(dplyr)

set.seed(1)
anscombe$x5 <- anscombe$x1
anscombe$y5 <- rnorm(n = nrow(anscombe), mean = 3 + 0.5 * anscombe$x1, sd = 0.2 * anscombe$x1)

anscombe[, c("x5", "y5")]

anscombe$y5[3] <- anscombe$y5[3] + 0.15
anscombe$y5[4] <- anscombe$y5[4] - 1.5
anscombe$y5[5] <- anscombe$y5[5] - 1.5
anscombe$y5[6] <- anscombe$y5[6] + 4
anscombe$y5[8] <- anscombe$y5[8] - 0.5
anscombe$y5[9] <- anscombe$y5[9] + 0.2
anscombe$y5[10] <- anscombe$y5[10] + 0.4
anscombe$y5[11] <- anscombe$y5[11] - 1.5
anscombe$y5 <- anscombe$y5 - 0.15
summary(lm(anscombe$y1 ~ anscombe$x1))
summary(lm(anscombe$y5 ~ anscombe$x5))
#plot(anscombe$y5 ~ anscombe$x5)

ggplot(data = anscombe, mapping = aes(x = x5, y = y5)) + geom_point() + geom_smooth(method = "lm", se = FALSE)

anscombe <- anscombe %>%
  select(
    x1, x2, x3, x4, x5, y1, y2, y3, y4, y5
  )

write_csv(anscombe, "anscombe_quintet.csv")
