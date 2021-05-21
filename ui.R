#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("CDC Application Name"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput("symptoms", "Select all that apply:",  c("Abnormal Chest X-ray","Acute Respiratory Distress Syndrome",
                                              "Fever > 100.4F", "Felt Feverish","Chills","Muscle aches","Runny nose", 
                                              "Sore throat","Cough","Shortness of breath","Nausea or vomitting","Headache",
                                              "Abdominal pain","Diarrhea","Pre-existing medical conditions?")),
            actionButton("diagnose","Apply")
        ),
        

        # Show a plot of the generated distribution
        mainPanel(
            tableOutput("tbl")
        )
    )
))
