source("R/get_hb_code.R")
source("R/filter_cancer_data.R")
source("R/make_line_plot.R")
source("R/filter_data_for_map.R")
source("R/create_chloro_map.R")

server <- function(input, output) {
  hb_code <- reactive(
    get_hb_code(
      hb_string = input$health_board_choice
    )
  )
  
  filtered_cancer_data <- reactive(
    filter_cancer_data(
      data = cancer_data_by_HB,
      userIn_hb_code = hb_code(),
      userIn_cancer_site = reactive(input$cancer_site_choice),
      userIn_sex = reactive(input$sex_choice)
    )
  )
  
  output$basic_plot <-
      renderPlot(
        if (length(input$measurement_choice)>0) {
        create_line_plot(filtered_cancer_data(),
                       measurements = reactive(input$measurement_choice))
    } else {
      ggplot() +
        theme_bw()
    })
  filtered_cancer_data_for_map <- reactive(
    filter_cancer_data_for_map(
      data = cancer_data_by_HB,
      userIn_cancer_site = reactive(input$cancer_site_choice),
      userIn_sex = reactive(input$sex_choice),
      userIn_metric = reactive(input$measurement_choice_radio),
      userIn_year = reactive(input$year_choice)
    )
  )
  
  output$cancer_stats_map <-
    renderLeaflet(
      create_chloro_map(filtered_cancer_data_for_map())
    )
}