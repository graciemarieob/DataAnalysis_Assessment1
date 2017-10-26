# Data Analysis Assessment 1 Part 1
# Grace O'Brien
# 02706911
# 20th October, 2017

# app will be used to simulate random samples from normal probability distributions and will contain:

# i) A numeric input field to allow the user to choose how many random samples are to be generated.
# ii) Two sliders - one for the mean, the second for the sd of the distribution.
# When the sliders or numeric field are changed, new random samples should be generated and the
# histogram of the values should be plotted.


library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Assessment_1_GraceOBrien"),
   
   # Sidebar with numeric & slider inputs
   sidebarLayout(
      sidebarPanel(
       #Numeric input for number of obs
         numericInput ("obs", "Number of Observations", 
                      min = 1,
                      max = 1000,
                      value = 100),
        # Slider input for mean
        sliderInput("mean",
                     "Enter the Mean:",
                     min = 1,
                     max = 100,
                     value = 50),
        # Slider input for standard deviation
        sliderInput("sd", "Enter the Standard Deviation:",
                    min = 1,
                    max = 100,
                    value = 5)
      ),
      
      # Plot of the generated distribution in main panel
      mainPanel(plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$distPlot <- renderPlot({
      hist(rnorm(input$obs, input$mean, input$sd), 
          # Name X label & main title 
            xlab = "Sample Values",
           main = "Histogram of random samples from a normal probability distribution")
    })
    
  }
    
# Run the application 
shinyApp(ui = ui, server = server)

