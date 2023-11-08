#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyFiles)

ui <- shinyUI(fluidPage(
  
  shinyDirButton(id='directory', 
                 label='Folder select', 
                 title='Please select a folder'),
  
  column(1, offset = 11, 
         actionButton("exitButton", "Exit")), #kill the app
  
  mainPanel(
    tags$h4("Folder selected: ", 
            verbatimTextOutput("directorypath")), # print out the path of the selected folder
    width = 8),
))


server <- shinyServer(function(input, output, session) {
  volumes <- c(Home = "/home/sneumann/tmp/",
               "Orbitrap" = "/vol/PDArchive/NWC/Orbitrap_NWC/",
               "microTOFq I" = "/vol/PDArchive/SEB/QTOF1/",
               "microTOFq II" = "/vol/PDArchive/SEB/QTOF2/"
  )
#  volumes <- c(Home = fs::path_home())
  
  shinyDirChoose(input=input,
                 id="directory",
                 roots = volumes,
                 session = session)

  output$directorypath <- renderPrint({
    if (is.integer(input$directory)) {
      cat("No directory has been selected")
    } else {
      cat(parseDirPath(roots=volumes, selection=input$directory))
    }
  })
  
  observeEvent(input$exitButton, {
    stopApp()
  })
  
})

build_app <- function() {
  app <- shinyApp(ui = ui, server = server)
}

# Run the application 
#shiny::runApp(build_app())

shinyApp(ui = ui, server = server)
