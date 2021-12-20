#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Load packages
if(!require("shiny")) install.packages("shiny"); library("shiny")
if(!require("dplyr")) install.packages("dplyr"); library("dplyr")
if(!require("plotly")) install.packages("plotly"); library("plotly")
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("dplyr")) install.packages("dplyr"); library("dplyr")
if(!require("DT")) install.packages("DT"); library("DT")
if(!require("haven")) install.packages("haven"); library("haven")
if(!require("tidyr")) install.packages("tidyr"); library("tidyr")
if(!require("tidyr")) install.packages("tidyr"); library("tidyr")
if(!require("stringr")) install.packages("stringr"); library("stringr")
if(!require("maps")) install.packages("maps"); library("maps")
if(!require("data.table")) install.packages("data.table"); library("data.table")
if(!require("shinydashboard")) install.packages("shinydashboard"); library("shinydashboard")
if(!require("rsconnect")) install.packages("rsconnect"); library("rsconnect")
if(!require("shinythemes")) install.packages("shinythemes"); library("shinythemes")
if(!require("dashboardthemes")) install.packages("dashboardthemes"); library("dashboardthemes")
if(!require("sqldf")) install.packages("sqldf"); library("sqldf")




countries_apx <- read_excel("data//appendice.xlsx", sheet = "country_nm")
countries_apx = unique(countries_apx$"Country Name")
countries_apx = sort(countries_apx)

product_apx <- read_excel("data//appendice.xlsx", sheet = "prod")
language_apx <- read_excel("data//appendice.xlsx", sheet = "lang")
app_nm_apx <- read_excel("data//appendice.xlsx", sheet = "app_nm")

df_donut <- read.csv("data//df_country.csv")

#Load base table:
load("data//base_table.RData")

###################################### UI ###################################################

header <- dashboardHeader(title = "Analysis of Internet Sports Gambling")

sidebar <- dashboardSidebar( 
  
  #Sidebar
  sidebarMenu(
    menuItem("Overview", tabName = "overview", icon = icon("r-project")),
    menuItem("Summary", icon = icon("map"), tabName = "summary"),
    menuItem("Demographics", icon = icon("map"), tabName = "demographics"),
    menuItem("Segmentation", tabName = "segs", icon = icon("users")),
    menuItem("Product", tabName = "product", icon = icon("gamepad")),
    menuItem("Gambleing", icon = icon("dice"), tabName = "gambleing"),
    menuItem("Top Customers", icon = icon("smile"), tabName = "topcustomers"),
    menuItem("Conclusion", icon = icon("smile"), tabName = "conclusion"),
    menuItem("Basetable", tabName = "basetable", icon = icon("table")),
    menuItem("Datamart", tabName = "datamart", icon = icon("table"))
      )
  )


body <- dashboardBody(
  ### changing theme
  shinyDashboardThemes(
    theme = "grey_dark"
  ),
  
  
  ############ Tab: Overview #################
  tabItems( 
    tabItem (tabName = "overview",
             h1("Gambling Base Table & Analysis")
    ),
    
    ############ Tab: summary #################    
    tabItem (tabName = "summary",
             h1("Summary")
    ),
    
    ############ Tab: base table #################    
    tabItem (tabName = "basetable",
             div(style = 'overflow-x: scroll', DT::dataTableOutput('Basetable'))),
    
    
    ############ Tab: Demographics #################     
    tabItem (tabName = "demographics",  fluidRow(
      
      # Demographics page header
      titlePanel("Geo Analysis"),
    
      tabsetPanel(
        tabPanel("Top Countries", br(),
                 mainPanel(
                   column(width=11,
                          fluidRow(height = 200,
                                   h3("Top countries by users"), 
                                   plotlyOutput("demographics", width = "100%")
                          )))),
        tabPanel("Top Countries", br(),
                 mainPanel(
                   column(width=11,
                          fluidRow(height = 200,
                                   h3("Top countries by users - Excluding Germany"), 
                                   plotlyOutput("demographics2", width = "100%")
                          )))),
        
        
        
      ))),
    
    #############Tab: Product  #################
    tabItem (tabName = "product",  fluidRow(
      # Source Page Header
      titlePanel("Product Analysis"),
      tabsetPanel(
        tabPanel("Overall",  br(),
                 mainPanel(
                   column(width=11,
                          fluidRow(height = 200,
                                   h3("Popular products (excluding poker)"),
                                   plotOutput("Product", width = "100%"),
                                   
                          )))),
    
        tabPanel("Source By Interactive Selection", br(),
                 sidebarPanel(
#                   selectInput("Country", "Select a country",
#                               c("Germany","Turkey","Poland","Spain","Greece","France","Denmark","Austria","Italy","Switzerland"),
#                               selected ="Germany"),
                   sliderInput("Agegroup", "Select age",
                               min=10, max=100,value=25, step=5)  
                 ),
                 
                 mainPanel(
                   column(width=11,
                          fluidRow(height = 200,
                                   h4("Popular Applications by Age & Country"),plotOutput("SourceCountry")
                                   
                          ))))                  
      ))),

############ Tab: gambleing #################     
   
    tabItem (tabName = "gambleing",
             h1("Gambling - Winners Analysis"),
             plotOutput("gambleing", width = "100%")
             
    )


    
    
    
  ))# end of tabsitem and body      
shinyUI(fluidPage(
                  dashboardPage(header, sidebar, body)
))      

