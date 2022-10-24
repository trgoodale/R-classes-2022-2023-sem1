#Load the dataset

data(mtcars)

help(mtcars)

#Look at it

head(mtcars)

summary(mtcars)

# Change things to factors

mtcars$vs <- factor(mtcars$vs, levels=c(0,1), labels=c('V-shaped', 'straight'))
mtcars$am <- factor(mtcars$am, levels=c(0,1), labels=c('automatic', 'manual'))

summary(mtcars)

# Crosstabulations

table(mtcars$vs, mtcars$am)
table(mtcars$vs, mtcars$cyl)

# Create some summaries

# Could use tapply

tapply(mtcars$mpg, mtcars$am, mean)

library(tidyverse)

mtcars %>% group_by(am) %>% summarise(mean(mpg))

mtcars %>% group_by(am,vs) %>% summarise(mean(mpg))

mtcars %>% group_by(am,vs) %>% summarise(n(),mean(mpg))

mtcars %>% group_by(am,vs) %>% summarise(count=n(),mpg=mean(mpg))

# Could also get different summaries
mtcars %>% 
  group_by(am,vs) %>% 
  summarise(count=n(),
            mpg=mean(mpg),
            sd=sd(mpg))

#  What happened?  Well, it tried to take the sd of the new "mpg" variable 
#  rather than the orginal one

mtcars %>% 
  group_by(am,vs) %>% 
  summarise(count=n(),
            mpg_mean=mean(mpg),
            mpg_sd=sd(mpg))

# There's lots more that can be done with tidyverse functions
# See https://dplyr.tidyverse.org/

# Let's try some graphical summaries

hist(mtcars$mpg)

hist(mtcars$mpg, breaks=10)

plot(density(mtcars$mpg))

boxplot(mtcars$mpg)

boxplot(mpg ~ cyl, data=mtcars)

plot(mtcars$cyl, mtcars$mpg)

plot(mpg ~ cyl, data=mtcars)

plot(mtcars$cyl)


barplot(mtcars$cyl)

counts <- table(mtcars$cyl)

barplot(counts)

pairs(mtcars)

pairs(~ mpg + cyl + disp + wt, data=mtcars)

# The next session will be all about using the ggplot2 package for producing
# plots and charts

# Now some testing

mtcars$mpg[mtcars$am=="automatic"]

t.test(mtcars$mpg[mtcars$am=="automatic"], mtcars$mpg[mtcars$am=="manual"])

# Simpler to use a formula

t.test(mpg ~ am, data=mtcars)

# We should have checked for normality

shapiro.test(mtcars$mpg[mtcars$am=="automatic"])

mtcars %>% 
  group_by(am) %>% 
  summarise(n=n(),
            w=shapiro.test(mpg)$statistic,
            p=shapiro.test(mpg)$p.value)

qqnorm(mtcars$mpg[mtcars$am=="automatic"])
qqline(mtcars$mpg[mtcars$am=="automatic"])

qqnorm(mtcars$mpg[mtcars$am=="manual"])
qqline(mtcars$mpg[mtcars$am=="manual"])

# # We may also want skewness and kurtosis
# 
# library(moments)
# 
# mtcars %>% 
#   group_by(am) %>% 
#   summarise(n=n(),
#             skewness(mpg),
#             kurtosis(mpg)-3)

var.test(mpg ~ am, data=mtcars)

t.test(mpg ~ am, data=mtcars, var.equal=TRUE)

res <- t.test(mpg ~ am, data=mtcars, var.equal=TRUE)

res$conf.int

wilcox.test(mpg ~ am, data=mtcars)

chisq.test(mtcars$cyl, mtcars$am)

res <- chisq.test(mtcars$cyl, mtcars$am)

res

res$expected

fisher.test(mtcars$cyl, mtcars$am)

aov(mpg~cyl, data=mtcars)

res <- aov(mpg~cyl, data=mtcars)

summary(res)

TukeyHSD(res)

mtcars$cyl <- factor(mtcars$cyl)

res <- aov(mpg~cyl, data=mtcars)

summary(res)

TukeyHSD(res)

library(car)

leveneTest(mpg ~ cyl, data=mtcars)

qqnorm(res$residuals)
qqline(res$residuals)

shapiro.test(res$residuals)

res <- kruskal.test(mpg ~ cyl, data=mtcars)

summary(res)

pairwise.wilcox.test(mtcars$mpg, mtcars$cyl)

pairwise.wilcox.test(mtcars$mpg, mtcars$cyl, p.adjust.method = "bonf")

