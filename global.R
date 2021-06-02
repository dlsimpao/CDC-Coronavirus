library(tidyverse)
library(tibble)
library(shiny)
library(shinythemes)
library(shinycssloaders)
library(shinyWidgets)
library(shinyjs)


cdc_partial = read.csv("CDC_no_missing09_12_2020.csv")
load("BestModels.RData")

test = tibble(current_status.Probable.Case = 1,
              current_status.Laboratory.confirmed.case = 1,
              sex.Female = 0,
              sex.Male = 1,
              hc_work_yn.0 = 1,
              hc_work_yn.1 = 0,
              pna_yn.0 = 0,
              pna_yn.1 = 1,
              abxchest_yn.0 = 1,
              abxchest_yn.1 = 0,
              acuterespdistress_yn.0 = 1,
              acuterespdistress_yn.1 = 0,
              fever_yn.0 = 0,
              fever_yn.1 = 1,
              sfever_yn.0 = 0,
              sfever_yn.1 = 1,
              chills_yn.0 = 1,
              chills_yn.1 = 0,
              myalgia_yn.0 = 1,
              myalgia_yn.1 = 0,
              runnose_yn.0 = 1,
              runnose_yn.1 = 0,
              sthroat_yn.0 = 0,
              sthroat_yn.1 = 1,
              cough_yn.0 = 0,
              cough_yn.1 = 1,
              sob_yn.0 = 1,
              sob_yn.1 = 0,
              nauseavomit_yn.0 = 1,
              nauseavomit_yn.1 = 0,
              headache_yn.0 = 0,
              headache_yn.1 = 1,
              abdom_yn.0 = 0,
              abdom_yn.1 = 1,
              diarrhea_yn.0 = 0,
              diarrhea_yn.1 = 1,
              medcond_yn.0 = 1,
              medcond_yn.1 = 0,
              age_group.0...9.Years = 0,
              age_group.10...19.Years = 0,
              age_group.20...29.Years = 1,
              age_group.30...39.Years = 0,
              age_group.40...49.Years = 0,
              age_group.50...59.Years = 0,
              age_group.60...69.Years = 0,
              age_group.70...79.Years = 0,
              age_group.80..Years = 0)


# all of them work
predict(model_logistic_mort, test)
predict(model_logistic_mort, test, type = "prob")
predict(model_logistic_vent, test, type = "prob")
predict(model_rf_hosp, test, type = "prob")
predict(model_svm_icu, test, type = "prob")

#model_logistic_mort2$trainingData %>% names()
 
