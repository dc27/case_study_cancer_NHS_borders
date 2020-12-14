source("R/get_hb_code.R")
source("R/filter_cancer_data.R")
source("R/make_line_plot.R")

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
      make_line_plot(filtered_cancer_data())
    )
}