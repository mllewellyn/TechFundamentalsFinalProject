imgDir <- "/Users/mllewellyn/Dropbox/RPI/Spring_2018/Tech_Fund/Final Project/plots/"

library(readr)
train <- read_csv("~/Dropbox/RPI/Spring_2018/Tech_Fund/Final Project/data/train.csv", 
                  col_types = cols(holiday = col_logical(), 
                                   season = col_factor(levels = c("1","2", "3", "4")),
                                   weather = col_factor(levels = c("1", "2", "3", "4")),
                                   workingday = col_logical())
)

levels(train$season) <- c("spring", "summer", "fall", "winter")

# These are descriptiors I created to make the data teasier to understand.
# Here are the true definitions of each level taken from here https://www.kaggle.com/c/bike-sharing-demand/data
# 
# 1: Clear, Few clouds, Partly cloudy, Partly cloudy 
# 2: Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist 
# 3: Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds 
# 4: Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog 
levels(train$weather) <- c("Good", "Fair", "Poor", "Bad")

View(train)

train_numeric <- train[c("temp", "atemp", "humidity", "windspeed", "casual", "registered", "count")]
train_factor <- train[c( "season", "holiday", "workingday", "weather")]

summary(train_numeric)
summary(train_factor)

png(paste(imgDir, "weather_boxplots.png", sep=""), width=1000, height=1000)
boxplot(train_numeric[c("temp", "atemp", "humidity", "windspeed")], main="Numeric Weather Vars")
dev.off()

png(paste(imgDir, "ridership_boxplots.png", sep=""), width=1000, height=1000)
boxplot(train_numeric[c("casual", "registered", "count")], main="Numeric Ridership Vars")
dev.off()


library(corrplot)
# look at the correlations
cor(train_numeric)
png(paste(imgDir, "corplot.png", sep=""), width=1000, height=1000)
corrplot(cor(train_numeric), method="circle")
dev.off()

# for(col in train_numeric) {
#   hist(col)
# }

library(car)
# Make a giant scatter plot matrix and see if anything jumps out. CPU time is less valuable than brain time.
# png(paste(imgDir, "scatterplotMatrix4000.png", sep=""), width=4000, height=4000)
# scatterplotMatrix(train)
# dev.off()

png(paste(imgDir, "scatterplotMatrix_numeric1500.png", sep=""), width=1500, height=1500)
scatterplotMatrix(train_numeric)
dev.off()



# =========== Modeling ==========

