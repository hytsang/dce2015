rm(list=ls())
setwd("C:/Users/KY/Documents/GitHub/dce2015/dataFactory")

library(XML)
u<-"http://www.elections.gov.hk/dc2015/eng/results_hk.html"
# u<-"http://www.elections.gov.hk/dc2015/chi/results_hk.html"
tables <- readHTMLTable(u, header=T, trim=T, stringsAsFactors=F)
tb<-tail(tables,1)[[1]]

narows<-is.na(tb[,5])
for (i in 5:3)	tb[narows, i]<-tb[narows, i-2]
tb[narows, 2]<-NA
tb[narows, 1]<-NA

names(tb)<-c("ConstituencyCode"
	, "Constituency"
	, "CandidateCode"
	, "CandidateAlias"
	, "Votes"
)
library(zoo)
tb<-na.locf(tb)
tb<-transform(tb, Uncontested=CandidateCode=="*")
tb<-transform(tb
	, elected=grepl("\\*",Votes)|Uncontested
	, VotesN=ifelse(Uncontested, 0, Votes)
	, Year=2015
	, Key=paste(ConstituencyCode, CandidateCode, sep="_")
	, Candidate=gsub("\\(.*\\)","",CandidateAlias)
)
tb<-transform(tb, VotesN=as.numeric(gsub("\\*|,","", VotesN)))

write.csv(tb, "result.csv", row.names=F)
# write.csv(tb, "result_chi.csv", row.names=F)