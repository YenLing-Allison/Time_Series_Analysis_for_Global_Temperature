---
title: "Time Series Analysis for Global Temperature"
subtitle: "Forecasting Analysis"
author: "YenLing (Allison) Liu"
date: '`r format(Sys.Date(), "%B %d, %Y")`'
output: pdf_document
---
suppressPackageStartupMessages({
    library(TSA)
    library(ggplot2)
    library(dplyr)
    library(forecast)
    library(tseries) #Only for the ADF test for testing stationarity
  })

# Time Series Data of Your Choice

## Background
####This project will allow you to apply the learned time series analysis 
####and forecasting skills to your own or favorite dataset. 
####This dataset could be your own data (from your interested hobby 
####groups, sports or video game records, previous jobs, past school 
####works, etc). Notice that, we DON'T require data disclosure so please 
####feel free to use your own data if you would like us to help you 
####understand the result. Or if you don't have any time series dataset, 
####please feel free to get one from the Internet. Any topics are welcome!

## Data Source 

###Please briefly describe the background of your dataset as I did for the Boston Crime Data in Homework 1 Problem 3, and its source (link) if you are using public data.

### Data source: https://datahub.io/core/global-temp?ref=hackernoon.com#readme
####Data are included from the GISS Surface Temperature (GISTEMP) analysis and the global component of Climate at a Glance (GCAG). Two datasets are provided: 1) global monthly mean and 2) annual mean temperature anomalies in degrees Celsius from 1880 to the present. 
####GISTEMP combined Land-Surface Air and Sea-Surface Water Temperature Anomalies [i.e. deviations from the corresponding 1951-1980 means]. Global-mean monthly […] and annual means, 1880-present, updated through most recent month.
####GCAG is global temperature anomaly data come from the Global Historical Climatology Network-Monthly (GHCN-M) data set and International Comprehensive Ocean-Atmosphere Data Set (ICOADS), which have data from 1880 to the present. These two datasets are blended into a single product to produce the combined global land and ocean temperature anomalies. The available timeseries of global-scale temperature anomalies are calculated with respect to the 20th century average.
####For this question, we are working on the monthly mean temperature anomalies in degree Celsius relative to a base period from 1880 to 2016 with GCAG data. 

data = read.csv('monthly_csv.csv')
data = data %>% filter(Source=='GCAG')

## Plot time series graph
plot(data[1644:1,3],type="o",ylab="Mean",main="Monthly mean temperature anomalies in degree Celsius relative to a base period from 1880 to 2016")

## Sample size = 1644
T = nrow(data)

##Training and testing dataset
####On the TRAINING set:
####Please (make transformations if necessary, and) use the `ADF test` to check for stationarity. Remove trend if necessary, and check the residuals for spurious regression (proof of random walk)
####Check ACF, PACF, and EACF for the order of the ARMA model (after differencing, if it has a random walk). Use AIC or BIC to select a final model from your candidate models. Report the orders.
df=ts(data[1644:1,3],start=1,end=1644)
df_train=ts(df[1:1634],start=1,end=1634)
df_test=ts(df[1635:1644],start=1635,end=1644)
####Since the p value is 0.01, which is significantly small, we conclude that the data is stationary

## Check for stationarity and fit the ARIMA model
adf.test(df_train)
Acf(df_train)                                   
Pacf(df_train)
eacf(df_train) 
df_fit=auto.arima(df_train,seasonal=F, d=0) 
df_fit
Arima(df_train,order=c(1,0,1))
####Final Model: ARIMA(4,0,0)

##Fit the model
####Fit your final model, write down the model (You may write down only the non-seasonal part, if you model contains seasonality).
####Report the significance of the model coefficients.
##$$Y_t = 0.56\cdot Y_{t-1} + 0.19 \cdot Y_{t-2} + 0.11 \cdot Y_{t-3} + 0.12 \cdot Y_{t-4} + e_t $$

##Forecast on the testing set. Provide RMSE. 
####Plot the fitted value, as well as $80\%$ and $95\%$ prediction intervals, superimposed on the raw data.
df_fit=auto.arima(df_train,seasonal=F, d=0) 
df_fit
arima_pred <- forecast(df_fit,h=10)

autoplot(arima_pred)+
  autolayer(df_test, series="Data") +
  autolayer(arima_pred$mean, series="Forecasts") +
  labs(title="Monthly mean temperature anomalies in degree Celsius relative to a base period", y="Mean")

library(Metrics)
rmse(arima_pred$mean,df_test)
####RMSE=0.197

##Please do the same forecasting task with LSTM. 
####Report the RMSE of the selected method.
####See the ipynb file
