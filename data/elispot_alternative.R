list.files()
#this method is meant as a means of learning some of the elements that can go into an analysis
#it is meant as an illustration of the work that would go into excel and prism

x<-read.csv('elispot.tsv', header=T, sep="\t")

#deriving information about data
head(x)
dim(x)
names(x)
str(x)
summary(x)

#background subtraction
x$gag<-((x$gag1+x$gag2+x$gag3)/3)-((x$mock1+x$mock2+x$mock3)/3)
x$rt<-((x$RT1+x$RT2+x$RT3)/3)-((x$mock1+x$mock2+x$mock3)/3)
x$int<-((x$int1+x$int2+x$int3)/3)-((x$mock1+x$mock2+x$mock3)/3)
x$nef<-((x$nef1+x$nef2+x$nef3)/3)-((x$mock1+x$mock2+x$mock3)/3)
x$env1<-((x$env1_1+x$env1_2+x$env1_3)/3)-((x$mock1+x$mock2+x$mock3)/3)
x$env2<-((x$env2_1+x$env2_2+x$env2_3)/3)-((x$mock1+x$mock2+x$mock3)/3)

#rather than have a verbose and repetitive subtraction create and alias for mock and subtract that
#x$mock<-((x$mock1+x$mock2+x$mock3)/3)
#x$gag<-((x$gag1+x$gag2+x$gag3)/3)-x$mock
#x$rt<-((x$RT1+x$RT2+x$RT3)/3)-x$mock
#x$int<-((x$int1+x$int2+x$int3)/3)-x$mock
#x$nef<-((x$nef1+x$nef2+x$nef3)/3)-x$mock
#x$env1<-((x$env1_1+x$env1_2+x$env1_3)/3)-x$mock
#x$env2<-((x$env2_1+x$env2_2+x$env2_3)/3)-x$mock



#create a data frame of the peptide groups you just made
e<-data.frame(cohort=x$groupId, visitId=x$visitId, peptide="Gag", value=x$gag)
f<-data.frame(cohort=x$groupId, visitId=x$visitId, peptide="RT", value=x$rt)
g<-data.frame(cohort=x$groupId, visitId=x$visitId, peptide="Int", value=x$int)
h<-data.frame(cohort=x$groupId, visitId=x$visitId, peptide="Nef", value=x$nef)
i<-data.frame(cohort=x$groupId, visitId=x$visitId, peptide="Env1", value=x$env1)
j<-data.frame(cohort=x$groupId, visitId=x$visitId, peptide="Env2", value=x$env2)

#bind it all together
l<-rbind(e,f,g,h,i,j)
#dim(l)
#apply a mean function to it using aggregate call 
a=aggregate(l$value, by=list(
  l$cohort,
  l$visitId,
  l$peptide), FUN=mean)
 
#dim(a)
#rename for knowing purposes
names(a)<-c("cohort", 'visitid', 'peptide', 'data')

#plot using a lattice barchart
library(lattice)
barchart(data~as.factor(visitid)|cohort,a, 
         group=a$peptide,
         stack=TRUE,
         auto.key=list(title="Peptide Groups", 
                       rectangles=FALSE, 
                       space="top", 
                       col=rainbow(6)), 
         col=rainbow(6), 
         xlab= "Timepoints", 
         ylab="SFC",
         ylim=c(0,1200)) 
