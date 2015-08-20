---
title: "README"
output: html_document
---

README document for Tidy Data Set - Course Project #2
================================================

This is a README file that explains how to use the data set and how all of the scripts work together

Data Source
-------------
"Human Activity Recognition Using Smartphones Data Set" Version 1.0

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

How to Use Sript
-------------------

1. Download original data from source as indicated above and put into a folder on your local drive. You'll have a ```UCI HAR Dataset``` folder.
2. Set ```UCI HAR Dataset``` as your working drive using ```setwd()``` function in RStudio.
3. Run ```source("run_analysis.R")```, and a new independent data set names ```tidy_data.txt``` will be created in your working directory.


```run_analysis.R``` uses the following libraries: ```data.table``` library and requires ```require(Utils)```
