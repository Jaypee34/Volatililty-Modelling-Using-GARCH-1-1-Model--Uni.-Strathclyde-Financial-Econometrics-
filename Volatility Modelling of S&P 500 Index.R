#PART B: PROJECT ON FINANCIAL DATA MODELLING
----------------------------------------------------------------------

# Import the relevant libraries
library(TSA)
library(tseries)
library(tidyquant)
library(fBasics)
library(stats)
library(fUnitRoots)
library(fGarch)

set.seed(1)

# S&P500 Index Daily stock closing prices Downloaded from Yahoo Finance
# Import dataset from Yahoo Finance 

getSymbols("^GSPC", from = "1993-01-01",to = "1996-12-31", 
           warnings = FALSE, auto.assign = TRUE)
prices<- GSPC


# Time plot of S&P 500 index Daily Closing Prices
par(mfrow = c(1,1))
plot(prices$GSPC.Adjusted, xlab = "Time", ylab = "Daily Prices", 
     main = "Daily Stock Prices of S&P 500 Index", col="blue")


# Que. 1

# Daily stock returns of S&P500 Index 1st Jan,1993 to 31st Dec,1996

r<- diff(log(prices$GSPC.Adjusted))
r<-na.omit(r)



# Check for the Stationarity of the Time series data
# "Daily Stock Returns of S&P 500 Index

plot(r, xlab = "Time", ylab = "Daily Returns", 
     main = "Daily Stock Returns of S&P 500 Index", col="blue")

# Summary Statistics of Returns of S&P 500 index
basicStats(r)

# Jarque-Bera Test of Normality

jb_test <- jarque.bera.test(r)

print(jb_test)

# QUE.2 
# Distribution of Monthly Returns of the S&P 500 Index 

par(mfrow= c(1,2))
hist(r,main = " Histogram of Montly Returns( S&P500 Index)",
     xlab = "Monthly Returns", col="grey")
plot(density(r),main = " Density of Montly Returns( S&P500 Index)",
     xlab = "Monthly Returns",lwd= 1.5, col = "red")


#Calculation of Value at Risk for Var @ 99% ,Var @ 97.5% and 
# Var @ 95% confidence levels

quantile(r,probs=c(0.01,0.025,0.05))

# QUE.3 
#  Fitted Time Series Model 
# Plot of Autocorrelation Function (ACF)& Partial Autocorrelation 
# Function (PACF) of Monthly Returns of S&P 500 Index

par(mfrow= c(1,2))
acf(r, 15, main="ACF of Daily Returns of S&P 500 Index")
pacf(r,15,main="PACF of Daily Returns of S&P 500 Index" )

# Since the time series data is  weakly stationary,
# We use an ARMA (p,q) Model 


# Find the order Autoregressive[AR(p)] Model- we have AR(3)

ord1<- ar(r, method = "yule-walker")

# AIC for lag 0-15
ord1$aic

# This picks the correct order
ord1$order

# Perform Augmented Dickey-Fuller (ADF) Test

adfTest(r,lags=15,type=("ct"))

# Find the order Moving Average [MA(q)] Model- we have MA(2)
# From the ACF plot, lag 1 and 3 are significant series in the ACF plot 
# with 2 significant spikes

ma1<- arima(r, order = c(0,0,1))
ma2<- arima(r, order = c(0,0,2))
ma3<- arima(r, order = c(0,0,3))
ma1
ma2
ma3

# MA(2) appears to be the order with least AIC of -7441.6
# Fit the ARMA (3,0,2) Model 

fit1<- arima(r, order=c(3,0,2))
fit1

# # Diagnostics of of ARIMA (3,0,2) model
# plot of Standardized residuals, ACF, PACF and Q-Q plot 

par(mfrow = c(2,2))
acf(fit1$residuals, main = "ACF Residual")
pacf(fit1$residuals, main = " PACF of Residuals")
plot(fit1$residuals, main = " Plot of Standardized Residuals", col = "blue")
qqnorm(fit1$residuals)
qqline(fit1$residuals, col=2)

# Ljung-Box Test to check for autocorrelation of residuals

Box.test(fit1$residuals,lag=10,type="Ljung")

# QUE. 4
# Model to Describe the Volatility of Returns 
# In practice lower order GARCH models are used

# Fit an ARMA(3,2)+ GARCH (1,1) Model 

m1<- garchFit(~arma(3,2)+garch(1,1),data=r,trace=F)
summary(m1)

# Fit GARCH(1,1) model with student t-distribution

m2<- garchFit(~garch(1,1),data=r,trace=F,cond.dist="std")
summary(m2)

# Diagnostics of a ARMA(3,2) + GARCH (1,1) model 
# Plot of standardized residuals of ARMA(3,2) + GARCH (1,1) Model
# Obtain standardized residuals

res<- residuals(m1, standardize = T)
plot(res, type= "l",ylab = "Standardized Residual",col = "blue",
     main = "Plot of Standardized Residual of GARCH(1,1)")

# QQ Plot of standardized residuals

qqnorm(res)
qqline(res, col=2)



# Ljung-Box test to check the significance of the model
Box.test(res,20,type="Ljung")



# Diagnostics of a GARCH (1,1) model 
# Plot of standardized residuals of GARCH (1,1) Model
# Obtain standardized residuals

res<- residuals(m2, standardize = T)
plot(res, type= "l",ylab = "Standardized Residual",col = "blue",
     main = "Plot of Standardized Residual of GARCH(1,1)")


# Ljung-Box test to check the significance of the model
Box.test(res,20,type="Ljung")

# QQ Plot of standardized residuals

qqnorm(res)
qqline(res, col=2)

# The estimated conditional variances of the daily S&P 500 Index returns 

par(mfrow = c(1,1))

plot((fitted(g)[,1])^2,type = "l" ,ylab = "Conditional Variance", xlab= "Time", 
     col = "red", lwd = 0.3, main="Estimated Volatility of GARCH (1,1) Model" )
















