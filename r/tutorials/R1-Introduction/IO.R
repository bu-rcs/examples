##
## =============  Input and Output of Datasets ==============
##
## R Tutorial
## Katia Oleinik, 2015, 2019
## Research Computing
## Boston University
##
## =======================================================

## ***********************
##    Read CSV file
## ***********************

# Read simple comma delimited file (csv) - assumes presence of the header
dataset <- read.csv("http://scv.bu.edu/examples/r/tutorials/Datasets/Salaries.csv")


### PERFORMANCE TIP ###
# nrows and colClasses argument:
# If the dataset is large, provide columns types and record number if possible
# a mild overestimate is possible for record number
# For this dataset the time is cut almost twice!

# *** na.strings ***
# Use na.strings argument to specify values that should be converted to NA (missing values)

## ***********************
# Advanced packages to load datasets 
# This finctions are often much faster for large datasets, but might require
# some extra settings to deal with poorly formatted input files
# Each package below performs significantly faster than the standard read.* functions and
# noramlly is easier to use, but might fail for some non-standard input formats
## ***********************
require(data.table)
dataset <- fread ( input = "http://scv.bu.edu/examples/r/tutorials/Datasets/Salaries.csv" )

require(readr)
dataset <- read_csv( file = "http://scv.bu.edu/examples/r/tutorials/Datasets/Salaries.csv" )


## **********************************
##    Read TXT file (tab delimeted)
## **********************************

# Read simple tab delimited file (txt) - assumes presence of the header
# Unlike csv read.table assumes no header by default
# we also have to specify the delimeter charaster (space - by default)
dataset <- read.table("your_file_name.txt",
                      header = TRUE,
                      sep = "\t")

# In this example we would like to leave Sex variable as factor, but 
#     Name variable should be set as character
dataset <- read.table("your_file_name.txt",
                      header = TRUE,
                      sep = "\t",
                      colClasses = c("integer","character",rep("integer",3),"factor"))

### PERFORMANCE TIP ###
# read.table will work faster for large files if comment.char is set as ""
dataset <- read.table("your_file_name.txt",
                      header = TRUE,
                      sep = "\t",
                      colClasses = c("integer","character",rep("integer",3),"factor"),
                      comment.char = "")

# In some cases file might contain a few lines that would want to skip
# Here is an example of the file that does not have a header, but has a few lines
# explaining the dataset
# This file also contains some blank line we would like to skip
dataset <- read.table("your_file_name.txt",
                      header = FALSE,
                      sep = "\t",
                      colClasses = c("integer","character",rep("integer",3),"factor"),
                      comment.char = "",
                      skip = 8,
                      blank.lines.skip = TRUE)
# set column names
names(dataset) <- c("ID","Name","Age","Height","Weight","Gender")

## *********************************
##    Read TXT file (fixed width)
## *********************************
dataset <- read.fwf("your_file_name.txt",
                      widths = c(12,19,8,11,11,6),
                      col.names = c("ID","Name","Age","Height","Weight","Gender"))


## ************************************
## Read zip files 
## ************************************

df <- read.table(unz("flights.zip", "your_file_name.csv"), header=TRUE, sep=",")

fdf1 <- read.table(gzfile("your_file_name.csv.gz"), header=TRUE, sep=",")

## ***************************
##    Read Excel files 
## ***************************
# There are a few R packages that can read excel files
library(readxl)
dataset <- read_excel("your_file_name.xlsx", sheet = 1)

# If there are an extral lines at the top of the file that you need to skip - use "skip" argument
# Below is an example how to read an excel file, skip the first 3 lines and read 13 lines, speicyfing 
# ##N/A symbol to be treated as a missing value:
visit <- read_excel("MedData.xlsx", 
                    sheet = "Visits", 
                    skip = 3,
                    n_max = 13,
                    na=c("","NA","##N/A"))




# Excel (and other sources) data can also be read from a Clipboard:
# Open Excel file, select and copy the cells and then run the code


# here we assume the first record is a header
clip <- readClipboard()
clip <- strsplit(clip, "\t")
dataset <- as.data.frame(do.call(rbind, clip[-1]), stringsAsFactors=FALSE)
names(dataset) <- clip[[1]]

# if no header is present in the selected cells
clip <- readClipboard()
clip <- strsplit(clip, "\t")
dataset <- as.data.frame(do.call(rbind, clip), stringsAsFactors=FALSE)

## ***************************
##    Read SAS files 
## ***************************
# Libraries to read SPSS files:
#   - foreign (read.spss() function)
#   - Hmisc() (sasxport.get())

# if SAS is installed on the system, read ssd or sas7bdat file
library("foreign")
dataset <- read.ssd(library = "Datasets", 
                    sectionnames = "gapminder",
                   sascmd = "C:/Program Files/SAS/SASFoundation/9.3/sas.exe")

# if SAS is not installed on the computer use SAS export file
library("foreign")
library("Hmisc")
dataset <- sasxport.get("Datasets/gapminder.xpt") 


## ***************************
##    Read SPSS files 
## ***************************
# Libraries to read SPSS files:
#   - foreign (read.spss() function)
#   - Hmisc (spss.get() function)
library("foreign")
dataset <- read.spss("Datasets/gapminder.sav",
                    use.value.labels = TRUE,
                    to.data.frame    = TRUE)

## ***************************
##    Read Stata files 
## ***************************
library("foreign")
dataset <- read.dta("Datasets/gapminder.dta")












## ***********************
##    Write to  CSV file
## ***********************

# Read simple comma delimited file (csv) - assumes presence of the header
write.csv( dataset,
           file = "myDataset.csv")

# Supress writting row names into output file
write.csv( dataset,
           file = "myDataset.csv",
           row.names=FALSE)


## ***********************
##    Write to  txt file
## ***********************

write.table(dataset,
            file = "myDataset.txt",
            quote = FALSE, # do not use quotes aorund string variables
            sep = "\t",    # use tab as a separator
            na  = " ",     # output missing values with a space
            row.names = TRUE,
            col.names = TRUE)

