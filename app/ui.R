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
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
      tags$link(rel = "preconnect", href="https://fonts.gstatic.com"),
      tags$link(rel = "stylesheet",
                href ="https://fonts.googleapis.com/css2?family=Montserrat&display=swap")
    ),
    fluidRow(
      box(
        width = 3,
        title = "Inputs",
        solidHeader = TRUE,
        status = "primary",
        conditionalPanel(
          condition = "output.graph_tab",
          selectInput(
            inputId = "health_board_choice",
            label = "Health Board:",
            choices = health_boards,
            selected = "NHS Borders"
          )
        ),
        
        conditionalPanel(
          condition = "output.map_tab",
          selectInput(
            inputId = "year_choice",
            label = "Select Year:",
            choices = years,
            selected = "2008"
          )
        ),
        
        tags$hr(),
        selectInput(
          inputId = "cancer_site_choice",
          label = "Cancer Site:",
          choices = cancer_sites,
          selected = "All cancer types"
        ),
        
        selectInput(
          inputId = "sex_choice",
          label = "Sex:",
          choices = sexes,
          selected = "All"
        ),
        
        conditionalPanel(
          condition = "output.graph_tab",
          checkboxGroupInput(
            inputId = "measurement_choice",
            label = "Select Measurement(s):",
            choices = measurement_types,
            select = "CRUDE"
          )
        ),
        # only show when map is selected
        conditionalPanel(
          condition = "output.map_tab",
          radioButtons(
            inputId = "measurement_choice_radio",
            label = "Select Measurement:",
            choices = measurement_types,
            select = "CRUDE"
          ),
          tags$hr(),
          tags$div(id = "action_button",
          actionButton("replot_map", "Update Map"))
        )
      ),
      tabBox(
        id = "mainPanel",
        width = 9,
        height = "80%",
        tabPanel(
          "Plot",
          value = "plot",
          plotOutput("basic_plot", height = "100%")
        ),
        tabPanel(
          "Map",
          value = "map",
          leafletOutput("cancer_stats_map", height = "100%")
        )
      )
    )
  )
)