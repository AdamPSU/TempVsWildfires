---

# README

## Title: Investigating the Correlation Between Wildfires and Global Warming

### Author: Adam Torres Encarnacion

---

## Overview

This project aims to explore the correlation between annual land burned by wildfires and the steady rise in temperatures due to global warming. By analyzing historical data on temperature changes and wildfire occurrences, the study attempts to determine if there is a positive relationship between these two variables. The analysis is conducted using R and R Markdown, with extensive data wrangling and visualization techniques to uncover insights.

## Files

- `analysis.rmd`: The main R Markdown file containing the analysis code and narrative.
- `datasets/TemperatureChanges.csv`: Dataset containing temperature changes over the years.
- `datasets/AnnualAreaBurnt.csv`: Dataset containing annual areas burned by wildfires.
- `datasets/tempByArea.csv`: Dataset containing joined annual temperature changes and areas burned by wildfires. 

## Instructions

### Prerequisites

Ensure you have the following R packages installed:

```r
install.packages(c("dplyr", "ggplot2", "tidyr", "tidyverse", "stringr"))
```

### Running the Analysis

1. **Open RStudio**: Launch RStudio and open the `analysis.rmd` file.
2. **Load the Datasets**: Make sure the datasets `TemperatureChanges.csv` and `AnnualAreaBurnt.csv` are in the `datasets` folder.
3. **Run the Code**: Execute the chunks of code in the R Markdown file sequentially or knit the document to produce an HTML report.

### Data Wrangling

- **Renaming Columns**: Standardize column names for consistency.
- **Filtering Data**: Remove unnecessary columns and filter relevant data.
- **Transforming Data**: Pivot and reshape the data for easier analysis and visualization.

### Data Visualization

- **Bar Charts**: Visualize the distribution of burned areas and temperature changes over the years.
- **Scatterplot**: Examine the relationship between median temperature change and the area burned by wildfires.
- **Boxplots**: Analyze trends specific to the United States.

### Conclusion

The analysis revealed no significant correlation between rising temperatures and the annual land burned by wildfires. However, the study highlighted the continuous rise in global temperatures, emphasizing the importance of addressing global warming. The findings suggest that while the cause of wildfires remains complex, understanding climate change's broader impacts is crucial for future research.

## Conclusion

While the initial hypothesis of a positive correlation between global warming and wildfire occurrence was not supported by the data, the study provided valuable insights into temperature trends and their potential implications. Further research with more comprehensive datasets could help uncover more nuanced relationships and contribute to a better understanding of these environmental phenomena.

---

## Acknowledgments

Special thanks to STAT 184 at Pennsylvania State University for facilitating this project.

---
