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
  # symptom variables to collect
  probcase = reactive(ifelse(input$test == "Tested but no results yet", 1, 0))
  lab.conf.case = reactive(ifelse(input$test == "Tested with positive results", 1, 0))
  
  sex.F = reactive(ifelse(input$gender == "Female", 1, 0))
  sex.M = reactive(ifelse(input$gender == "Male", 1, 0))
  
  hworker = reactive(ifelse("Healthcare worker" %in% input$symptoms, 1, 0))
  pneum = reactive(ifelse("Pneumonia" %in% input$symptoms, 1, 0))
  abxray = reactive(ifelse("Abnormal chest x-ray" %in% input$symptoms, 1, 0))
  ard = reactive(ifelse("Acute Respiratory Distress" %in% input$symptoms, 1, 0))
  fever = reactive(ifelse("Fever" %in% input$symptoms, 1, 0))
  sfever = reactive(ifelse("Severe Fever" %in% input$symptoms, 1, 0))
  chills = reactive(ifelse("Chills" %in% input$symptoms, 1, 0))
  myl = reactive(ifelse("Muscle aches (Mylagia)" %in% input$symptoms, 1, 0))
  runnose = reactive(ifelse("Runny nose" %in% input$symptoms, 1, 0))
  sthroat = reactive(ifelse("Sore Throat" %in% input$symptoms, 1, 0))
  cough = reactive(ifelse("Cough" %in% input$symptoms, 1, 0))
  sob = reactive(ifelse("Shortness of breath" %in% input$symptoms, 1, 0))
  nauvom = reactive(ifelse("Nausea/Vomitting" %in% input$symptoms, 1, 0))
  head = reactive(ifelse("Headache" %in% input$symptoms, 1, 0))
  abd = reactive(ifelse("Abdominal pain" %in% input$symptoms, 1, 0))
  diarr = reactive(ifelse("Diarrhea" %in% input$symptoms, 1, 0))
  medcond = reactive(ifelse("Pre-Existing Medical Conditions" %in% input$symptoms, 1, 0))
  
  #age variables
  age0 = reactive(ifelse(input$age == "1-9", 1, 0))
  age1 = reactive(ifelse(input$age == "10-19", 1, 0))
  age2 = reactive(ifelse(input$age == "20-29", 1, 0))
  age3 = reactive(ifelse(input$age == "30-39", 1, 0))
  age4 = reactive(ifelse(input$age == "40-49", 1, 0))
  age5 = reactive(ifelse(input$age == "50-59", 1, 0))
  age6 = reactive(ifelse(input$age == "60-69", 1, 0))
  age7 = reactive(ifelse(input$age == "70-79", 1, 0))
  age8 = reactive(ifelse(input$age == "80+", 1, 0))
  
  # diagnosis (Yes or No)
  hosp = reactiveVal(NA)
  icu = reactiveVal(NA)
  mort = reactiveVal(NA)
  mort2 = reactiveVal(NA)
  vent = reactiveVal(NA)
  vent2 = reactiveVal(NA)

  

  # variable that collects all the users input and stores them in a data frame
  
  symptoms_table = reactive({
    df = tibble(current_status.Probable.Case = probcase(),
                current_status.Laboratory.confirmed.case = lab.conf.case(),
                sex.Female = sex.F(),
                sex.Male = sex.M(),
                hc_work_yn.0 = abs(hworker()-1),
                hc_work_yn.1 = hworker(),
                pna_yn.0 = abs(pneum()-1),
                pna_yn.1 = pneum(),
                abxchest_yn.0 = abs(abxray()-1),
                abxchest_yn.1 = abxray(),
                acuterespdistress_yn.0 = abs(ard()-1),
                acuterespdistress_yn.1 = ard(),
                fever_yn.0 = abs(fever()-1),
                fever_yn.1 = fever(),
                sfever_yn.0 = abs(sfever()-1),
                sfever_yn.1 = sfever(),
                chills_yn.0 = abs(chills()-1),
                chills_yn.1 = chills(),
                myalgia_yn.0 = abs(myl()-1),
                myalgia_yn.1 = myl(),
                runnose_yn.0 = abs(runnose()-1),
                runnose_yn.1 = runnose(),
                sthroat_yn.0 = abs(sthroat()-1),
                sthroat_yn.1 = sthroat(),
                cough_yn.0 = abs(cough()-1),
                cough_yn.1 = cough(),
                sob_yn.0 = abs(sob()-1),
                sob_yn.1 = sob(),
                nauseavomit_yn.0 = abs(nauvom()-1),
                nauseavomit_yn.1 = nauvom(),
                headache_yn.0 = abs(head()-1),
                headache_yn.1 = head(),
                abdom_yn.0 = abs(abd()-1),
                abdom_yn.1 = abd(),
                diarrhea_yn.0 = abs(diarr()-1),
                diarrhea_yn.1 = diarr(),
                medcond_yn.0 = abs(medcond()-1),
                medcond_yn.1 = medcond(),
                age_group.0...9.Years = age0(),
                age_group.10...19.Years = age1(),
                age_group.20...29.Years = age2(),
                age_group.30...39.Years = age3(),
                age_group.40...49.Years = age4(),
                age_group.50...59.Years = age5(),
                age_group.60...69.Years = age6(),
                age_group.70...79.Years = age7(),
                age_group.80..Years = age8())
  })
  
  observeEvent(input$diagnose, {
    h = predict(model_rf_hosp, symptoms_table())
    i = predict(model_svm_icu, symptoms_table())
    m = predict(model_logistic_mort, symptoms_table())
    v = predict(model_logistic_vent, symptoms_table())
    
    h_prob = predict(model_rf_hosp, symptoms_table(), type = "prob")[h]
    i_prob = predict(model_svm_icu, symptoms_table(), type = "prob")[i]
    m_prob = predict(model_logistic_mort, symptoms_table(), type = "prob")[m]
    v_prob = predict(model_logistic_vent, symptoms_table(), type = "prob")[v]
    
    hosp(paste0(h," (",h_prob %>% round(3),")"))
    icu(paste0(i," (",i_prob %>% round(3),")"))
    mort(paste0(m," (",m_prob %>% round(3),")"))
    vent(paste0(v," (",v_prob %>% round(3),")"))
  })
  
  # if apply is hit, calculate probabilities and store in a data frame
  diag_table = reactive({
    df = tibble(Hospital = hosp(), ICU = icu(), Mortality = mort(), Ventilator = vent())
    df
  })
  
  output$tbl <- renderTable(diag_table())
  
  #testing, delete later
  #output$tbl2 <- renderTable(input$symptoms)
  
  #observeEvent(input$diagnose, output$tbl3 <- renderTable(symptoms_table2()))
    

})
