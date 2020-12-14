health_boards <- sort(unique(HB_lookup_tibble$hb_name))
cancer_sites <- sort(unique(cancer_data_by_HB$cancer_site))
sexes <- sort(unique(cancer_data_by_HB$sex))

ui <- dashboardPage(
  dashboardHeader(
    title = "Cancer Incidence in Scotland",
    titleWidth = 450
  ),
  dashboardSidebar(
    disable = TRUE
  ),
  dashboardBody(
    selectInput(inputId = "health_board_choice",
                label = "Health Board:",
                choices = health_boards,
                selected = "NHS Borders"),
    textOutput("hb_code"),
    selectInput(inputId = "cancer_site_choice",
                label = "Cancer Site:",
                choices = cancer_sites,
                selected = "All cancer types"),
    selectInput(inputId = "sex_choice",
                label = "Sex:",
                choices = sexes,
                selected = "All"),
    plotOutput("basic_plot")
  )
)