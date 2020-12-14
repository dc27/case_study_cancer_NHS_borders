filter_cancer_data <- function(data, userIn_hb_code, userIn_cancer_site, userIn_sex) {
  data %>% 
    filter(hb == userIn_hb_code) %>% 
    filter(cancer_site == userIn_cancer_site()) %>% 
    filter(sex == userIn_sex())
}