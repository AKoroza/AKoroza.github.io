server<-function(input, output) {
    d <- reactive({
        CO2 %>% filter(Type == input$Type,
                       Treatment == input$Treatment)
    })
    
    # linear reg model
    mod1 <- reactive({
        lm(uptake ~ conc, data=d())
    })
    # and its prediction
    linpred1 <- reactive({
        predict(mod1(), data.frame(conc=input$conc))
    })
    
    output$CO2Plot <- renderPlot({
        
        carbon <- ggplot(d(), aes(x=conc, y=uptake)) + geom_point() + 
            xlab("CO2 concentration (mL/L)") +
            ylab("CO2 uptake (umol/m^2 sec)") + geom_smooth(method = "lm", formula = y ~ x, color = "black") +
            geom_point(data=data.frame(conc=input$conc, uptake=linpred1()),
                       color="black", size=4)
        
        
        carbon
        
        
    })
    
    output$description<-renderText({
        "This app uses the CO2 data base which can be found under datasets package
     in R. In the database you can find carbon dioxide uptake, concentrations of the 
     plants found in Mississippi and Quebec. 
     The plants were either chilled or nonchilled during harvest
     process in various carbon dioxide concentrations "
    })
}
