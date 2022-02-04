#### Preamble ####
# Purpose: Clean the Apartment Maintenance data downloaded from Open Data Toronto 
# Author: Olaedo Okpareke
# Data: 2 February 2022
# Contact: olaedo.okpareke@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have installed the opendatatoronto and tidyr packages. 
# - Gitignore it!
# - Change these to yours
# Any other information needed?


#### Workspace setup ####
# Use R Projects, not setwd().
library(opendatatoronto)
library(tidyverse)

# Read in the raw data.
apartment_data = list_package_resources("4ef82789-e038-44ef-a478-a8f3590c3eb1") %>%
  filter(name=="Apartment Building Evaluation") %>%
  get_resource()

# Cleaning the data by dropping NAs
apartment_data = na_if(apartment_data, 'N/A')

rent_data <- apartment_data[complete.cases(apartment_data), ]

# Keeping variables of interest
rent_clean<- rent_data %>% 
  dplyr::select(Score = SCORE,
                Ward = WARDNAME,
                Year_built = YEAR_BUILT,
                Type= PROPERTY_TYPE,
                Security = SECURITY
  )

# Changing variables into the proper variable types
rent_clean$Score = strtoi(rent_clean$Score)
rent_clean$Year_built = as.double(rent_clean$Year_built)
rent_clean$Security = as.double(rent_clean$Security)

# create data set from csv

write_csv(rent_clean, "inputs/data/rent_clean.csv")


         