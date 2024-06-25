## ----------------------------------------------------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyverse)

library(stringr)


## ----------------------------------------------------------------------------------------------------------
tempChanges <- read.csv("TemperatureChanges.csv", fileEncoding = "latin1") 
burntArea <- read.csv("AnnualAreaBurnt.csv")


## ----------------------------------------------------------------------------------------------------------
head(tempChanges, 3)


## ----------------------------------------------------------------------------------------------------------
str(burntArea) # the 'Year' variable is an int, which will need to be converted later


## ----------------------------------------------------------------------------------------------------------
tempChanges <- tempChanges %>%
               rename(country = Area, 
                      months = Months, 
                      element = Element,
                      unit = Unit)
burntArea <- burntArea %>%
             rename(year = Year, 
                    country = Entity, 
                    area = `Annual.area.burnt.by.wildfires`)


## ----------------------------------------------------------------------------------------------------------
tempChanges <- tempChanges %>% 
               filter(element == "Temperature change", # Keep only `Temperature change` rows
                      unit =="°C") # Keep only `°C` rows


## ----------------------------------------------------------------------------------------------------------
tempChanges <- tempChanges %>%
               select(-element, -unit) # Keep everything except these two features


## ----------------------------------------------------------------------------------------------------------
burntArea <- burntArea %>%
             select(-Code) %>%
             mutate(year = as.character(year)) # Transform `year` into a categorical feature


## ----------------------------------------------------------------------------------------------------------
tempChanges <- tempChanges %>% 
               pivot_longer(cols=starts_with('Y'), # `pivot_longer()` turns "wide" data into "long" data
                            names_to='year', 
                            values_to='temp.changes')

head(tempChanges, 3)


## ----------------------------------------------------------------------------------------------------------

# Utilize a regex substitution to match the prefix and replace it with ""
remove_prefix <- function(prefix, word) { 
    pattern <- paste0("^", prefix)
    return(sub(pattern, "", word))
}

# Apply function to all rows
tempChanges <- tempChanges %>% mutate(year = remove_prefix('Y', year))


## ----------------------------------------------------------------------------------------------------------
tempChanges <- tempChanges %>% 
               group_by(country, year) %>%
               summarise("median temp change" = median(temp.changes)) # Compute median for all values

head(tempChanges, 3)


## ----------------------------------------------------------------------------------------------------------
ggplot(burntArea) +
  aes(x = year, y = area) +
  geom_col(fill = "#866FE4") +
    labs(
    x = "Year",
    y = "Area Burnt",                      
    title = "Area Burnt by Year", 
    caption = "Source: burntArea.csv"  
  ) +
  theme_minimal()


## ----------------------------------------------------------------------------------------------------------
area_burnt_graph <- ggplot(tempChanges) +
  aes(x = year, y = `median temp change`) +
  geom_col(fill = "#FF4614") +
  labs(
    x = "Year",
    y = "Temperature Changes",                      
    title = "Temperature Changes by Year", 
    caption = "Source: tempChanges.csv"  
  ) +
  theme_minimal()

area_burnt_graph + theme(axis.text.x=element_blank(), 
      axis.ticks.x=element_blank()
    )


## ----------------------------------------------------------------------------------------------------------
tempByArea <- inner_join(tempChanges, burntArea, by= c("country", "year"))


## ----------------------------------------------------------------------------------------------------------
temp_by_area_graph <- ggplot(tempByArea) +
  aes(x = `median temp change`, y = area, colour = as.numeric(year)) +
  geom_jitter(size = 3) +
  geom_smooth(se = FALSE) +
  scale_color_gradient(name = "Year") +
  labs(
    x = "Median Temperature Change",
    y = "Area",                      
    title = "Median Temperature Change by Area", 
    caption = "Source: tempByArea.csv"  
  ) +
  theme_minimal()

temp_by_area_graph


## ----------------------------------------------------------------------------------------------------------
tempChanges <- tempChanges %>% 
               filter(country == 'Northern America') %>%
               mutate(country = str_replace(country, 'Northern America', 'North America'))

AmericaTempByArea <- inner_join(tempChanges, burntArea, by= c("country", "year"))

## ----------------------------------------------------------------------------------------------------------
ggplot(AmericaTempByArea) +
  aes(x = year, y = `median temp change`, colour = area) +
  geom_boxplot(fill = "#112446") +
  scale_color_viridis_c(option = "magma", direction = 1) +
  labs(
    x = "Year",
    y = "Median Temperature Change",                      
    title = "Median Temperature Change and Area by Year", 
    caption = "Source: tempByArea.csv"  
  ) +
  theme_minimal()

