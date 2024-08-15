## app.R ##
library(shinydashboard)
library(sf)
library(urbnmapr) #Citation: https://github.com/UrbanInstitute/urbnmapr
library(tidyverse)
library(readr)
library(mapview)
aclu_wide <- read_csv("data/aclu_wide_APP.csv")

ui <- dashboardPage(
  skin = "black",
  dashboardHeader(title = "2023 Anti-LGBTQ Legislation", titleWidth = 450),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Interactive Map", tabName = "dashboard", icon = icon("map"))
    )
  ),
  dashboardBody(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
                box(
                  title = "Topic of Legislation",
                  selectInput("select", label = HTML('<h3 style="font-size: 14px;">Select a topic:</h3>'),
                               choices = list("Restricting Student & Educator Rights" = 1, 
                                              "Healthcare Restrictions" = 2,
                                              "Other Anti-LGBTQ Bills" = 3,
                                              "Healthcare Age Restrictions" = 4,
                                              "Other School Restrictions" = 5,
                                              "Free Speech & Expression Bans" = 6,
                                              "Curriculum Censorship" = 7,
                                              "Forced Outing in Schools" = 8,
                                              "School Sports Bans" = 9,
                                              "Weakening Civil Rights Laws" = 10,
                                              "Religious Exemptions" = 11,
                                              "Drag Bans" = 12,
                                              "Barriers to Accurate IDs" = 13,
                                              "School Facilities Bans" = 14,
                                              "Other Healthcare Barriers" = 15,
                                              "Public Accommodation Bans" = 16,
                                              "Healthcare Funding Restrictions" = 17,
                                              "Other Civil Rights Restrictions" = 18), selected = 1)),
              fluidRow(
                box(plotOutput("plot1", height = 750), width = 12)
                )
              )
      ),
      
    )
  )


# Combining data manipulation and graph creation into a single function
server <- function(input, output) {
  
  # Plot on a map
  output$plot1 <- renderPlot({
    
    input_radio_as_int <- strtoi(input$select)
    
    print(paste("Selected input:", input_radio_as_int))
    
    # Sort by topic
    column_names <- c("restr_stud_and_ed_rights", 
                      "healthcare_restrictions", 
                      "other_antilgbtq_bills", 
                      "healthcare_age_restrictions",
                      "other_school_restrictions",
                      "free_speech", 
                      "curriculum_censorship", 
                      "forced_outing_in_schools", 
                      "school_sports", 
                      "weakening_civil_rights_laws",
                      "religious_exemptions",
                      "drag_bans",
                      "barriers_to_accurate_IDs",
                      "school_facilities_ban",
                      "other_healthcare_barriers",
                      "public_accommodation_bans",
                      "healthcare_funding_restrictions",
                      "other_civil_rights_restrictions")
    print(paste("Column names:", column_names))
    
    # Select the column based on input_integer
    selected_column <- if(input_radio_as_int >= 1 && input_radio_as_int <= length(column_names)) {
      column_names[input_radio_as_int]
      
    } else {
      NA
    }
    
    #print(paste("Selected column:", selected_column))
    #print(paste("Selected column TYPE:", class(selected_column)))
    
    # Filter dataset
    filtered_data <- aclu_wide[aclu_wide[[selected_column]] == 1, ]
    
    #print(paste("Selected column:", filtered_data))
    
    # Group by state, count up bills introduced per state
    aclu_state_row_count <- filtered_data %>%
      group_by(state) %>%
      summarise(bills_intro_per_state = n())
    
    # Rename "state_name" to "state" to prepare for merge
    aclu_state_row_count <- aclu_state_row_count %>%
      rename(state_name = state)
    
    # Recreating object with a recent sf::st_crs()
    map_data <- get_urbn_map(map = "states", sf = TRUE)
    map_og_crs <- st_crs(map_data)$epsg
    map_new_crs <-st_set_crs(map_data, map_og_crs)
    
    # Create dataset of 1 row per state, with # of introduced bills per state
    spatial_data <- left_join(map_new_crs,
                              aclu_state_row_count,
                              by = "state_name")
    
    # Create a categorical variable
    spatial_data <- spatial_data %>%
      mutate(cat_var = case_when(
        bills_intro_per_state == 0 ~ 1,
        bills_intro_per_state > 0 & bills_intro_per_state < 5 ~ 2,
        bills_intro_per_state >= 5 & bills_intro_per_state < 10 ~ 3,
        bills_intro_per_state >= 10 & bills_intro_per_state < 15 ~ 4,
        bills_intro_per_state > 15 ~ 5,
      ))
    
    ccdf_labels <- get_urbn_labels(map = "ccdf")
    
    ggplot(data = spatial_data) +
    geom_sf(mapping = aes(fill = factor(cat_var)),
            color = "#ffffff", size = 0.25) +
    scale_fill_manual(values = c("1" = "#E6B0AA", "2" = "#CD6155", "3" = "#A93226", "4" = "#922B21", "5" = "#641E16"),
                      na.value = "#bcbcbc",
                      labels = c("1" = "0 bills",
                                 "2" = "1-4 bills",
                                 "3" = "5-9 bills",
                                 "4" = "10-14 bills",
                                 "5" = ">15 bills"),
                      name = "Bills introduced per state") +
    labs(fill = "Bills introduced per state", caption="Source: ACLU") +
    #geom_text(data = ccdf_labels, aes(long, lat, label = state_abbv), size = 3) +  
    theme_minimal(base_size = 12) + 
    theme(legend.position = "bottom", plot.caption=element_text(size = 9)) + 
    coord_sf(datum = NA)
    })
}

shinyApp(ui, server)
