setwd('C:/Users/njohn/OneDrive - IESEG/Semester 1/Business Reporting Tool_Open Source/Group Project/Group assignment folder-20211211/')
library(dplyr)
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


UserDailyAggregation_4 <- UserDailyAggregation_2 %>% 
                              group_by(UserID,ProductID) %>%
                                  slice(1)


                                  