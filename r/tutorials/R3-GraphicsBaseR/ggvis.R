library(ggvis)

#=================================================================#
#The ggvis API is currently rapidly evolving. 
# We strongly recommend that you do not rely on this for production, but feel free to explore. 
#=================================================================#
#Some links with examples:
# ggvis.rstudio.com/
# ggvis.rstudio.com/cookbook.html
#=================================================================#

head(mtcars)

#basic scatterplot
ggvis(data = mtcars, ~mpg, ~wt, fill := "red")
ggvis(data = mtcars, ~mpg, ~wt, fill = ~cyl)

# ggvis has a functional interface: every ggvis function takes a ggvis
# an input and returns a modified ggvis as output.
layer_points(ggvis(mtcars, ~mpg, ~wt))

# To make working with this interface more natural, ggvis imports the
# pipe operator from magrittr. x %>% f(y) is equivalent to f(x, y) so
# we can rewrite the previous command as
mtcars %>% ggvis(~mpg, ~wt) %>% layer_points()

# For more complicated plots, add a line break after %>%
mtcars %>%
  ggvis(~mpg, ~wt) %>%
  layer_points() %>%
  layer_smooths()

# Add a confidence interval for the model
mtcars %>%
  ggvis(~mpg, ~wt) %>%
  layer_points() %>%
  layer_smooths(se=TRUE)

#Scatter plot with grouping:
mtcars %>%
  ggvis(~mpg, ~wt) %>%
  layer_points(fill= ~factor(cyl))

# Now add linear model with confidence interval
mtcars %>%
  ggvis(~mpg, ~wt) %>%
  layer_points(fill= ~factor(cyl)) %>% 
  group_by(cyl) %>%
  layer_model_predictions(model = "lm", se=TRUE)
  
#Basic interactive controls:
mtcars %>%
  ggvis(~mpg, ~wt) %>%
  layer_smooths(span = input_slider(0.5, 1, value = 1)) %>%
  layer_points(size := input_slider(100,1000, value=100), fill= ~factor(cyl))
  

# Use slider and select box
mtcars %>%
  ggvis(x = ~wt) %>%
  layer_densities(
    adjust = input_slider(.1, 2, value = 1, step = .1, label = "Bandwidth adjustment"),
    kernel = input_select(
      c("Gaussian" = "gaussian",
        "Epanechnikov" = "epanechnikov",
        "Rectangular" = "rectangular",
        "Triangular" = "triangular",
        "Biweight" = "biweight",
        "Cosine" = "cosine",
        "Optcosine" = "optcosine"),
      label = "Kernel")
  )
