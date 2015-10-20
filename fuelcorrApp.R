##############################
# author: slam
# description: part of course project for coursera course, Developing Data Products 
# created: 20 October 2015
#
# The application must include the following:
#   
# Some form of input (widget: textbox, radio button, checkbox, ...)
# Some operation on the ui input in server.R
# Some reactive output displayed as a result of server calculations
# You must also include enough documentation so that a novice user could use your application.
# The documentation should be at the Shiny website itself. Do not post to an external link.

library(shiny)
library(ggplot2)

fileurl <- "https://raw.githubusercontent.com/contradirony/RShinyApps/master/fuel_1314.csv"
require(RCurl)
myCsv <- getURL(fileurl)
temporaryFile <- tempfile()
con <- file(temporaryFile, open = "w")
cat(myCsv, file = con) 
close(con)
fuel_1314 <- read.csv(temporaryFile, header=TRUE)

dataset <- fuel_1314  

server <- shinyServer(function(input, output) {
  output$plot <- renderPlot(
    ggplot(dataset, aes_string(x=input$x, y=input$y)) + geom_point(size=3)
  )  
})

ui <- shinyUI(pageWithSidebar(
  headerPanel("Fuel Comsumption Explorer"),
  sidebarPanel(
    selectInput('x', 'X', names(dataset)),
    selectInput('y', 'Y', names(dataset), names(dataset)[[2]])
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("App",plotOutput('plot')),
      tabPanel("Documentation",HTML( 
        "<p>This is a very simple app to view correlation between some simple attributes of fuel data I've gathered in my spare time.</p>
<p>The user selects which attribute he/she would like to see on the <i>x</i> and <i>y</i> axes:</p>
        <ul>
      <li>the 3 attributes are MoneySpent, LitresOfPetrol and PricePerLitre (see if you can guess where I'm from!)</li>
      <li>the input is selection of attribute</li>
      <li>the operation causes the UI to render a plot which is defined on the server-side.</li>
      </ul>"))
    ))
))

shinyApp(ui,server)
