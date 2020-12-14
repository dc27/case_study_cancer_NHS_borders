library(shiny)
library(shinydashboard)
library(tidyverse)

cancer_data_all_scotland <-
  read_csv("../data/raw_data/cancer_data_all_Scot.csv") %>% 
  janitor::clean_names()

cancer_data_by_HB <-
  read_csv("../data/raw_data/cancer_data_by_HB.csv") %>% 
  janitor::clean_names()

HB_lookup_tibble <-
  read_csv("../data/raw_data/geo_HB_labels_lookup.csv") %>% 
  janitor::clean_names()