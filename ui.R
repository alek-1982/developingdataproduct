library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("When will the Old Faithful Geyser erupt next time?"),
    sidebarPanel(
        numericInput("duration",label=h3("Last eruption duration in mins"), value=3.0, min=0.1),
        sliderInput("past", label=h3("How many mins ago it erupted?"), min=0, max=100, value=0),
        submitButton("Submit"),
        br(),
        hr(),
        br(),
        tags$img(src="Geyser.jpg", width="100%")
        ),
    mainPanel(
        tags$hr(),
        p('Old Faithful is a cone geyser located in Wyoming, in Yellowstone National Park in the United States. It is one of the most predictable geographical features on Earch.'),
        p('If you would like to know when it will erupt next time, please enter the correct value in the left panel, and then click Submit'),
        tags$hr(),
        textOutput("inputvalue1"),
        br(),
        textOutput("inputvalue2"),
        br(),
        verbatimTextOutput("prdictedtime")       ,
        br(),
        br(),
        plotOutput('faithfulPlot')
    )
    ))