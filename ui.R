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
    titlePanel("COVID-19 Preliminary Diagnosis"),
    

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput("symptoms", "Select all that apply:",  c("Healthcare worker",
                                                                        "Pneumonia",
                                                                        "Abnormal chest x-ray",
                                                                        "Acute Respiratory Distress",
                                                                        "Fever",
                                                                        "Severe Fever",
                                                                        "Chills",
                                                                        "Muscle aches (Mylagia)",
                                                                        "Runny nose",
                                                                        "Sore Throat",
                                                                        "Cough",
                                                                        "Shortness of breath",
                                                                        "Nausea/Vomitting",
                                                                        "Headache",
                                                                        "Abdominal pain",
                                                                        "Diarrhea",
                                                                        "Pre Existing Medical Conditions")),
            selectInput("gender", "Select gender", choices = c("Male", "Female")),
            selectInput("age", "Select age group", choices = c("1-9","10-19","20-29","30-39","40-49","50-59","60-69","70-79","80+")),
            selectInput("test", "Select one", choices = c("Tested but no results yet",
                                                          "Tested with positive results")),
            actionButton("diagnose","Apply")
        ),
        

        # Show a plot of the generated distribution
        mainPanel(
            tableOutput("tbl"),
            br(),
            helpText("How to Interpret:"),
            helpText("Hospital Yes (0.989) Given your symptoms, you have a 98.9% probability of needing to visit the hospital."),
            helpText("ICU No (0.899) Given your symptoms, you have a 89.9% probability of not needing the ICU."),
            tableOutput("tbl2"),
            tableOutput("tbl3")
        )
    )
))
