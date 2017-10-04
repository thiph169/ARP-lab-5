
#runGitHub("ARP-lab-5", username = "thiph169",ref = "master",subdir = "retriever/shinyGeo")


library(shiny)
library(retriever)

server <- function(input, output) {
  
  output$print <- renderPrint(
    coordinates(input$var) 
  )
  
  output$return <- renderTable({
    coordinates(input$var) 
  })
  
}
# Run the application
#shinyApp(ui = ui, server = server)


