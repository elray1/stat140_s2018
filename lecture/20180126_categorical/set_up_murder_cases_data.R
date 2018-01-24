library(tidyverse)

set.seed(1234)

murder_cases <- rbind(
  expand.grid(
    case_id = seq_len(2139),
    offender_race = "black",
    victim_race = "black",
    sentence = "jail",
    stringsAsFactors = FALSE
  ),
  expand.grid(
    case_id = seq_len(12),
    offender_race = "black",
    victim_race = "black",
    sentence = "death",
    stringsAsFactors = FALSE
  ),
  expand.grid(
    case_id = seq_len(100),
    offender_race = "white",
    victim_race = "black",
    sentence = "jail",
    stringsAsFactors = FALSE
  ),
  expand.grid(
    case_id = seq_len(0),
    offender_race = "white",
    victim_race = "black",
    sentence = "death",
    stringsAsFactors = FALSE
  ),
  expand.grid(
    case_id = seq_len(359),
    offender_race = "black",
    victim_race = "white",
    sentence = "jail",
    stringsAsFactors = FALSE
  ),
  expand.grid(
    case_id = seq_len(16),
    offender_race = "black",
    victim_race = "white",
    sentence = "death",
    stringsAsFactors = FALSE
  ),
  expand.grid(
    case_id = seq_len(2223),
    offender_race = "white",
    victim_race = "white",
    sentence = "jail",
    stringsAsFactors = FALSE
  ),
  expand.grid(
    case_id = seq_len(49),
    offender_race = "white",
    victim_race = "white",
    sentence = "death",
    stringsAsFactors = FALSE
  )
)

murder_cases <- murder_cases %>%
  mutate(case_id = sample(seq_len(nrow(murder_cases))),
         offender_race = factor(offender_race),
         victim_race = factor(victim_race),
         sentence = factor(sentence)) %>%
  arrange(case_id)

write_csv(murder_cases, "lecture/20180126_categorical/murder_cases.csv")
