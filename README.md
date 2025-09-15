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
