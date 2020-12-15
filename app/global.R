library(shiny)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(rgdal)
library(sf)

cancer_data_all_scotland <-
  read_csv("../data/raw_data/cancer_data_all_Scot.csv") %>% 
  janitor::clean_names()

cancer_data_by_HB <-
  read_csv("../data/clean_data/cancer_data_by_HB_clean.csv") %>% 
  janitor::clean_names()

HB_lookup_tibble <-
  read_csv("../data/raw_data/geo_HB_labels_lookup.csv") %>% 
  janitor::clean_names()

hb_shapes <- readOGR(
  dsn ="../data/shapefiles/SG_NHS_HealthBoards_2019/",
  layer = "SG_NHS_HealthBoards_2019",
  GDAL1_integer64_policy = TRUE)

crs <- CRS("+proj=longlat +datum=WGS84")

# transform shape data to plot on map
hb_shapes_ll <- hb_shapes %>% 
  rgeos::gSimplify(tol=25, topologyPreserve=TRUE) %>% 
  spTransform(crs)

hb_shapes@polygons <- hb_shapes_ll@polygons