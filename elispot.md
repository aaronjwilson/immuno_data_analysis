library(ggplot2)
library(reshape2)
library(stringr)
library(plyr)


```R
y<-melt(x, id = c('participantid', 'participantid_cohort_label', 'timepoint'))
names(y)<-c('pid', 'group', 'visitid', 'pep', 'sfc')
```


y$peptide<-str_sub(y$pep,1,2)

data<-ddply(y, .(pid, group, visitid, peptide), summarise, sfc=mean(sfc))
data.m<-data[data$peptide=="mo",]
data.p<-data[data$peptide!='mo',]
df<-merge(data.p, data.m, c('pid', 'visitid','group'))
df$sfc<-(df$sfc.x-df$sfc.y)

data<-ddply(df, .( group, visitid, peptide.x), summarise, sfc=mean(sfc, na.rm=TRUE))

p<-ggplot(data, aes(x=factor(visitid), y=sfc, fill = peptide.x))
png(filename="${imgout:labkey0_png}",width=1200,height=700)
p+geom_bar(stat='identity')+facet_wrap(~group, nrow=3)+labs(x="Visitid", y="SFC", title="ggplot based graph")
