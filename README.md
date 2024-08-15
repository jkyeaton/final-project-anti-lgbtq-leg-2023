# 2023 Anti-LGBTQ legislation in the United States

Visualizations to describe how the introduction and passage of anti-LGBTQ legislation in the United States in 2023 is distributed by region, state, topic, and age of target, and to explore how the status of this legislation evolves over the course of 2023.

## Description

States across the United States are introducing a flood of anti-LGBTQ legislation. This legislation is attacking the rights of LGBTQ people in the United States and is unprecedented in its scale and the ages of the LGBTQ Americans it’s targeting. Increasingly, legislative attacks on the LGBTQ community in the United States are focused on restricting the rights of LGBTQ youth in schools, sports, and in regards to their access to healthcare. This portfolio explores this upward trend in the introduction of anti-LGBTQ legislation and aims to answer the question: “How is the introduction and passage of anti-LGBTQ legislation in the United States distributed by region, state, topic, and age of target, and how does the status of these bills evolve over the course of 2023?” 

This descriptive work is conducted primarily with [data from the ACLU](https://www.aclu.org/legislative-attacks-on-lgbtq-rights-2023?state=&impact=) on 2023 attacks on LGBTQ rights in United States state legislatures. 

## Methods: 

### Data Collection
This descriptive work is conducted primarily with [data from the ACLU](https://www.aclu.org/legislative-attacks-on-lgbtq-rights-2023?state=&impact=) on 2023 attacks on LGBTQ rights in the United States by state legislatures. This data can be found at the above link and the raw data scraped from this website can be found in this GitHub repository in the file named “aclu_lgbtq_data.csv”. This portfolio also employs a [Kaggle dataset](https://www.kaggle.com/datasets/omer2040/usa-states-to-region?resource=download) for linking state names to regions of the continental United States. This data can be found at the above link and the raw data downloaded from Kaggle can be found in this GitHub repository in the file named “states_regions.csv”.

### Data Cleaning
The ACLU dataset scraped from the ACLU website needed to be cleaned and restructured in order to be in a format that would be usable for visualizing the data. The code for this cleaning process can be found in the RMarkdown file “aclu_data_clean.Rmd” and involved creating a wide version of the dataset with one row for each of the 512 pieces of legislation introduced in 2023. Creating a wide version of the dataset involved rotating the list of topic areas covered in each bill into binary variables, rotating the various status updates for each bill into a single row, and separating out the date each piece of legislation’s status was updated into its own column in the format of a date. 

The Kaggle dataset connecting state names and regions of the U.S. required no cleaning and was able to be merged directly into the cleaned (wide and long) versions of the ACLU datasets.

## Getting Started

### Installations

* Download the latest binary distribution of R for your operating system from [CRAN](https://cran.rstudio.com/)

* Download the [latest version of RStudio](https://www.rstudio.com/products/rstudio/download/)

* In RStudio, install the following packages by running the code below:
```
install.packages(c("tidyverse", dplyr", "ggplot2", "urbnmapr, "shinydashboard", "sf", "readr", "mapview"))
```

### Clone repo locally

* Clone repo to local device by running the below code in your terminal:
```
$ git clone git@github.com:MACS40700/final-project-us_anti_lgbtq_leg.git
```

### Overview of contents of repo

This repo contains this README along with:

* Three (3) RMarkdown files
* One (1) R file
* Two (2) raw datasets
* Four (4) clean datasets
* Additional files supporting the Shiny dashboard

The three RMarkdown files and their contents are as follows:
* anti_lgbtq_leg_visual.Rmd: Contains the visualizations and narrative in this portfolio.
* app.R: Contains the code for running the Shiny dashboard with an interactive visualization. 
* anti_lgbtq_leg_paper.Rmd: Contains the paper to supplement the visualizations in this portfolio.
* aclu_data_clean.Rmd: Contains the code for cleaning and restructuring the raw data used for the visualizations in this portfolio. Reads in the raw datasets "aclu_lgbtq_data.csv" and "states_regions.csv"" and outputs the clean datasets "aclu_wide.csv" and "aclu_long.csv".



### How to run the program
* To view the visualizations contained in this portfolio, open the file "anti_lgbtq_leg_visual.Rmd" in RStudio, update the working directory in the first code block to the location of this repo on your local machine, and run each cell from the top of the file to the bottom of the file, in order. Alternatively, you could knit the file and then open it in your browser. This is ideal for viewing the shiny dashboard imbedded in the same document as the other visuals. 

```
setwd("<INSERT LOCATION OF THIS REPO ON YOUR LOCAL MACHINE>")
```

* To view the paper to supplement the visualizations in this portfolio, open the file "anti_lgbtq_leg_paper.md"

* Although the datasets do not need to be re-cleaned in order to recreate these visualizations, you could recreate the process of making the raw datasets into the clean datasets used for these visualizations by opening the file "jkyeaton_hw3_clean.Rmd" in RStudio, updating the working directory in the first code block to the location of this repo on your local machine, and running each cell from the top of the file to the bottom of the file, in order.
```
setwd("<INSERT LOCATION OF THIS REPO ON YOUR LOCAL MACHINE>")
```

## Authors

Jennifer Yeaton (jkyeaton@uchicago.edu)


## Acknowledgments

* [README-template](https://gist.github.com/DomPizzie/7a5ff55ffa9081f2de27c315f5018afc)
* [Setup-instructions](https://macs40700.netlify.app/setup/r/r/)
* [ACLU-data](https://www.aclu.org/legislative-attacks-on-lgbtq-rights-2023)
* [Urban-Institute-mapper](https://github.com/UrbanInstitute/urbnmapr)
