library(shiny)
library(ggplot2)

library(RCurl)

fileurl <- "https://raw.githubusercontent.com/contradirony/RShinyApps/master/fuel_1314.csv"
myCsv <- getURL(fileurl)
temporaryFile <- tempfile()
con <- file(temporaryFile, open = "w")
cat(myCsv, file = con) 
close(con)
dataset <- read.csv(temporaryFile, header=TRUE)

shinyUI(pageWithSidebar(
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