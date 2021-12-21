
library('lubridate')

str(PokerChipConversions)

str(UserDailyAggregation)

str(Demographics$RegDate)


#data cleaning 

#check tibble feature types
str(Demographics)

#convert registration date to date time 

Demographics$RegDate <- as.Date(Demographics$RegDate)

str(Demographics$RegDate)

#convert first pay, first act, first sports book play, first casino play,
# first games play, and  first poker play dates to datetime.

Demographics$FirstPay <- as.Date(Demographics$FirstPay, "%Y%m%d")

Demographics$FirstAct <- as.Date(Demographics$FirstAct, "%Y%m%d")

Demographics$FirstSp <- as.Date(Demographics$FirstSp, "%Y%m%d")

Demographics$FirstCa <- as.Date(Demographics$FirstCa, "%Y%m%d")

Demographics$FirstGa <- as.Date(Demographics$FirstGa, "%Y%m%d")

Demographics$FirstPo <- as.Date(Demographics$FirstPo, "%Y%m%d")

str(Demographics)