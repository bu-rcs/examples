# There are two base time types: POSIXct and POSIXlt. 
#   "ct" - calendar time, it stores the number of seconds since the origin. 
#   "lt" - local time, keeps the date as a list of time attributes.

#-----------------------------
#
# Functions to convert between character representations and objects of classes "POSIXlt" and "POSIXct": 
#
#-----------------------------

curr.time <- Sys.time()  # get current date and time
curr.date <- Sys.Date()  # get current date 
str(curr.time)           # view the structure of the variable
attributes(curr.time)    # view attributes of the variable

# some systems do not have timezone set up
Sys.timezone()


# convert character string to POSIXlt
t1=strptime("2018-03-29 13:30:00", "%Y-%m-%d %H:%M:%S")
str(t1)           
attributes(t1)    
attr(t1,"zone")  # get value of a specific attribute


t.date.str = c("2018/03/29")
t.time.str = c("13:30:00")
t.date.time.str = c("2018/03/29 13:30:00")


( ct.date = as.POSIXct(t.date.str ,format="%Y/%m/%d") )  # EDT is used as a default time zone (on the SCC cluster)
( ct.date.cdt = as.POSIXct(t.date.str ,format="%Y/%m/%d", tz="CDT" ) ) 

( ct.time = as.POSIXct(t.time.str ,format="%H:%M:%S") )  # current date is added if time is not specified

( ct.date.time = as.POSIXct(t.date.time.str ,format="%Y/%m/%d %H:%M:%S") )  


# POSIXct is useful to convert to epoch time (number of seconds since 1970-01-01)
as.numeric(ct.date)
as.numeric(ct.date.cdt)  # notice the difference for epoch time for same time in different zones


# POSIXlt 
( lt.date = as.POSIXlt(t.date.str ,format="%Y/%m/%d") )  
( lt.time = as.POSIXlt(t.time.str ,format="%H:%M:%S") )  
( lt.date.time = as.POSIXlt(t.date.time.str ,format="%Y/%m/%d %H:%M:%S") )  


# format: convert time object into a character string using specific formatting
( formatted.time <- format(Sys.time(), "%a %b %d %X %Y") )
# %a - abbreviated weekday name        %A - full weekday name
# %b - abbreviated month               %B - full month name

# %c - Locale-specific on output, "%a %b %e %H:%M:%S %Y" on input.
# %C - Century (00–99)

# %d - Day of the month as decimal number (01–31).
# %D - Date format such as %m/%d/%y
# %e - Day of the month as decimal number (1–31), with a leading space for a single-digit number.
# %F - %Y-%m-%d

# %H - Hours as decimal number (00–23)
# %I - Hours as decimal number (01–12)

# %j - Day of year as decimal number (001–366)
# %m - Month as decimal number (01–12).
# %M - Minute as decimal number (00–59).
# %n - Newline on output, arbitrary whitespace on input.
# %p - AM/PM indicator in the locale.
# %R - Same as %H:%M
# %S - Second as integer (00–61)
# %t - Tab on output, arbitrary whitespace on input.
# %T - Same as %H:%M:%S
# %u - Weekday as a decimal number (1–7, Monday is 1).
# %U - Week of the year as decimal number (00–53) using Sunday as the first day 1 of the week (and typically with the first Sunday of the year as day 1 of week 1).
# %V - Week of the year as decimal number (01–53)
# %w - Weekday as decimal number (0–6, Sunday is 0).
# %W - Week of the year as decimal number (00–53) using Monday as the first day of week (and typically with the first Monday of the year as day 1 of week 1). The UK convention.
# %x - Date. Locale-specific on output, "%y/%m/%d" on input.
# %X - Time. Locale-specific on output, "%H:%M:%S" on input.
# %y - Year without century (00–99). 
# %Y - Year with century. 


# Extracting infomration from POSIXlt objects
weekdays(lt.date.time)
months(lt.date.time)
quarters(lt.date.time)
# Other components such as the day of the month or the year are very easy to compute: 
# just use as.POSIXlt and extract the relevant component using format option
format(lt.date.time, format="%d")  # extract date

#use unclass() function to extract components from POSIXlt object
unclass(t1)
unclass(t1)$zone
unclass(t1)$mon   # 011: months after the first of the year.
unclass(t1)$year  # years since 1900
unclass(t1)$isdst # daylight saving time flag

#-----------------------------
#
# Date class in R
#
#-----------------------------

# create a date (calendar dates). 
# If format is not specified it will try "%Y-%m-%d" then "%Y/%m/%d"
d1 <- as.Date("2018-03-29")

# specify the format ( you can also specify time zone using tz argument as usual) 
d1<- as.Date("03/29/2018", format = "%m/%d/%Y")
weekdays(d1)

# create a sequence of dates
seq(as.Date("2018/1/1"), by = "month", length.out = 12)

# difference in time
difftime(as.Date("2018/1/1"), as.Date("2018/03/29"))

# Subtract Date objects
Sys.Date() - as.Date("2018-01-01")
difftime(Sys.Date(), as.Date("2018-01-01"), units = "weeks") # units could be “auto”, “secs”, “mins”, “hours”, “days”, “weeks”


#---------------------------
#
# chron package
#
#---------------------------
library(chron)
dts <- dates(c("02/21/18", "02/28/18", "03/14/18", "03/21/18", "03/28/18"))
tms <- times(c("23:03:20", "22:29:56", "01:03:30", "18:21:03", "16:56:26"))
dts.tms <- chron(dates = dts,  times = tms)

# dts.tms object can be used to add or subtract values
dts.tms - 30 # subtract 30 days

# Find time passed between the first and the last value in the vector
dts.tms[5] - dts.tms[1]
sort(dts.tms, decreasing = TRUE)

# compare with specific date
which( dts.tms > "03/01/18" )

# summary and other statistical functions
summary(dts.tms)
mean(dts.tms)

# This can be useful to group some dates by month (for plotting purpose for example)
cut(dts.tms, "months")
boxplot( runif(5) ~ cut(dts.tms, "months"))


#extract dates only:
dates(dts.tms)

# get days of the week
day.of.week(3, 29, 2018)

month.day.year(0)  # the beginning of time

#format chron time (if we want for example 4-digit year)
format(dts.tms, c("yy/m/d", "h:m:s"), sep = " ", enclose = c("", ""))


#---------------------
#
#  lubridate package 
#       Note: it masks various functions from base and chron packages!
#
#---------------------
library(lubridate)

now()
today()

# am or pm?
am( now() )

t2 <- ymd_hms("2018-03-29 13:30:00")
t3 <- mdy_hms("03/29/2018 13:30:00")
# There are many other functions, like dmy_h(), dmy_hm(), ydm_*() etc.

# Create sequences:
t2 + 1:30  # add seconds
t2 + days(1:30)
t2 - years(48)

# set month (year or day)
month(t2)
month(t2) <- 4
t2

# check if  an event occured during specific time interval
now() %within%  interval(ymd("2016-09-01"), ymd("2020-05-30"))


# side by side example of POSIXlt and lubridate approaches:
date1 <- as.POSIXct("29-03-2018", format = "%d-%m-%Y")
date2 <- dmy("29-03-2018")

# exctract month info
as.numeric(format(date1,"%m"))
as.POSIXlt(date1)$mon + 1
month(date2)

# subtract one day
seq(date1, length=2, by = "-1 day")[2]
date2 - days(1)


# manipulating
date3 <- now()
year(date3)
# year()   - Year
# month()  - Month
# week()   - Week
# yday()   - Day of year
# mday()   - Day of Month
# wday()   - Day of week
# hour()   - Hour
# minute() - Minute
# second() - Second
# tz()     - Time zone


# Some other useful functions
days_in_month(date3)
days_in_month(month(date3) -1 )

tt <- seq.Date(as.Date("2018-03-29"), by = "year", length.out = 2)
pretty_dates(tt,12)

quarter(date3)
semester(date3)
semester(date3, with_year = TRUE)

# change the date to the last day of the previous month or the first day of the current month)
rollback(date3)
rollback(date3, roll_to_first = TRUE, preserve_hms = FALSE)
int <- interval(ymd("1994-08-22"), now())
time_length(int, "year")  # how many years is the person born on August 22, 1994


#------------------------------------
# 
# Time series in R
#
#------------------------------------
ts(1:10, frequency = 4, start = c(1959, 2)) # 2nd Quarter of 1959
# The format is ts(vector, start=, end=, frequency=) 
#     where start and end are the times of the first and last observation and 
#           frequency is the number of observations per unit time:
#           (1=annual, 4=quartly, 12=monthly, etc.).


# Number of ... in the past 2 years
n <- c(13,57,91,78,34,58,12)
n.ts <- ts(n, frequency = 12, start = c(2017, 9))
n.ts
plot(n.ts)


library(forecast)
#attach a dataset 
data(EuStockMarkets)
str(EuStockMarkets)
head(EuStockMarkets)


#Let's exctract first column
sm <- ts(EuStockMarkets[,1], frequency = 365, start = c(1991, 1))
plot.ts(sm)



#Each Data point in the time series is either
# Y(t) = S(t) + T(t) + e(t)
#     or
# Y(t) = S(t) * T(t) * e(t), 
# where
#     S(t) - seasonality
#     T(t) - trend
#     e(t) - error

# Note: multiplicative time series can be converted to additive useing log() 
de.sm.m <- decompose(sm, type= "mult")
plot(de.sm.m)

de.sm.a <- decompose(sm, type= "additive")
plot(de.sm.a)

# stl() function comes from forecast package
stl.sm <- stl(sm, s.window = "periodic")
summary(stl.sm)
str(stl.sm)  # structure of the object


# De-seasonalizing throws insight about the seasonal pattern in the time series 
# and helps to model the data without the seasonal effects.

# Attach AirPassangers dataset. It's already coming as a TS object
data(AirPassengers)
str(AirPassengers)
start(AirPassengers)
end(AirPassengers)

#Plot the data
plot(AirPassengers)  # plot original data
abline(reg=lm(AirPassengers~time(AirPassengers)))

#aggregate the cycles and display a year on year trend
plot(aggregate(AirPassengers,FUN=mean))

cycle(AirPassengers)
boxplot(AirPassengers~cycle(AirPassengers))


ap.de <- stl(AirPassengers,"periodic")  # decompose
str(ap.de)
ap.sa <- seasadj(ap.de)  # deseasonilize
plot(ap.sa, type = "l")
seasonplot(ap.sa, 
           s = 12,            # seasonal frequency of x 
           col = rainbow(12), 
           year.labels=TRUE, 
           main = "Airpassengers")


# Test if TS is staionary
# - The mean value of time-series is constant over time, which implies, the trend component is nullified.
# - The variance does not increase over time.
# - Seasonality effect is minimal.

# A p-Value of less than 0.05 in adf.test() indicates that it is stationary.
library(tseries)
adf.test(AirPassengers) # p-value < 0.05 indicates the TS is stationary
kpss.test(AirPassengers)

# another approach
#1. There is a trend component which grows the passenger year by year.
#2. There looks to be a seasonal component which has a cycle less than 12 months.
#3. The variance in the data keeps on increasing with time.
# We know that we need to address two issues before we test stationary series. One, we need to remove unequal variances. We do this using log of the series. Two, we need to address the trend component. We do this by taking difference of the series. Now, let’s test the resultant series.

adf.test(diff(log(AirPassengers)), alternative="stationary", k=0)

# acf plot
# find the right parameters to be used in the ARIMA model
acf(log(AirPassengers))
pacf(diff(log(AirPassengers)))

#prediction with ARIMA package
(fit <- arima(log(AirPassengers), c(0, 1, 1),seasonal = list(order = c(0, 1, 1), period = 12)))
pred <- predict(fit, n.ahead = 10*12)
ts.plot(AirPassengers,2.718^pred$pred, log = "y", lty = c(1,3))


#----------------------------
#
# ts.plot() and plot.ts()
#
#----------------------------
plot.ts(AirPassengers)
plot.ts(sm)
ts.plot(ts(1:length(AirPassengers), frequency = 12, start = c(1949, 1)), 
        AirPassengers, 
        col=c("forestgreen","brown"), 
        main="Two time series")



#---------------------
#
# tslm() function from forecast package
#
#------------------------
fit <- tslm(AirPassengers ~ trend + season)
plot(forecast(fit, h=20))

#---------------------
#
#   dynlm package
#
#--------------------
library(dynlm)
data("UKDriverDeaths", package = "datasets")
uk <- log10(UKDriverDeaths)
dfm <- dynlm(uk ~ L(uk, 1) + L(uk, 12))
dfm

## explicitly set start and end
dfm <- dynlm(uk ~ L(uk, 1) + L(uk, 12), start = c(1975, 1), end = c(1982, 12))
dfm

## remove lag 12
dfm0 <- update(dfm, . ~ . - L(uk, 12))
anova(dfm0, dfm)

## add season term
dfm1 <- dynlm(uk ~ 1, start = c(1975, 1), end = c(1982, 12))
dfm2 <- dynlm(uk ~ season(uk), start = c(1975, 1), end = c(1982, 12))
anova(dfm1, dfm2)
plot(uk)
lines(fitted(dfm0), col = 2)
lines(fitted(dfm2), col = 4)

## regression on multiple lags in a single L() call
dfm3 <- dynlm(uk ~ L(uk, c(1, 11, 12)), start = c(1975, 1), end = c(1982, 12))
anova(dfm, dfm3)

## Examples 7.11/7.12 from Greene (1993)
data("USDistLag", package = "lmtest")
dfm1 <- dynlm(consumption ~ gnp + L(consumption), data = USDistLag)
dfm2 <- dynlm(consumption ~ gnp + L(gnp), data = USDistLag)
plot(USDistLag[, "consumption"])
lines(fitted(dfm1), col = 2)
lines(fitted(dfm2), col = 4)

if(require("lmtest")) encomptest(dfm1, dfm2)
###############################
## Time Series Decomposition ##
###############################
## airline data
data("AirPassengers", package = "datasets")
ap <- log(AirPassengers)
ap_fm <- dynlm(ap ~ trend(ap) + season(ap))
summary(ap_fm)
## Alternative time trend specifications:
##   time(ap)                  1949 + (0, 1, ..., 143)/12
##   trend(ap)                 (1, 2, ..., 144)/12
##   trend(ap, scale = FALSE)  (1, 2, ..., 144)
## Exhibit 3.5/3.6 from Cryer & Chan (2008)
if(require("TSA")) {
  data("tempdub", package = "TSA")
  td_lm <- dynlm(tempdub ~ harmon(tempdub))
  summary(td_lm)
  plot(tempdub, type = "p")
  lines(fitted(td_lm), col = 2)


# Links to explore:
# http://r-statistics.co/Time-Series-Analysis-With-R.html
# https://www.analyticsvidhya.com/blog/2015/12/complete-tutorial-time-series-modeling/
# http://www.stat.pitt.edu/stoffer/tsa4/R_toot.htm