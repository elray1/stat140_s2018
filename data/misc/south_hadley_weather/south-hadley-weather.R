### Code adapted from
### https://github.com/mine-cetinkaya-rundel/data-science-uscots-2017/blob/master/02-breakout/laquinta-dennys.Rmd

library(here)    # for ease in finding the files
library(rvest)   # for web scraping
library(dplyr)   # for data manipulation
library(stringr) # for string manipulation
library(purrr)   # for functional programming
library(readr)   # for CSV import/export


get_weather <- function(year){
  weather_url <- paste0(
    "https://www.wunderground.com/history/airport/KCEF/",
    year,
    "/1/1/CustomHistory.html?dayend=31&monthend=12&yearend=",
    year,
    "&req_city=&req_state=&req_statename=&reqdb.zip=&reqdb.magic=&reqdb.wmo=")
  
  weather_html <- read_html(weather_url)
  
  daily_weather <- weather_html %>%
    html_node("#obsTable") %>%
    html_table()
  colnames(daily_weather) <- c("day",
    "temp_high_F", "temp_avg_F", "temp_low_F",
    "dew_pt_high_F", "dew_pt_avg_F", "dew_pt_low_F",
    "humidity_high_pct", "humidity_avg_pct", "humidity_low_pct",
    "sea_level_press_high_in", "sea_level_press_avg_in", "sea_level_press_low_in",
    "visibility_high_mi", "visibility_avg_mi", "visibility_low_mi",
    "wind_high_mph", "wind_avg_mph", "wind_gust_high_mph",
    "precipitation_in", "events"
  )
  
  month_strs <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
  header_rows <- which(daily_weather[, 1]  %in% month_strs)
  
  num_obs_per_month <- c(header_rows[2:length(header_rows)], nrow(daily_weather) + 1) - header_rows
  daily_weather$year <- year
  daily_weather$month <- rep(month_strs[seq_along(num_obs_per_month)], num_obs_per_month)
  
  header_rows <- c(header_rows - 1, header_rows)
  daily_weather <- daily_weather[-header_rows, ]
  
  return(daily_weather)
}

daily_weather <- purrr::map_dfr(1941:2018, get_weather)
daily_weather$events <- gsub("\n\t,\n", ";", daily_weather$events)
for(col_ind in 1:20) {
  daily_weather[, col_ind] <- as.numeric(daily_weather[, col_ind])
}
write_csv(daily_weather, "daily_weather.csv")

yearly_weather <- daily_weather %>%
  group_by(year) %>%
  summarize(total_precipitation = sum(as.numeric(precipitation_in)))
write_csv(yearly_weather, "yearly_weather.csv")
