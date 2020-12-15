filter_cancer_data_for_map <-
  function(data, userIn_cancer_site, userIn_sex, userIn_year, userIn_metric) {
  data %>% 
    filter(cancer_site == userIn_cancer_site()) %>% 
    filter(sex == userIn_sex()) %>% 
    filter(measurement == userIn_metric()) %>% 
    filter(year == userIn_year())
}