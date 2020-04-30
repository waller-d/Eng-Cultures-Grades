library(tidyverse)
library(midfielddata)
library(midfieldr)
library(knitr)
library(seplyr)

terms <- read_csv("~/Dropbox (MIDFIELD)/MIDFIELD data 16 March 2020/data files/CSV (utf-8 Unicode) files/term_2020_03_16_fix5.csv")
students <- read_csv("Dropbox (MIDFIELD)/MIDFIELD data 16 March 2020/data files/CSV (utf-8 Unicode) files/student_2020_03_16_fix5.csv", 
                     + col_types = cols(transfer_institution_code = col_character()))
degrees <- read_csv("Dropbox (MIDFIELD)/MIDFIELD data 16 March 2020/data files/CSV (utf-8 Unicode) files/degree_2020_03_16_fix5.csv", 
                    + col_types = cols(term_degree = col_character()))
courses <- read_csv("Dropbox (MIDFIELD)/MIDFIELD data 16 March 2020/data files/CSV (utf-8 Unicode) files/course_2020_03_16_fix5.csv", 
                                   + col_types = cols(number = col_character(), 
                                   + term_course = col_character()))

# Filter for First-Time in College students
ftc <- students %>%
  filter(transfer=="First-Time in College")

# Create vector of cip6 codes for the programs of interest
cip_filter(series = "Engineering") %>%
  cip_filter(series = c("Chemical","Civil", "Electrical", "Industrial", "Mechanical", "Computer"), reference = .) %>% 
  print(., n=nrow(.))
programs <- cip_filter(series = c("^1407","^1408","^1410","^1419","^1435"))

# Filter for the courses of interest


# Filter for degrees awarded in the programs of interest for First-Time in College students
# This data frame will be used for the "all students graduating in the major" time point
graduating <- inner_join(ftc,degrees,by="mcid") %>%
  filter(cip6.y %in% programs$cip6)

