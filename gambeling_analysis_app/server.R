#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

countries_apx <- read_excel("data//appendice.xlsx", sheet = "country_nm")
product_apx <- read_excel("data//appendice.xlsx", sheet = "prod")
language_apx <- read_excel("data//appendice.xlsx", sheet = "lang")
app_nm_apx <- read_excel("data//appendice.xlsx", sheet = "app_nm")



load("data//base_table.RData")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {


################ TAB: Base Table###############  
    output$Basetable <- DT::renderDataTable({
        Basetable <- final_base_table
        DT::datatable(Basetable)
    })


    output$Product <- renderPlot({
        
        ###########################
        base_table_p <- final_base_table
        prod_counts = c(sum(base_table_p$procuct_1_cnt),sum(base_table_p$product_2_cnt),sum(base_table_p$product_4_cnt),sum(base_table_p$product_5_cnt),sum(base_table_p$product_6_cnt),sum(base_table_p$product_7_cnt),sum(base_table_p$product_8_cnt))
        prod_counts
        df_product_counts <- data.frame(
            products = as.factor(c('Prod_1','Prod_2','Prod_4','Prod_5','Prod_6','Prod_7','Prod_8')),
            counts = prod_counts)
        
        #create a bar chart displaying most popular products excluding poker 
        bar_plots_products <- ggplot(df_product_counts,aes(x=products,y=counts, fill=products)) +
            geom_col(position='dodge') +
            ggtitle('Product count (usage) against product type') + 
            theme_light(base_size=11) +
            theme(plot.title = element_text(hjust = 0.5)) +
            ylab('Count (times played)') + 
            scale_x_discrete('Product type',labels=c('Sports book fixed-odd','Sports book live-action','Casino BossMedia','Supertoto','Games VS','Games bwin','Casino Chartwell')) +
            theme(axis.text.x = element_text(angle = 90)) +
            scale_fill_discrete(labels=c('Sports book fixed-odd','Sports book live-action','Casino BossMedia','Supertoto','Games VS','Games bwin','Casino Chartwell'))
        
        bar_plots_products
        })
    
    ################demographics###########
    output$demographics <- renderPlotly({
        df_donut <- read.csv("df_donut.csv")
        
        plot_ly(labels = df_donut$country, values = df_donut$count)  %>% 
            plotly::add_pie(hole = 0.5) %>% 
            layout(title = "Top User Distribution by Country",  showlegend = T,
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
        
    })
    
   
    
    output$demographics2 <- renderPlotly({
    df_country <- read.csv("df_country.csv")
    fig_cntry <- plot_ly(
        df_country,
        x = ~reorder(Country_Name, Male),
        y = ~Male,
        type = "bar",
        name = 'Male',
        textposition = 'auto')  %>%
        add_trace(y = ~Female, name = 'Females')  %>% 
        layout(yaxis = list(title = 'Count of Users'), barmode = 'stack')
    
    fig_cntry
    
    })
    
    output$gambleing <- renderPlot({
        #create plot that visualizes monetary value (gambler' winnings), frequency, and recency
        scatter_plot_monetary_value <- ggplot(base_table, aes(x=frequency,y=monetary_value,color=recency)) + 
            ggtitle('Gambler total winnings against frequency') + 
            xlab('Frequency (days)') + 
            ylab('Total winnings (Euros)') + 
            #create annotation for most extreme outlier, displaying their ID
            annotate(geom='text',x = 175, y= 1070000, label='Gambler ID with highest winnings',color='blue')
        
        #code adapted and inspired from this forum thread: https://stackoverflow.com/questions/1923273/counting-the-number-of-elements-with-the-values-of-x-in-a-vector
        scatter_plot_monetary_value_1 <- lapply(base_table[1], function(data) scatter_plot_monetary_value +
                                                    geom_jitter(alpha=0.5) + 
                                                    theme_light(base_size=11) + 
                                                    theme(plot.title = element_text(hjust = 0.5)) + 
                                                    geom_text(aes(label= ifelse(base_table$monetary_value > quantile(base_table$monetary_value, 0.9999999),as.character(base_table$UserID),'')),hjust=0,vjust=0))
        
        scatter_plot_monetary_value_1
        
    })
    
    
    
    }) #Server End


