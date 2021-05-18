library(shiny)
library(tidyverse)
library(datasets)
library(ggplot2)
library(dplyr)


CO2 <- datasets::CO2
ui <- fluidPage(
    titlePanel("CO2 uptake and concentration in plants"),
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "conc",
                        label = "conc mL/L",
                        min = 95,
                        max = max(CO2$conc, na.rm = TRUE),
                        value = c(95, max(CO2$conc, na.rm = TRUE)),
                        pre = "mL/L"),
            radioButtons(inputId = "Treatment",
                         label = "treatment type",
                         choices = c("chilled","nonchilled")),
            
            radioButtons(inputId = "Type",
                         label = "Location",
                         choices = c("Quebec","Mississippi"))
        ), 
        mainPanel(
            
            tabsetPanel(type="tabs",
                        tabPanel("Use the app",br(),
                                 
                                 plotOutput("CO2Plot")),
                        
                        tabPanel("App data",br(),
                                 textOutput("description"))
                        
                        
            )
        )))
