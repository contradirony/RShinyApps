library(RCurl)

fileurl <- "https://raw.githubusercontent.com/contradirony/RShinyApps/master/fuel_1314.csv"
myCsv <- getURL(fileurl)
temporaryFile <- tempfile()
con <- file(temporaryFile, open = "w")
cat(myCsv, file = con) 
close(con)
dataset <- read.csv(temporaryFile, header=TRUE)

 
shinyServer(function(input, output) {

  output$plot <- renderPlot( 
    ggplot(dataset, aes_string(x=input$x, y=input$y)) + geom_point(size=3)
  )
  
})
