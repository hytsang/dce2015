rm(list=ls())
setwd("C:/Users/KY/Documents/RProjects/dce2015")

d_result<-read.csv("result.csv", header=T, stringsAsFactors=F)
d_demo<-read.csv("demography.csv", header=T, stringsAsFactors=F)
d_camp<-read.csv("politics_camp.csv", header=T, stringsAsFactors=F)

# print(head(d_result))
# print(head(d_demo))

d<-merge(d_demo, d_camp, all=T)
d<-merge(d, d_result, all=T)
d<-subset(d, !is.na(CandidateCode)
	, select=-c(Votes
		, Nominate
		, NominateAlias
		, NominateDate
		, Remarks
		)
	)
print(head(d))