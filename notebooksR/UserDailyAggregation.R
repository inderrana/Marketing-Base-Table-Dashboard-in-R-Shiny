setwd('C:/Users/njohn/OneDrive - IESEG/Semester 1/Business Reporting Tool_Open Source/Group Project/Group assignment folder-20211211/')
library(dplyr)
load('DataGroupAssignment.Rdata')
summary(UserDailyAggregation)
#write.csv(UserDailyAggregation,'UserDailyAggregation.csv')

UserDailyAggregation$Date <- as.Date(UserDailyAggregation$Date,format = '%Y%m%d')

UserDailyAggregation_2 <- UserDailyAggregation %>%
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


UserDailyAggregation_2$count <- UserDailyAggregation %>% count(UserID)


UserDailyAggregation_3 <- UserDailyAggregation %>% 
                              group_by(UserID,ProductID) %>%
                                  slice(1)
                                  