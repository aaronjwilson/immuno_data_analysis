# Notes on Elispot analysis

For the Elispot analysis my workflow is as follows.  
1. load data and libraries
2. melt the data from wide to long
3. aggregate duplicates 
4. subtract background
5. aggregate by groupId
6. plot the outcomes in a barchart faceted by groupId

In the R landscape one can rarely go wrong with a package designed by Hadley Wickam.  Anything that he touches comes away with a very polished and professional appeal that is a delight to use.  The packages that I will be using in the ELISpot analysis are reshape2,  plyr, stringr and for graphics ggplot2.  Though I started with Lattice plots the quality and aesthetics of ggplot are beyond compare.

# 1. Load libraries and data

```R
b<-c('reshape2', 'ggplot2', 'plyr', 'stringr')
lapply(b, require, character.only=T)

x<-read.table("data/elispot.tsv", header=T)
```

# 2. Munging
```R
y<-melt(x, id = c('participantid', 'participantid_cohort_label', 'timepoint'))
names(y)<-c('pid', 'group', 'visitid', 'pep', 'sfc')

#select only the first two letters of the category name
y$peptide<-str_sub(y$pep,1,2)
```

# 3. Aggregate the replicates
```R
data<-ddply(y, .(pid, group, visitid, peptide), summarise, sfc=mean(sfc))
```

# 4. Subtract Background
```R
data.m<-data[data$peptide=="mo",]
data.p<-data[data$peptide!='mo',]
df<-merge(data.p, data.m, c('pid', 'visitid','group'))
df$sfc<-(df$sfc.x-df$sfc.y)
```

# 5. Aggregate data by GroupId
```R
data<-ddply(df, .( group, visitid, peptide.x), summarise, sfc=mean(sfc, na.rm=TRUE))
```

# 6. Plot the buggers
Plotted as barplot of peptdies versus spot forming cells and faceted by the groups
```R
p<-ggplot(data, aes(x=factor(visitid), y=sfc, fill = peptide.x))
#png(filename="${imgout:labkey0_png}",width=1200,height=700) # please labkey section for explaining this line

p+geom_bar(stat='identity')+facet_wrap(~group, nrow=3)+labs(x="Visitid", y="SFC", title="ggplot based graph")
```
