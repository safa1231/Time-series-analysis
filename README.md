# Time-series-analysis
This repository contains two applied time series analysis (TSA) projects using real-world datasets. The aim is to explore different forecasting techniques, assess model performance, and gain hands-on experience with statistical modeling in R.

📌 Project 1: Gold Price Forecasting

-Objective:

To explore time series modeling on daily gold prices and test whether the series follows a random walk process.

-Methods:

->Data Preprocessing: Converted raw gold price data into a time series format.

->Stationarity Testing: Augmented Dickey-Fuller (ADF) test confirmed non-stationarity.

->Differencing: Applied first-order differencing to achieve stationarity.

->ACF & PACF Analysis: Investigated lag structures.

->Modeling: Fitted ARIMA models via auto.arima.

->Key Finding: Gold prices largely behaved like a random walk, with limited short-term predictive power


📌 Project 2: Weekly Fuel Price Forecasting (For Euro-Super 95 Petrol)

Objective

To forecast weekly Euro-Super 95 petrol prices using an appropriate model .I tried different models like exponential smoothing, SARIMA and ARIMA models and I evaluated their predictive performance.

Methods
Dataset: Weekly European fuel prices from 2005 to 2021.

Subset: Focused only on Euro-Super 95 petrol.

Preprocessing: Converted survey dates into time series format.

Stationarity Testing: Used ADF test before/after differencing.

Exploratory Analysis: Trend, seasonality, and volatility checks.

Modeling:

Examined ACF and PACF for guidance.

Fitted ARIMA(2,1,2).

Residual diagnostics confirmed white noise (Ljung-Box p > 0.05).

Evaluation: RMSE, MAE, and MAPE for forecasting accuracy.

Examined exponential smoothing model,ARIMA and SARIMA models

