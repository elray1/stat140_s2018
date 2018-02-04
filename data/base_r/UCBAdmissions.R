library(plyr)
library(dplyr)
library(mosaic)

set.seed(1)

## R's UCBAdmissions data set comes in the form of a 3d array, which is inconvenenient
## Turn it into a 2d data frame
UCBAdmissions_df <-
  expand.grid(
    Admit = c("Admitted", "Rejected"),
    Gender = c("Male", "Female"),
    Dept = LETTERS[1:6]
  ) %>%
  mutate(
    count = as.vector(UCBAdmissions)
  )

## Convert to a data frame with individual-level rows
UCBAdmissions_individual <- rbind.fill(
  lapply(seq_len(nrow(UCBAdmissions_df)), function(row_ind) {
    data.frame(
      Admit = UCBAdmissions_df[row_ind, "Admit"],
      Gender = UCBAdmissions_df[row_ind, "Gender"],
      Dept = UCBAdmissions_df[row_ind, "Dept"],
      applicant_id = as.character(seq_len(UCBAdmissions_df[row_ind, "count"])), # just a place holder to get the right number of entries
      stringsAsFactors = FALSE
    )
  })
)

## Unique applicant ids in a random order, so that head(UCBAdmissions_individual) looks interesting
UCBAdmissions_individual$applicant_id <- shuffle(seq_len(nrow(UCBAdmissions_individual)))
UCBAdmissions_individual <- UCBAdmissions_individual[order(UCBAdmissions_individual$applicant_id), ]

## verify that we have the right answer
all.equal(UCBAdmissions,
          tally(Admit ~ Gender | Dept, data = UCBAdmissions_individual)
)

## rename/reorder columns and save to csv
colnames(UCBAdmissions_individual) <- tolower(colnames(UCBAdmissions_individual))
UCBAdmissions_individual <- UCBAdmissions_individual[, c("applicant_id", "dept", "gender", "admit")]
write.csv(UCBAdmissions_individual, file = "UCBAdmissions.csv", row.names = FALSE)
