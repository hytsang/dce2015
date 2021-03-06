rm(list=ls())
setwd("C:/Users/KY/Documents/GitHub/dce2015/dataFactory")

districts<-readLines("Districts.txt")

library(XML)
tbs<-c()
for (district in districts)
{
	u<-paste0("http://www.elections.gov.hk/dc2015/pdf/nomination/"
		, district
		# , "_20151015_c.html"
		, "_20151015_e.html"
	)
	tables <- readHTMLTable(u, header=T, trim=T, stringsAsFactors=F)
	tb<-tail(tables,1)[[1]]
	
	names(tb)<-c("ConstituencyCode"
		, "Constituency"
		, "Nominate"
		, "NominateAlias"
		, "Gender"
		, "Occupation"
		, "Politics"
		, "NominateDate"
		, "Remarks"
	)
	tb<-subset(tb, ConstituencyCode!="")
	tb<-transform(tb, Candidate=toupper( gsub("-"," ",Nominate)	)
		, Constituency=toupper(Constituency)
	)
	tb<-
	
	tbs<-rbind(tbs, tb)
	cat(district, " COMPLETED.\n")
}

# print(tbs)
write.csv(tbs, "demography.csv", row.names=F)
# write.csv(tbs, "demography_chi.csv", row.names=F)