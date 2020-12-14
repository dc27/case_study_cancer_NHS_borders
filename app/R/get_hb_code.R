get_hb_code <- function(hb_string) {
  hb_code <- HB_lookup_tibble %>% 
    filter(hb_name == hb_string) %>% 
    select(hb) %>% 
    pull()
  return(hb_code)
}