library(dplyr)
library(XML)
library(reshape2)
library(ggplot2)
library(lubridate)

path <- "./XML/"
xPath <- "//Prezzi"
toNumWithComma <- function(x){ y <- as.numeric(gsub(",", ".", gsub("\\.", "", x))); return(y)}
getOra <- function(x){y<-formatC(x-1, width = 2, format = "d", flag = "0");return(y)}

# Start iterating on dates...
finalTable <- data.frame()

## for file in files...
files <- dir(path,pattern=".xml")
for(i in 1:length(files)){
  ## parse xml file and turn into dataframe
  file <- paste(path,files[i],sep="")
  table <- xmlRoot(xmlTreeParse(file)) %>% getNodeSet(xPath) %>% xmlToDataFrame(stringsAsFactors = FALSE)
  ## merge dataframe with final table
  finalTable <- rbind.data.frame(finalTable,table)
}

# Stop iterating, unpivot final table
finalTable <- melt(finalTable, variable_name = "Indice",id=names(finalTable)[1:3])

# Data wrangling on final table
finalTable$Ora <- sapply(finalTable$Ora, toNumWithComma)
finalTable$value <- sapply(finalTable$value, toNumWithComma)
names(finalTable)[names(finalTable) == "variable"] <- "Indice"
names(finalTable)[names(finalTable) == "value"] <- "Prezzo"

# Create YYYYMMDDHHMMSS column
finalTable$Data <- ymd_hms(paste(finalTable$Data,getOra(finalTable$Ora),"0000",sep=""),tz="CET")

# Drop useless columns
drops <- c("Mercato", "Ora")
finalTable <- finalTable[,!(names(finalTable) %in% drops)]

# Data visualization
PUN <- finalTable[finalTable$Indice == "PUN",c(1,3)]
sp <- ggplot(PUN, aes(x=Data, y=Prezzo))  + geom_line(alpha=0.1) + geom_point(shape=".")
sp
