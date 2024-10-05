# Check for null values

all_data |> summarise_all(~ sum(is.na(.)))

# Check how many types of bikes there are

all_data |> group_by(rideable_type) |> 
  summarize(distinct_amount = n_distinct(rideable_type))

# Check how many member types there are

all_data |> group_by(member_casual) |> 
  summarize(distinct_amount = n_distinct(member_casual))

# Check if all ride_id have the same length

all_data |> group_by(length(ride_id)) |> 
  summarize(distinct_length = n_distinct(length(ride_id)))

# Check if all ride_id are distinct and clean them

nrow(all_data)
all_data |> summarize(distinct = n_distinct(ride_id))

# Data Processing

clean_data <- all_data |> distinct(ride_id, .keep_all = TRUE)

clean_data <- clean_data |> 
  select(!(start_station_name:start_station_id)) |> 
  mutate(ride_length = difftime(ended_at, started_at, units="mins"), day_of_week = weekdays(started_at)) |> 
  filter(!is.na(end_station_id) | !is.na(end_station_name))

view(clean_data)

clean_data <- clean_data |> filter(ride_length < 1440)

# Sampling the data with 99% accuracy and 1% margin
sample_all_data = sample_n(clean_data, 16589)
view(sample_all_data)

# Export data
write.csv(sample_all_data, file="sample_all_data.csv", row.names = FALSE)