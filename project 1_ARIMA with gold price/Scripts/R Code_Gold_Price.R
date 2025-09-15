#loading the dataset
data <- read.csv("C:\\Users\\dell\\Downloads\\Gold prices\\goldstock v1.csv")
print(data)
Gold_close_price<-data[,c('Date','Close')]
head(Gold_close_price)
library(xts)
library(zoo)
# Check that Date column is in Date format
Gold_close_price$Date <- as.Date(Gold_close_price$Date)
# Create xts object (values = Close price, index = Date)
Ts_gold_price <- xts(Gold_close_price$Close, order.by = Gold_close_price$Date)
# Plot
plot(Ts_gold_price, main = "Gold Closing Prices", col = "gold")
start(Ts_gold_price)
end(Ts_gold_price)
library(tseries)
library(forecast)
library(ggplot2)
#perform Dicky Fuller Test for stationarity with H0:non stationary and H1:stationary
adf_test<-adf.test(Ts_gold_price)
print(adf_test)
#Tseries is not stationary so we make first difference
tseries_diff<-diff(Ts_gold_price)
plot(tseries_diff)
tseries_diff <- na.omit(tseries_diff)
ADF_diff<-adf.test(tseries_diff)
print(ADF_diff)
#Stationary time series
#ACF and PACF 
acf(coredata(tseries_diff), main = 'ACF of differenced daily gold prices')
pacf(coredata(tseries_diff),main='PACF of differenced daily gold prices')

#Fit an arima model automatically
model <- auto.arima(coredata(Ts_gold_price),seasonal=TRUE)
summary(model)
checkresiduals(model)
#the best model is ARIMA(1,1,0):gold price data is essentially a random walk with a very weak AR(1) component. The ARIMA(1,1,0) model fits well, passes residual checks, and provides a reasonable basis for forecasting.
#Forecast next 365 days
forecast_values=forecast(model,h=365)
plot(forecast_values,main = 'ARIMA forecast')
#ARIMA(1,1,0) model says:
#Gold prices don’t have a strong predictable trend.
#The expected price stays around the last observed level.
#However, prices could move up or down significantly, hence the widening cone.
#This outcome is not surprising asit matches what we’d expect from financial series like gold: they often behave like a random walk (difficult to forecast long-term trends).

