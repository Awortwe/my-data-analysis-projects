#Get the working directory
getwd()

#import your csv. file
demo <- read.csv("WalmartSalesData.csv.csv", header = TRUE, sep=",")

head(demo)
View(demo)

demogender <- demo[demo$Gender == 'Female',]
View(demogender)

demo2 <- demo[demo$Total > 1000, c(1, 3, 4)]
View(demo2)
