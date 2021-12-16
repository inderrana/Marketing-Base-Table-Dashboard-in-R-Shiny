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
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("dplyr")) install.packages("dplyr"); library("dplyr")
if(!require("haven")) install.packages("haven"); library("haven")
if(!require("tidyr")) install.packages("tidyr"); library("tidyr")
if(!require("stringr")) install.packages("stringr"); library("stringr")
if(!require("maps")) install.packages("maps"); library("maps")
if(!require("data.table")) install.packages("data.table"); library("data.table")
if(!require("shinydashboard")) install.packages("shinydashboard"); library("shinydashboard")
if(!require("rsconnect")) install.packages("rsconnect"); library("rsconnect")
if(!require("shinythemes")) install.packages("shinythemes"); library("shinythemes")
if(!require("dashboardthemes")) install.packages("dashboardthemes"); library("dashboardthemes")


#Load our Datamart:
#Datamart <- read.csv("datamart.csv")

###################################### UI ###################################################

header <- dashboardHeader(title = "Analysis of Internet Sports Gambling")

sidebar <- dashboardSidebar( 
  
  #Sidebar
  sidebarMenu(
    menuItem("Overview", tabName = "overview", icon = icon("r-project")),
    menuItem("Datamart", tabName = "datamart", icon = icon("table")),
    menuItem("Demographics", icon = icon("map"), tabName = "demographics"),
    menuItem("Subscriptions", tabName = "subs", icon = icon("users")),
    menuItem("Product", tabName = "product", icon = icon("gamepad")),
    menuItem("Gambleing", icon = icon("dice"), tabName = "Gambleing"),
    menuItem("Top Customers", icon = icon("smile"), tabName = "topcustomers"),
    menuItem("Conclusion", icon = icon("smile"), tabName = "conclusion")
    
      )
)

body <- dashboardBody(
  ### changing theme
  shinyDashboardThemes(
    theme = "purple_gradient"
  ),
  
  ############ Page 1: Overview #################
  tabItems( 
    tabItem (tabName = "overview",
             h1("Analysis of Internet Sports Gambling"),
    )),
  
  ############ Page 2: Data #################    
  tabItem (tabName = "data",
           div(style = 'overflow-x: scroll', DT::dataTableOutput('datamart'))),
  
 
  ############ Tab 3: User Demographics #################     
  tabItem (tabName = "userdemo",  fluidRow(
    titlePanel("User Demographics"),
    tabsetPanel(
      tabPanel("Placeholder",  br(),
               mainPanel(
                 column(width=11,
                        fluidRow(height = 200,
                                 h3("Placeholder"),
                                 plotOutput("Placeholder", width = "100%")
                        )))),
      
      
      tabPanel("Placceholder", br(),
               mainPanel(
                 column(width=11,
                        fluidRow(height = 200,
                                 h3("placeholder"),
                                 plotOutput("placeholder", width = "100%")
                        )))),
      
      tabPanel("Placeholder", br(),
               
               
      ))),
    
    
    
    
  ))
   


      
shinyUI(fluidPage(
                  dashboardPage(header, sidebar, body)
))      
  
  
 # shinyUI(dashboardPage(
  #  header, sidebar, body ,skin ="green")
  #)