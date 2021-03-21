#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(tidyverse)
library(rsconnect)
library(shiny)
rsconnect::setAccountInfo(name="ggabija",
                          token="7381295786ABC878926A2D1F81C55A8E",
                          secret="wvrd94DYrEXYvMStRBahie7yfedGAXofZ+mi3q9w")

# Define UI for application that draws a histogram
ui <- fluidPage(sidebarLayout(
  sidebarPanel(textInput("imones_kodas", "Imones kodas", value = "")), 
  mainPanel(tabsetPanel(
    tabPanel("grafikas", plotOutput("plot")), 
    tabPanel("lentele", tableOutput("table"))
        )
    )
))

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  data <- read.csv("../../data/lab_sodra.csv")
  output$table <- renderTable(
    data %>% filter(jarCode == input$imones_kodas), digits = 0
  )
  
  output$plot <- renderPlot(
    data %>% filter(name == input$imones_kodas) %>%
      ggplot(aes(x = month, y = avgWage)) + geom_line())
}

# Run the application 
shinyApp(ui = ui, server = server)
