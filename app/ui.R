health_boards <- sort(unique(HB_lookup_tibble$hb_name))
cancer_sites <- sort(unique(cancer_data_by_HB$cancer_site))
sexes <- sort(unique(cancer_data_by_HB$sex))
measurement_types <- sort(unique(cancer_data_by_HB$measurement))
years <- sort(unique(cancer_data_by_HB$year))

ui <- dashboardPage(
  dashboardHeader(
    title = "Cancer Incidence in Scotland",
    titleWidth = 450
  ),
  dashboardSidebar(
    disable = TRUE
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    fluidRow(
      box(
        width = 3,
        title = "Inputs",
        solidHeader = TRUE,
        status = "primary",
        selectInput(inputId = "health_board_choice",
                    label = "Health Board:",
                    choices = health_boards,
                    selected = "NHS Borders"),
        tags$hr(),
        selectInput(inputId = "cancer_site_choice",
                    label = "Cancer Site:",
                    choices = cancer_sites,
                    selected = "All cancer types"),
        selectInput(inputId = "sex_choice",
                    label = "Sex:",
                    choices = sexes,
                    selected = "All"),
        checkboxGroupInput(inputId = "measurement_choice",
                    label = "Select Measuremtnt(s):",
                    choices = measurement_types,
                    select = "CRUDE"),
        selectInput(inputId = "year_choice",
                    label = "Select Year:",
                    choices = years,
                    selected = "2008"),
        radioButtons(inputId = "measurement_choice_radio",
                     label = "Select Measuremtnt(s):",
                     choices = measurement_types,
                     select = "CRUDE")
      ),
      tabBox(
        id = "mainPanel",
        width = 9,
        height = "100%",
        tabPanel(
          "Plot",
          value = "plot",
          plotOutput("basic_plot")
        ),
        tabPanel(
          "Map",
          value = "map",
          leafletOutput("cancer_stats_map")
        )
      )
    )
  )
)