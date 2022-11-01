# Create some data

x <-  rnorm(20, 5, 4)

y <- 2 + 5*x

plot(x,y)

# Let's be more realistic, and add some random noise

y <- 2 + 5*x + rnorm(20,0,2)

plot(x,y)

x

y

# Put these data into a data frame
df <- data.frame(x, y)

df

# Let's generate a model

lm1 <- lm(y ~ x, data=df)

summary(lm1)

resid(lm1)

predict(lm1)

# Let's take a look at our predictions compared the our "measured" data
library(ggplot2)

ggplot(data=df, aes(x)) +
  geom_point(aes(y=y)) +
  geom_point(aes(y=predict(lm1)), colour="red") +
  geom_linerange(aes(ymin=predict(lm1), ymax=y), colour="green", size=1)

# Looking again at the summary
summary(lm1)

# We can make it nicer using the broom package
broom::glance(lm1)

broom::tidy(lm1)

# If you don't want to use broom, you can use base R too
coefficients(lm1)

coefficients(lm1)[1]

coefficients(lm1)[2]

coefficients(lm1)["x"]

# We can also get confidence intervals
confint(lm1)

broom::tidy(lm1, conf.int=TRUE)

# And standardised paramaters
parameters::model_parameters(lm1, standardize="refit")

# We can get diagnostic plots

plot(lm1)

# 1. The predicted values from the model (x-axis) against the residuals (y-axis). Use this plot to look for linearity and homoscedasticity.
# 2. A Q-Q plot of the standardized residuals. Use this plot to look for normality of residuals.
# 3. The predicted values from the model (x-axis) against the square root of the standardized residuals (y-axis). This is a variant of plot 1 and is used to look for linearity and homoscedasticity.
# 4. The case number (x-axis) against the Cooks distance (y-axis). This plot can help to identify influential cases (cases with large values for Cooks distance).
# 5. The leverage value for each case (x-axis) against the standardized residual (y-axis). This plot is used to identify influential cases and outliers. Leverage values indicate the influence of an individual case on the model and are related to Cook’s distance.
# 6. The leverage value for each case (x-axis) against the corresponding Cooks distance (y-axis). This plot is used to identify influential cases and outliers.

plot(lm1, which=1:6)

# Now let's do this with a real dataset

mtcars

plot(mpg ~ wt, data=mtcars)

plot(mpg ~ drat, data=mtcars)

# We can get a scatter matrix

# Using base R

plot(mtcars[,c('wt', 'drat', 'mpg')])

# Or, better, using GGally
GGally::ggscatmat(mtcars,
                  columns=c("wt", "drat", "mpg"))

lm2 <- lm(mpg ~ wt, data=mtcars)

broom::glance(lm2)

broom::tidy(lm2, conf.int=TRUE)

summary(lm2)

# Let's add a new second variable

lm3 <- lm(mpg ~ wt + drat, data=mtcars)

summary(lm3)

# Test if this model is any better

anova(lm2, lm3)

mtcars

# Could we use any other variables, how about hp

GGally::ggscatmat(mtcars,
                  columns=c("wt", "drat", "hp","mpg"))


lm4 <- lm(mpg ~ wt + hp, data=mtcars)

summary(lm4)

anova(lm2,lm4)

plot(lm4)

# We can also put factors into the linear model

mtcars$am <- factor(mtcars$am, levels=c(0,1), labels=c("auto", "manual"))

mtcars$vs <- factor(mtcars$vs, levels=c(0,1), labels=c("v-shaped", "straight"))

# Include the interaction
lm5 <- lm(mpg~am*vs, data=mtcars)

summary(lm5)

anova(lm5)

# Suppose we wanted to have three factors, but not all their interactions
lm(mpg~gear + am + vs + am:vs + gear:am + gear:vs)