rm(list=ls())
setwd("C:/Users/KY/Documents/GitHub/dce2015/dataFactory")

d_result<-read.csv("result.csv", header=T, stringsAsFactors=F)
d_demo<-read.csv("demography.csv", header=T, stringsAsFactors=F)
d_camp<-read.csv("politics_camp_full.csv", header=T, stringsAsFactors=F)

# print(head(d_result))
# print(head(d_demo))

d<-merge(d_demo, d_result, all=T)
d<-merge(d, d_camp, all=T)
d<-subset(d, !is.na(Key)
	, select=-c(Votes
		, Nominate
		, NominateAlias
		, NominateDate
		, Remarks
		)
	)

write.csv(d, "result_demo.csv", row.names=F)