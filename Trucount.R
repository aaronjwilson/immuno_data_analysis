setwd('/home/hduser/Data/R')
list.files()
x<-read.csv('nhp1601tru.csv', header=T)
head(x)

library(reshape2)
library(ggplot2)

names(x)
[1] "Day"            "Study"          "Week"           "NHP"            "Groups"         "BCells"        
[7] "DendriticCells" "Monocytes"      "NKCells"        "CD4"            "CD8"  

x[1:2]<-list(NULL)
x$Week_Sub<-ifelse(x$Week=="4+24HR",4.14, ifelse(x$Week=="4+72HR",4.42,x$Week))
x1<-melt(x, id=c("Week", "Week_Sub","NHP", "Groups"))

#All graphs
ggplot(x1,aes(Week, value, fill=Groups))+geom_boxplot()+facet_grid(variable~., scales='free')

#all Groups
ggplot(x1,aes(Groups, value))+geom_boxplot(aes(fill=Week))+facet_grid(variable~., scales='free')

#Bcell stat loess
BCell_stat<-ggplot(x,aes(Week_Sub,BCells))+geom_smooth(aes(fill=Groups))+facet_grid(.~Groups)
#BCell_box
ggplot(x,aes(Week,BCells))+geom_boxplot(aes(fill=Groups))+facet_grid(.~Groups)+theme(axis.text.x = element_text(angle = 90, hjust = 1))

coltest<-ggplot(x,aes(Week,BCells))+geom_boxplot()+facet_grid(.~Groups)+theme(axis.text.x = element_text(angle = 90, hjust = 1))
coltest+aes(fill=Groups)+scale_fill_manual(breaks = c("Control", "dG_IM", "dG_IN_IO", "dGps_IM", "dGps_IN_IO", "G6_IN_IO"), values = c("black", "orange", "green", "purple", "red", "blue"))

coltest+aes(fill=Groups)+scale_fill_manual(breaks = c("Control", "dG_IM", "dG_IN_IO", "dGps_IM", "values = c("black", "orange", "green", "purple", "red", "blue")))
