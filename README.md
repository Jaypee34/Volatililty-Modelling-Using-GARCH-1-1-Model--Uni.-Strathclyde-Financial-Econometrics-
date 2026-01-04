# Volatililty-Modelling-Using-GARCH-1-1-Model--Uni.-Strathclyde-Financial-Econometrics-
Introduction & Background

The S&P 500 is a market-capitalization-weighted index of the 500 largest U.S. companies, covering ~80% of U.S. market capitalization (~$52.2T as of 2024). Its nine largest companies represent 34.6% of the index. The S&P 500 is widely used for passive investing, benchmarking, and economic forecasting. Investors rely on it to assess firm performance, guide mutual funds, and inform empirical financial analyses. The index also influences market behavior through “Index Inclusion” effects.

Methodology

Data: 1,010 daily closing prices from Jan 1993–Dec 1996, sourced from Yahoo Finance.

Log-Returns: Calculated as 
𝑟
𝑡
=
ln
⁡
(
𝑃
𝑡
)
−
ln
⁡
(
𝑃
𝑡
−
1
)
r
t
	​

=ln(P
t
	​

)−ln(P
t−1
	​

) for stationarity, easier statistical handling, and scale-free analysis.

Stationarity Tests: Examined mean, variance, autocorrelation using Ljung-Box test; series found weakly stationary.

Distribution Analysis: Skewness, kurtosis, histograms, density plots, and Jarque-Bera test used to assess normality. Log-returns showed negative skew (-0.397) and heavy tails (kurtosis 2.11).

Risk Measurement: Value at Risk (VaR) calculated at 90%, 95%, and 99% confidence levels (-1.283%, -0.91%, -1.65%).

Time Series Modeling:

ARMA(3,2) fitted based on ACF, PACF, and AIC criteria. Residuals were independent; Ljung-Box confirmed no autocorrelation.

GARCH(1,1) modeled conditional variance, capturing volatility clustering over time; residuals showed ARCH effects.

Results

Price Trends: S&P 500 rose from ~$475 (1993–1995) to ~$750 by Jan 1996, indicating non-stationary price series.

Log-Returns: Stationary with mean 0.0544%, standard deviation 0.6058%, left-skewed, heavy-tailed, consistent volatility spread.

ARMA & GARCH Models:

ARMA(3,2) captured autocorrelation structure in log-returns.

GARCH(1,1) captured volatility clustering; conditional variance ranged 0.00002–0.00008, averaging 0.00005.

Model Diagnostics: Standardized residuals, Q-Q plots, and Ljung-Box tests confirmed adequacy; heavy tails indicate extreme event risk.

Discussion & Conclusion

The log-return series is stationary, with consistent variance and volatility. Returns are negatively skewed with heavy tails, violating normality assumptions. VaR analysis provides insights for risk management. ARMA(3,2) and GARCH(1,1) models effectively describe return dynamics and volatility but can be enhanced using higher-order or alternative GARCH models for improved prediction accuracy.
