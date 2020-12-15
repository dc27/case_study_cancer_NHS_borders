library(tidyverse)
library(rgdal)

# read in data and clean column names
cancer_data_by_HB <- read_csv("data/raw_data/cancer_data_by_HB.csv") %>% 
  janitor::clean_names()

# remove unused column, add index column, collapse measurement and confidence
# interval columns
cancer_data_tidy <- cancer_data_by_HB %>% 
  select(-cancer_site_icd10code) %>%
  mutate(group = row_number()) %>% 
  rename(sir = standardised_incidence_ratio) %>% 
  pivot_longer(cols = -c(hb:incidences_all_ages,
                         easr_lower95pc_confidence_interval_qf,
                         easr_upper95pc_confidence_interval_qf,
                         wasr_lower95pc_confidence_interval_qf,
                         wasr_upper95pc_confidence_interval_qf,
                         group),
               names_pattern = "([^_]*)([_a-z0-9$]*)",
               names_to = c("measurement", "limit")) %>%
  mutate(limit = recode(limit, "_rate" = "")) %>% 
  mutate(limit = case_when(
    str_detect(limit, "lower") ~ "lower_95pc_c_i",
    str_detect(limit, "upper") ~ "upper_95pc_c_i",
    limit == "" ~ "value",
    TRUE ~ limit)
  ) %>% 
  pivot_wider(id_cols = -c(limit,value), names_from = limit,
              values_from = value, names_repair = "check_unique") %>% 
  mutate(measurement = str_to_upper(measurement))

# remove low incidence data - not enough information for confidence interval.
# remove information columns as no longer relevant (they now all contain NA)
cancer_data_tidy <- cancer_data_tidy %>% 
  filter(incidences_all_ages > 20) %>% 
  select(-easr_lower95pc_confidence_interval_qf,
         -easr_upper95pc_confidence_interval_qf,
         -wasr_lower95pc_confidence_interval_qf,
         -wasr_upper95pc_confidence_interval_qf,
         -sex_qf)

# write clean data to new csv
cancer_data_tidy %>% 
  write_csv("data/clean_data/cancer_data_by_HB_clean.csv")

hb_shapes <- readOGR(
  dsn ="data/shapefiles/SG_NHS_HealthBoards_2019/",
  layer = "SG_NHS_HealthBoards_2019",
  GDAL1_integer64_policy = TRUE)

crs <- CRS("+proj=longlat +datum=WGS84")

# transform shape data to plot on map
hb_shapes_ll <- hb_shapes %>% 
  rgeos::gSimplify(tol=10, topologyPreserve=TRUE) %>% 
  spTransform(crs)

hb_shapes@polygons <- hb_shapes_ll@polygons

writeOGR(
  obj = hb_shapes,
  dsn = "data/clean_data/shapefiles/NHS_HealthBoards_2019/",
  layer = "NHS_HealthBoards_2019",
  driver = "ESRI Shapefile",
  overwrite_layer = TRUE
)
