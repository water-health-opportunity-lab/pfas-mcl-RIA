################################################################################
# primary author: jahred liddie
# purpose: load and process CWS data
# date created: 4/8/2026
################################################################################
library(tidycensus)
library(sf)
library(tidyverse)

# this is based on v4.0 of the PFAS Statewide Sampling dataset:
  # repository and details here: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/8LPLCF
sample_data <- read.csv("data/PFAS_water_data/dat.csv")

################################################################################

CWS_counties <- tibble(abbr = sample_data$State, state_county = sample_data$counties_served)

CWS_counties <- CWS_counties[!duplicated(CWS_counties),]

CWS_counties <- separate_longer_delim(CWS_counties, cols = state_county, delim = ",")

CWS_counties <- CWS_counties %>%
  filter(tolower(state_county) != "not reported") %>%
  rename(county = state_county) %>%
  mutate(state_county = tolower(paste(abbr, county, sep = "_")))

all_states <- tigris::states()
all_states <- st_drop_geometry(all_states)
all_states <- all_states %>%
  filter(STUSPS %in% CWS_counties$abbr) %>%
  dplyr::select(REGION, DIVISION, STATEFP, STUSPS)

all_counties <- tigris::counties(state = unique(CWS_counties$abbr))

all_counties <- left_join(all_counties, all_states, by = "STATEFP")

all_counties <- all_counties %>%
  mutate(state_county = tolower(paste(STUSPS, NAME, sep = "_"))) %>%
  mutate(PFAS_data = state_county %in% CWS_counties$state_county)

# note: Baltimore City, MD and St. Louis City, MO are technically independent
  # from their eponymous county boundaries. These are listed
  # separately in the drinking water/SDWIS data. We will need to check how this is 
  # handled in the data from CDC Wonder.
table(all_counties$PFAS_data) # plus Baltimore City and St Louis City

################################################################################

PFAS_data_county_summary <- all_counties %>%
  st_drop_geometry() %>%
  group_by(STUSPS) %>%
  summarise(n_covered = sum(PFAS_data),
            perc_counties_covered = sum(PFAS_data)/n()) %>%
  ungroup()

# Lowest coverage for: TN, IN, GA, UT, KY, and WI (<50%)
  # although ultimately this depends on coverage/overlap w/ CDC Wonder

# TODO: check reported population served vs total county population

# also TODO: load processed CDC Wonder data and merge