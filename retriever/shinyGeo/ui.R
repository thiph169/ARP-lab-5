
#runGitHub("ARP-lab-5", username = "thiph169",ref = "master",subdir = "retriever/shinyGeo")

library(shiny)
library(retriever)
library(httr)

ui <- fluidPage(
  titlePanel("Address and Coordinates LookUp"),
  sidebarLayout(
    sidebarPanel( 
      
      textInput("var", label = "Enter address or coordinates")),
    
    
    mainPanel(tableOutput("return"),
              textOutput("print"),
              list(tags$head(tags$style("body {background-color: #ADD8E6; }")))
    )
  )
)