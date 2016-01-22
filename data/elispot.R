b<-c('reshape2', 'ggplot2', 'plyr', 'stringr')
lapply(b, require, character.only=T)

x<-read.table("elispot.tsv", header=T)

# 2. Munging

y<-melt(x, id = c('participantId', 'groupId', 'visitId'))
names(y)<-c('participantid', 'groupid', 'visitid', 'pep', 'sfc')

#select only the first two letters of the category name
y$peptide<-str_sub(y$pep,1,2)

# 3. Aggregate the replicates

data<-ddply(y, .(participantid, groupid, visitid, peptide), summarise, sfc=mean(sfc))


# 4. Subtract Background

data.m<-data[data$peptide=="mo",]
data.p<-data[data$peptide!='mo',]
df<-merge(data.p, data.m, c('participantid', 'visitid','groupid'))
df$sfc<-(df$sfc.x-df$sfc.y)


# 5. Aggregate data by GroupId

data<-ddply(df, .( groupid, visitid, peptide.x), summarise, sfc=mean(sfc, na.rm=TRUE))


# 6. Plot the buggers
# Plotted as barplot of peptdies versus spot forming cells and faceted by the groups

p<-ggplot(data, aes(x=factor(visitid), y=sfc, fill = peptide.x))
p+geom_bar(stat='identity')+facet_wrap(~groupid, nrow=3)+labs(x="Visitid", y="SFC", title="ggplot based graph")


