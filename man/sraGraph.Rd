\name{sraGraph}
\alias{sraGraph}
\title{ Create a new graphNEL object of SRA accessios from SRA full text search }
\description{
This function will create a new graphNEL object from SRA accessions using function of \code{\link{entityGraph}} and SRA accessions are  returned from SRA full text search using function of \code{\link{getSRA}}
}
\usage{
sraGraph(search_terms, sra_con)
}
\arguments{
  \item{search_terms}{
Free text search terms constructed according to SQLite query syntax defined here: http://www.sqlite.org/fts3.html#section_1_3
}
  \item{sra_con}{
Connection to the SRAmetadb SQLite database
}
}
\details{
This function is a wrapper of two functions: acc <- getSRA(search_terms, out_types='sra', sra_con, acc_only=TRUE)
 and g <- entityGraph(acc). A graphNEL object with edgemode='directed' is created from input data.frame of SRA accessions and the \code{\link{plot}} function will draw a graph
}
\value{
A graphNEL object with edgemode='directed'
}
\author{
Jack Zhu <zhujack@mail.nih.gov> and Sean Davis <sdavis2@mail.nih.gov>
}
\seealso{
\code{\link{getSRA}}, \code{\link{sraConvert}}, \code{\link{entityGraph}}
}
\examples{ 
## Using the SRAmetadb demo database

	library(SRAdb)
  	library(Rgraphviz)
	
	sra_dbname <- file.path(system.file('extdata', package='SRAdb'), 'SRAmetadb_demo.sqlite')	
	sra_con <- dbConnect(dbDriver("SQLite"), sra_dbname)
	
	## create a graphNEL object from SRA accessions, which are full text search results of terms 'primary thyroid cell line'
	g <- sraGraph('MCF7 OR "MCF-7"', sra_con)
	attrs <- getDefaultAttrs(list(node=list(fillcolor='lightblue', shape='ellipse')))
	plot(g, attrs=attrs)

	## similiar search as the above, returned much larger data.frame and graph is too clouded
	g <- sraGraph('MCF', sra_con)
	\dontrun{
	plot(g)	
	}

## The actual SRAmetadb sqlite database can be downloaded using function: getSRAdbFile. Warning: the actual SRAmetadb sqlite database is pretty large (> 35GB as of May, 2018) after uncompression. So, downloading and uncompressing of the actual SRAmetadb sqlite could take quite a few minutes depending on your network bandwidth. Direct links for downloading the SRAmetadb sqlite database:  https://s3.amazonaws.com/starbuck1/sradb/SRAmetadb.sqlite.gz https://gbnci-abcc.ncifcrf.gov/backup/SRAmetadb.sqlite.gz
}
