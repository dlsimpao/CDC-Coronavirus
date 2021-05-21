#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # variable that collects all the users input and stores them in a data frame
  
  # if apply is hit, calculate probabilities and store in a data frame
  diag_table = reactive({
    df = tibble(Hospital = NA, ICU = NA, Risk_of_Death = NA, Ventilator = NA)
    df
  })
  
  output$tbl <- renderTable(diag_table())
    

})
