# Notes on Elispot analysis

For the Elispot analysis my workflow consists of loading, munging, melting, aggregating and plotting.  

In the R landscape one can rarely go wrong with a package designed by Hadley Wickam.  Anything that he touches comes away with a very polished and professional appeal that is a delight to use.  The packages that I will be using in the ELISpot analysis are reshape2,  plyr, stringr and for graphics ggplot2.  Though I started with Lattice plots the quality and aesthetics of ggplot are beyond compare.

# 1. Load the necessary R libraries and data

```R
b<-c('reshape2', 'ggplot2', 'plyr', 'stringr')
lapply(b, require, character.only=T)

x<-read.table("data/elispot.tsv", header=T)
```

# 2. Munging
Pivot or "Reshape" the data from wide to long based upon categorical information
```R
y<-melt(x, id = c('participantid', 'groupid', 'visitid'))
names(y)<-c('participantid', 'groupid', 'visitid', 'pep', 'sfc')

#select only the first two letters of the category name
y$peptide<-str_sub(y$pep,1,2)
```

# 3. Aggregate the replicates
```R
data<-ddply(y, .(participantid, groupid, visitid, peptide), summarise, sfc=mean(sfc))
```

# 4. Subtract Background 
Will reduce the noise of the system being tested.
```R
#pull out the background  from the raw data and create a column 'm' ("mock treated")
data.m<-data[data$peptide=="mo",]
#pull out the raw data to subtract background from: column 'p'
data.p<-data[data$peptide!='mo',]
#bring them all together
df<-merge(data.p, data.m, c('participantid', 'visitid','groupid'))
#create new column for final output
df$sfc<-(df$sfc.x-df$sfc.y)
```

# 5. Aggregate data by GroupId
```R
data<-ddply(df, .( groupid, visitid, peptide.x), summarise, sfc=mean(sfc, na.rm=TRUE))
```

# 6. Plot the buggers
Plotted as barplot of peptdies versus spot forming cells and faceted by the groups
```R
p<-ggplot(data, aes(x=factor(visitid), y=sfc, fill = peptide.x))
p+geom_bar(stat='identity')+facet_wrap(~groupid, nrow=3)+labs(x="Visitid", y="SFC", title="ggplot based graph")
```
