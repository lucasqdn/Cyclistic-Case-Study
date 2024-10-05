library(tidyverse)
all_data <- list.files(path = "~/Developer/Google Data Analytics Professional Certificate/Case Study #1/Data",
                       pattern = "*.csv", full.names = TRUE) |> 
  lapply(read_csv) |> 
  bind_rows()

write.csv(all_data, file="all_data_raw.csv", row.names = FALSE)