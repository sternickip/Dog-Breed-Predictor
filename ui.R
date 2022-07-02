
# source('helpers.R')

shinyUI(
  dashboardPage(
    dashboardHeader(title='Dog Breed Predictor'),
    dashboardSidebar(
      fileInput("input_image","Upload a picture of a dog here!" ,accept = c('.jpg','.jpeg')),
      numericInput('top_n',
                   'How many closest predictions to show?',
                   value=5,
                   min=1,
                   max=10
                   )
    ),
    dashboardBody(fluidPage(fluidRow( column(4,imageOutput("output_image",width='auto',height='auto'),offset=5)),
                            fluidRow(column(4,DT::dataTableOutput("Table"),offset=5))),
                  includeCSS("www/stylesheets.css"),
    ),
    skin='purple'
  )
)


