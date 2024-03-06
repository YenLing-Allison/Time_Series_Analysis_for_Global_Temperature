# Time_Series_Analysis_for_Global_Temperature
Forecast 10 months global temperature for 2016  
Repository:https://github.com/YenLing-Allison/Time_Series_Analysis_for_Global_Temperature  

# Problem Description
This project will allow you to apply the learned time series analysis and forecasting skills to your own or favorite dataset.  
General Requirements:  
1. Please make sure the time series contains at least $T=500$ time points.
2. Please make sure the data are REAL data, not simulated ones. Given there're plenty of available datasets online, there's no motivation to use simulated data.
3. Also make sure the data are non-trivial (having sufficient data variation and possibly a trend). For example, it is trivial to analyze a series of 500 zeros, denoting something like "the number of spacecrafts I owned in the past 1.5 years".

# Data Source
Data Source: https://datahub.io/core/global-temp?ref=hackernoon.com#readme  
Data are included from the GISS Surface Temperature (GISTEMP) analysis and the global component of Climate at a Glance (GCAG).  
Two datasets are provided: 1) global monthly mean and 2) annual mean temperature anomalies in degrees Celsius from 1880 to the present.  
GCAG is global temperature anomaly data come from the Global Historical Climatology Network-Monthly (GHCN-M) data set and International Comprehensive Ocean-Atmosphere Data Set (ICOADS), which have data from 1880 to the present.  
For this project, we are working on the monthly mean temperature anomalies in degree Celsius relative to a base period from 1880 to 2016 with GCAG data.  

# Analysis Process
1. Training and testing data split
2. Check for stationarity
   * ADF test
3. Fit the model   
   * ACF test
   * PACF test
   * EACT test
   * auto.arima 
4. Forecast 
   * Arima model
   * LSTM
   * XGBoost
5. Evaluation 
   * RMSE

  # Result
*Final model: ARIMA(4,0,0)*
Model | RMSE |
--- | --- | 
ARIMA | 0.197 | 
LSTM | 0.207 | 


  

