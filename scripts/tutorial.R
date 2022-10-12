
# Load libraries

library(readxl)

# Some preliminaries


x <- 57

y <- x/3

cat("x is", x, "y is", y)

x <-  5

flag <- TRUE

name <- "Tom"

name2 <- 'Goodale'

l <- c(x, flag, name, name2)

l
length(l)

l[1]

l[2]

l[1:3]

l[c(1,3,4)]

seq(2,30,2)

l[-2]

l[-c(2,3)]

?c

x <- 101:150

x[c(23,37)]

length(x)

seq(1,50,2)

x[seq(1,50,2)]

x*2

x+7
x / 7
mean(x)

median(x)

summary(x)

x < 120

x[x<120]

7%%5
9%%5
23%%5

x %% 2

x %% 2 == 1

x[(x %% 2 == 1) | (x %%3 == 2)]

df <- data.frame(x = 1:50, type = rep(c("A", "B"),25))

df

summary(df)

df['x']

df['type']

df$x
df$type

df[23,]

df[,'type']

df$x[df$type == 'A']

df[df$type == 'A',]

rep(c("A","B"),10)

rep(c("A","B"),each=10)

summary(mtcars)

mtcars[mtcars$cyl==4,]

mtcars[mtcars$disp < 120,]

mtcars

head(mtcars, 10)

factor(mtcars$am)

mtcars$am <- factor(mtcars$am)

summary(mtcars)

mtcars$am <- factor(mtcars$am,
                    levels=c(0,1),
                    labels=c("Automatic", "Manual"))

head(mtcars, 10)

summary(mtcars)

mtcars[mtcars$mpg < 20, c('cyl', 'disp')]

str(mtcars)

mtcars$cylbycarb <- mtcars$cyl*mtcars$carb

str(mtcars)

# Load data

aqa_cars <- read_excel("data/AQA-AS-A-MATHS-LDS-2019-2020.xlsx",
sheet = "Car data", col_types = c("numeric",
"text", "numeric", "numeric", "text",
"numeric", "numeric", "numeric",
"numeric", "numeric", "numeric",
"numeric", "numeric", "numeric",
"skip"))

aqa_cars$Make <- factor(aqa_cars$Make)

aqa_cars$GovRegion <- factor(aqa_cars$GovRegion)

# Start the analysis

summary(aqa_cars)

