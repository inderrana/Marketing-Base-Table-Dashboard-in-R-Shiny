setwd('C:/Users/njohn/OneDrive - IESEG/Semester 1/Business Reporting Tool_Open Source/Group Project/Group assignment folder-20211211/')

if (!require("dplyr")) install.packages("dplyr")
if (!require("formattable")) install.packages("formattable")
options(scipen = 20)
load('DataGroupAssignment.Rdata')
summary(UserDailyAggregation)
#write.csv(UserDailyAggregation,'UserDailyAggregation.csv')

UserDailyAggregation$Date <- as.Date(UserDailyAggregation$Date,format = '%Y%m%d')
Demographics$FirstPay <- as.Date(Demographics$FirstPay, format = '%Y%m%d')

Demographics_paydate <- Demographics %>%
  select(UserID,FirstPay)

UserDailyAggregation_2 <- left_join(UserDailyAggregation,Demographics_paydate,by = 'UserID')

UserDailyAggregation_2 <- UserDailyAggregation_2 %>%
                            filter(Date >= FirstPay)
                                

UserDailyAggregation_3 <- UserDailyAggregation_2 %>%
                              group_by(UserID) %>%
                                  summarise(total_stakes = sum(Stakes), 
                                            total_bets = sum(Bets),
                                            total_winning = sum(Winnings),
                                            average_stakes = mean(Stakes),
                                            average_bets = mean(Bets),
                                            average_winning = mean(Winnings),
                                            max_stakes = max(Stakes),
                                            max_bets = max(Bets),
                                            max_winning = max(Winnings),
                                            min_stakes = min(Stakes),
                                            min_bets = min(Bets),
                                            min_winning = min(Winnings)) 


UserDailyAggregation_3$count <- UserDailyAggregation_2 %>% count(UserID)
####Recency and Frequency calculateion
#Get max date
recency_Date <- max(UserDailyAggregation_2$Date)

#calculate recency and frequency
UserDailyAggregation_recency <- UserDailyAggregation_2 %>% 
                                    group_by(UserID) %>% 
                                summarise(recency = as.numeric(recency_Date - max(Date)),
                                          frequency = n())
#calculate monetary value check
UserDailyAggregation_value <- PokerChipConversions %>%
                                  group_by(UserID) %>%
                                    filter(TransType == 124)  %>%
                                      summarise(monetary_value = sum(TransAmount)) 

#Merge the tables to get recency,frequency and lifetime value
UserDailyAggregation_rfm <- left_join(UserDailyAggregation_recency,UserDailyAggregation_value,by='UserID')

#Fill na with 0s
UserDailyAggregation_rfm[is.na(UserDailyAggregation_rfm)] = 0

#calculate RFM Score
UserDailyAggregation_rfm <- UserDailyAggregation_rfm %>%
                                  mutate(rfm_score = recency + frequency + monetary_value)

#Scale RFM score
UserDailyAggregation_rfm$rfm_score <- normalize(UserDailyAggregation_rfm$rfm_score,min = 0,max = 1)


UserDailyAggregation_3 <- left_join(UserDailyAggregation_3,UserDailyAggregation_rfm,by='UserID')
