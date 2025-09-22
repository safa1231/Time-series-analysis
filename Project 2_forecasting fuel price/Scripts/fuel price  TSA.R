#loading the dataset
data <- read.csv("C:\\Users\\dell\\Downloads\\weekly_fuel_prices_all_data_from_2005_to_20210823.csv")
print(data)
euro95_data <- subset(data, PRODUCT_NAME == "Euro-Super 95")
print(euro95_data)
Weekly_fuel_price<-euro95_data[,c('SURVEY_DATE','PRICE')]
head(Weekly_fuel_price)
library(xts)
library(zoo)
# Check that Date column is in Date format
Weekly_fuel_price$SURVEY_DATE <- as.Date(Weekly_fuel_price$SURVEY_DATE)
print(Weekly_fuel_price)
# Create xts object (values = Close price, index = Date)
Ts_fuel_price <- xts(Weekly_fuel_price$PRICE,order.by = Weekly_fuel_price$SURVEY_DATE)
# Plot
plot(Ts_fuel_price, main = "Weekly Euro-Super 95 Prices", col = "blue", ylab = "Price")
start(Ts_fuel_price)
end(Ts_fuel_price)
library(tseries)
library(forecast)
library(ggplot2)
#perform Dicky Fuller Test for stationarity with H0:non stationary and H1:stationary
adf_test<-adf.test(Ts_fuel_price)
print(adf_test)
#Tseries is not stationary so we make first difference
tseries_diff<-diff(Ts_fuel_price)
plot(tseries_diff)
tseries_diff <- na.omit(tseries_diff)
ADF_diff<-adf.test(tseries_diff)
print(ADF_diff)
#Stationary time series
#ACF and PACF 
acf(tseries_diff, main = 'ACF of differenced Weekly Euro-Super 95 Price')
pacf(tseries_diff,main='PACF of differenced Weekly Euro-Super 95 Price')
#Trying candidate models based on ACF,PACf plots 
#fitting an ARIMA(1,1) to the differenced series
model_arima11 <- Arima(Ts_fuel_price, order=c(1,1,1))
summary(model_arima11)
checkresiduals(model_arima11)
#fitting an ARIMA(1,2) to the differenced series
model_arima12 <- Arima(Ts_fuel_price,order=c(1,1,2))
summary(model_arima12)
checkresiduals(model_arima12)
#fitting an ARIMA(1,1,3) to the differenced series
model_arima113 <- Arima(Ts_fuel_price,order=c(1,1,3))
summary(model_arima113)
checkresiduals(model_arima113)
#Fit an arima model automatically
model <- auto.arima(Ts_fuel_price,seasonal=TRUE)
summary(model)
checkresiduals(model)
#the best model is ARIMA(2,1,2)
# Forecast next 52 weeks with ARIMA(2,1,2)
ARIMA_forecast <- forecast(model,h = 52)
plot(ARIMA_forecast, main="ARIMA(2,1,2) Forecast - Euro-Super 95")
#Extract the last date from the historical time series
last_date <- index(tail(Ts_fuel_price, 1))
#generate the forecast horizon
forecast_dates <- seq(last_date + 7, by = "week", length.out = 52)
forecast_values <- as.numeric(ARIMA_forecast$mean)  # ensure numeric
forecast_xts <- xts(forecast_values, order.by = forecast_dates)
#Combine historical and forecasted data into one continuous time series
combined_xts <- rbind(Ts_fuel_price, forecast_xts)
print("Plot 6: Combined Historical + Forecasted fuel prices ")
plot(combined_xts, 
     main = "Combined Historical + Forecasted fuel prices Next 52 Weeks)", 
     col = c(rep("blue", length(Ts_fuel_price)), rep("red", 52)),
     lwd = 2,
     ylab = "Price",
     xlab = "Date")
lines(forecast_xts, col = "red", lwd = 2)
legend("topleft", 
       legend = c("Historical", "Forecast"), 
       col = c("blue", "red"), 
       lwd = 2)
# Fit ETS model
ets_model <- ets(Ts_fuel_price)
summary(ets_model)
# Forecast next 52 weeks
ets_forecast <- forecast(ets_model, h = 52)
# Plot ETS forecast
plot(ets_forecast, 
     main = "ETS Forecast - Euro-Super 95", 
     ylab = "Price", 
     xlab = "Date")
# Combine ETS forecast with historical data
ets_forecast_values <- as.numeric(ets_forecast$mean)
ets_forecast_xts <- xts(ets_forecast_values, order.by = forecast_dates)

combined_ets_xts <- rbind(Ts_fuel_price, ets_forecast_xts)
plot(combined_ets_xts, 
     main = "Combined Historical and ETS Forecast (52Weeks)", 
     col = c(rep("blue", length(Ts_fuel_price)), rep("orange", 52)),
     lwd = 2,
     ylab = "Price", 
     xlab = "Date")
lines(ets_forecast_xts, col = "orange", lwd = 2)
legend("topleft", legend = c("Historical", "ETS Forecast"), col = c("blue", "orange"), lwd = 2
# Exploring SARIMA models
sarima_auto <- auto.arima(Ts_fuel_price,
                          seasonal = TRUE,
                          D = 1,             # force 1 seasonal difference
                          max.P = 2,         # max seasonal AR terms
                          max.Q = 2,         # max seasonal MA terms
                          stepwise = FALSE,  
                          approximation = FALSE)

print("Best Auto SARIMA Model")
summary(sarima_auto)
checkresiduals(sarima_auto)
#Based on the AIC and BIC criteria,the best model among the 3 models is ARIMA(2,1,2)
