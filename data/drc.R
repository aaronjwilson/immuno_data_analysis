#code contains information regarding the derivation of titered elisa data determined by either the use of endpoint or cutoff of 0.2
#provides method for determining and graphing mean and error bars for grouped data


suppressPackageStartupMessages(library(drc))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(ggplot2))
library(lattice)

#x<-c('reshape2', 'ggplot2', 'plyr', 'drc', 'lattice')
#lapply(x, require, character.only=T)

#post data from csv file.  names and descriptions of columns
D<-read.csv('datafile.csv', header=TRUE)


#when time permits want to work out strategy for using cast and ddply rather than a loop function

results<-data.frame(ptid=NA, cohort=NA, visitid=NA, fit.f=NA, titer=NA);
for (index in 1:nrow(D))
{
	ptid<-D$participantid[index];
	cohort<-D$participantid_cohort_label[index];
	visitid<-D$visitid[index];
	ctof<-D$ctof[index];
        

	a<-data.frame(name= 100, value=D$t100[index])
	b<-data.frame(name= 400, value=D$t400[index])
	c<-data.frame(name= 1600, value=D$t1600[index])
	d<-data.frame(name= 3200, value=D$t3200[index])
	e<-data.frame(name= 6400, value=D$t6400[index])
	f<-data.frame(name= 12800,value=D$t12800[index])
	g<-data.frame(name= 25600,value=D$t25600[index])
	h<-data.frame(name= 51200,value=D$t51200[index])
	i<-data.frame(name= 102400, value=D$t102400[index])
	j<-data.frame(name= 204800, value=D$t204800[index])
	k<-data.frame(name= 409600, value=D$t409600[index])
	
	m<-rbind(a,b,c,d,e,f,g,h,i,j,k) 	
	
	#error handling
	tryCatch({
		
	#use of five parameter curve fit for use in defining coefficients for equation
	#bioassay specific analysis is best accomplished by a 5 parameter logistic nonlinear regression model
	#http://www.miraibio.com/blog/2009/02/5-pl-logistic-regression/
	
	fit = drm(value~name, data=m, fct=LL.5(), na.action=na.omit);	

	#alias the drm coefficients
	fit.b<-as.numeric(coef(fit)["b:(Intercept)"])
	fit.c<-as.numeric(coef(fit)["c:(Intercept)"])
	fit.d<-as.numeric(coef(fit)["d:(Intercept)"])
	fit.e<-as.numeric(coef(fit)["e:(Intercept)"])
	fit.f<-as.numeric(coef(fit)["f:(Intercept)"])


#equation for determing titer
titer=fit.e*(((fit.c-fit.d)/(fit.c-0.2))^(1/fit.f)-1)^(1/fit.b)
	
	
	results[index,]<-c(ptid, cohort, visitid, fit.f, titer);
	},
	error=function(e) e

)
}	

#results<-data.frame(results$ptid, D$participantid, results$cohort, results$fit.e)
results$titer1<- ifelse(results$titer == "NaN", 10, results$titer)
#results


#png(filename="${imgout:labkey1_png}",width=800,height=500)
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
    require(plyr)
      length2 <- function (x, na.rm=FALSE) {
        if (na.rm) sum(!is.na(x))
        else       length(x)
    }
    datac <- ddply(data, groupvars, .drop=.drop,
                   .fun= function(xx, col, na.rm) {
                           c( N    = length2(xx[,col], na.rm=na.rm),
                              mean = mean   (xx[,col], na.rm=na.rm),
                              sd   = sd     (xx[,col], na.rm=na.rm)
                              )
                          },
                    measurevar,
                    na.rm
             )
    datac <- rename(datac, c("mean"=measurevar))
    datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
    ciMult <- qt(conf.interval/2 + .5, datac$N-1)
    datac$ci <- datac$se * ciMult
    return(datac)
}

data<-summarySE(results,measurevar = "titer", groupvars = c("cohort", "visitid"))
q<-ggplot(data, aes(factor(visitid), titer, fill=factor(cohort)))

mf_labeller <- function(var, value){
    value <- as.character(value)
    if (var=="cohort") { 
        value[value=="1"] <-"iVSV 10^8"
        value[value=="2"] <-"iVSV 10^7"
        value[value=="3"] <-"iVSV 10^6"
        value[value=="4"] <-"JRFL gp140"
    }
    return(value)
}



png(filename="${imgout:labkey1_png}",width=800,height=500)
q+geom_bar(stat='identity'
)+facet_grid(.~cohort, labeller =mf_labeller
)+geom_errorbar(aes(ymin=titer-se, ymax = titer +se), size=.3, width = .2
)+labs(title="JRCSF Elisa Results: BarChart", x= "Timepoint", y="Titer")
