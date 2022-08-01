library(shiny)
library(DT)
library(googlesheets4)

gs4_deauth()

ui <- fluidPage(
  titlePanel("NIH Rigor Champions Contact List"),
  HTML('Use the search bar to find the contact email for an attendee of the Catalyzing Communities of Research Rigor workshop.'),
  br(),
  br(),
  mainPanel(
    DT::dataTableOutput("contactTable")
  )
)

server <- function(input, output) {
  sheetLink <- "https://docs.google.com/spreadsheets/d/1zEYGga-4GIverP7Y_ppaqG7_qorPKSsDrCVKyio0ie0/edit?usp=sharing"
  contactData <- read_sheet(sheetLink,
                            sheet = 1)
  output$contactTable = DT::renderDataTable({contactData[c(1,2,3,8,9)]}, options = list(
    pageLength = 25, searchDelay = 200), escape = 1:3)
}

shinyApp(ui,server)
