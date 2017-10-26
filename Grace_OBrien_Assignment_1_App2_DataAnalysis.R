# Data Analysis Assessment 1 App2
# Grace O'Brien
# 02706911
# 20th October, 2017

# app will take a csv and do the following:

# i) Display the data from the file in a rendered table.

# ii) Allow the user to select a variable (column) of interest via a prepopulated control -
# the data for this variable should then be displayed as a boxplot beneath the table.

# iii) A set of RadioButtons should allow the user to specify the colour of the boxplot from four
# different colour choices.



library(shiny)

# Only run examples in interactive R sessions
if (interactive()) {

#Define UI & application title
ui <- fluidPage(
  titlePanel("Assessment 1 Part 2"),
   
  # Sidebar with file input box 
  sidebarLayout(
      sidebarPanel(
        fileInput("datafile", "Choose CSV File",
                  accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv")),
        
  # Define input variables
        selectInput("var", "Variable", 
                    c("Patient ID" = "patient_id", 
                      "Age"= "age", 
                      "Height" = "height", 
                      "Weight" = "weight", 
                      "BMI" = "bmi")),
  
  # Define radio buttons for colour options
        radioButtons("rb", "Choose a colour", 
                     c("Red" = "red", 
                       "Blue" = "blue", 
                       "Yellow" = "yellow", 
                       "Green" = "green")),
        tags$hr(),
        checkboxInput("header", "Header", TRUE)
      ),
  # Main panel output of data table of file contents 
  # & plot of choosen variable
      mainPanel(
        tableOutput("file_contents"),
        plotOutput("variable")
        
      )
    )
  )
 
# Define server logic required to display table & boxplot
  server <- function(input, output) {
    # Table output & input location
    output$file_contents <- renderTable({
      infile <-input$datafile
     # Display null if nothing is input      
      if (is.null(infile))
        return(NULL)
      read.csv(infile$datapath, header = input$header)
    })
    
    # Plot output & input location
    output$variable <-renderPlot({
      (req(input$datafile))
      infile <- input$datafile
      data <-read.csv(infile$datapath, header=input$header)
      # Boxplot details
      var <-input$var
      col <-input$rb
      boxplot(data[,var], col=col, main=paste("Selected Variable", var))
    })
    
  }
# Run the application
  shinyApp(ui = ui, server = server)
}

