# If you don't have ggplot installed, you'll first have to do so

install.packages("ggplot2")

# Then load the library

library(ggplot2)

# Let's look at some data.
# The ggplot package comes with the "mpg" dataset

data(mpg)

head(mpg)

help(mpg)

# In base R we might produce a plot using 

plot(hwy ~ displ, data=mpg)

# That's fine, although probably not publication quality.  There are many things
# which can be done in base R to improve it, however this class is on GGPlot2.
# GGPlot2 provides a consistent syntax to produce high quality plots.
#

#  The ggplot function by itself just creates an empty canvas
ggplot(data=mpg)

# We can add to this by using a "geom" which adds some geometric objects to the
# plot.
# The geom requires us to set some mappings from the data to certain aesthetics 
# of the plot, such as which data is used for the x and y axes
# These can either be set for every geom, by specifying the mapping in the 
# ggplot arguments, or set for each individual geom.

ggplot(data=mpg, mapping=aes(x=displ, y=hwy)) + geom_point()

# To save typing, it's good to know that the first two arguments to ggplot
# are the data and the mapping, and that the first two arguments to aes
# are the x and y mappings.

ggplot(mpg, aes(displ, hwy)) + geom_point()

# If we want smooth lines, we can use geom_smooth
ggplot(mpg, aes(displ, hwy)) + geom_smooth()

# We can have as many geoms as we want
ggplot(mpg, aes(displ, hwy)) + geom_smooth() + geom_point()

# We can even override the default mappings and use different data or variables
# in different geoms
ggplot(mpg, aes(displ, hwy)) + geom_smooth() + geom_point() +
  geom_point(aes(y=cty))

# We can also set other aesthetics such as colour, size and shape
ggplot(mpg, aes(displ, hwy)) + geom_smooth() + geom_point() +
  geom_point(aes(y=cty), col="red")

# In a script file it is nicer to put each part of the whole ggplot statement
# on its own line.  This more clearly illustrates how the whole figure is built
# up
ggplot(mpg, aes(displ, hwy)) + 
  geom_smooth() + 
  geom_point() +
  geom_point(aes(y=cty), col="red")

# If we include the colour, shape or size of points in the aes() call, they
# become data dependent

ggplot(mpg, aes(displ, hwy)) + 
  geom_point()

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class))

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(shape=class))

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(size=class))

# If you only have one geom, it doesn't matter where you put the mapping for the
# aesthetics

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class,
                 shape=drv,
                 size=cyl))

ggplot(mpg) + 
  geom_point(aes(displ, hwy,
                 col=class,
                 shape=drv,
                 size=cyl))


ggplot(mpg, aes(displ, hwy,
                col=class,
                shape=drv,
                size=cyl)) + 
  geom_point()


# If you have more than one geom, it can make a big difference where the 
# mapping is done.


# In this plot the colour, shape and size are set for the points, but not the 
# smoothed line

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class,
                 shape=drv,
                 size=cyl)) +
  geom_smooth()

# In this plot the colour, shape and size are set for the points, but only the 
# colour for the smoothed line
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class,
                 shape=drv,
                 size=cyl)) +
  geom_smooth(aes(col=class))

# This produces one line, which is black
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class,
                 shape=drv,
                 size=cyl)) +
  geom_smooth(col="black")

# This produces one line per class, all in black
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class,
                 shape=drv,
                 size=cyl)) +
  geom_smooth(aes(group=class), col="black")

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class)) +
  geom_smooth(aes(col=class))

# We can get a best-fit straight line
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class)) +
  geom_smooth(aes(col=class),
              method="lm")

# We can set the labels
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class)) +
  geom_smooth(aes(col=class),
              method="lm") +
  xlab("Displacement")

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class)) +
  geom_smooth(aes(col=class),
              method="lm") +
  xlab("Displacement (litres)") +
  ylab("Highway mileage (mpg)") +
  ggtitle("Highway mileage vs displacement grouped by type of vehicle")

# Or just use the lab() function to set them all
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class)) +
  geom_smooth(aes(col=class),
              method="lm") +
  labs(x="Displacement (litres)",
       y="Highway mileage (mpg)",
       title="Highway mileage vs displacement grouped by type of vehicle")

# We could facet by another variable
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class)) +
  geom_smooth(aes(col=class),
              method="lm") +
  facet_wrap(~ drv) +
  labs(x="Displacement (litres)",
       y="Highway mileage (mpg)",
       title="Highway mileage vs displacement grouped by type of vehicle")

# Or even by two variables
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(col=class)) +
  geom_smooth(aes(col=class),
              method="lm") +
  facet_grid(cyl ~ drv) +
  labs(x="Displacement (litres)",
       y="Highway mileage (mpg)",
       title="Highway mileage vs displacement grouped by type of vehicle")

# Let's investigate different placing of the "colour" mapping
ggplot(mpg, aes(displ, hwy, colour=class)) + 
  geom_point() +
  geom_smooth()

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour=class)) +
  geom_smooth()

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() +
  geom_smooth(aes(colour=class))

# As before, we could have different y variables

ggplot(mpg, aes(displ)) + 
  geom_point(aes(y=hwy), col="blue") +
  geom_smooth(aes(y=hwy), col="blue") +
  geom_point(aes(y=cty), col="red") +
  geom_smooth(aes(y=cty), col="red")

# There are many possible geoms

ggplot(mpg, aes(class)) +
  geom_bar()

ggplot(mpg, aes(class, fill=class)) +
  geom_bar()

# If we want to have bars representint the means, we can change the statistic
# used
ggplot(mpg, aes(class, fill=class)) +
  geom_bar(aes(y=hwy),
           stat="summary",
           fun="mean")

ggplot(mpg, aes(class, fill=class)) +
  geom_bar(aes(y=hwy),
           stat="summary",
           fun="mean") +
  facet_wrap(~ drv)

# For use in reports and papers you probably want to save the plot

ggsave("my_fantastic_plot.png")
