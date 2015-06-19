library(shiny)
library(ggplot2)
data(faithful)

shinyServer(
    function(input, output){
        
        #since it is small dataset, I will train the model right here
        # ideally, we should train the model upfront and load into memory when 
        # the request come in.
        fit <- lm(waiting ~ eruptions, data=faithful)
        
        output$inputvalue1 <- renderText({
            paste("The last eruption duration is ",input$duration, " mins.")
           
        })
        
        output$inputvalue2 <- renderText({
            paste("The last eruption happened in", input$past, " mins ago.")
        })
        
        output$prdictedtime <- renderText({
            
            # prepare duration for predict method.
            eruptions <- input$duration
            x <- data.frame(eruptions)
            
            # calculate result based on the prediction and the last time eruption happend.
            nextTime <- predict(fit, x) - input$past
            
            if (nextTime < 0)
                result <- paste("You missed it. It happened ", -round(nextTime,2), " minutes ago.")
             else   
                result <- paste("The next eruption will happen in ", round(nextTime,2), " minutes.")
            
            result
            })
        
        output$faithfulPlot <- renderPlot({
            eruptions <- input$duration
            waitingTime <- predict(fit, data.frame(eruptions))
            
        ggplot(faithful, aes(x=eruptions, y=waiting)) + 
            ggtitle("Waiting time between eruptions and durations of the eruptions for the Old Faithful geyser, red dot is your input") +
            xlab("Eruptions in minutes") +
            ylab("Waiting time in minutes") +
            geom_point(shape=1) +
            geom_smooth(method=lm, se=FALSE) +
            geom_point(aes_string(y=waitingTime, x=input$duration), color="red", size=5) 
        })
    }
)