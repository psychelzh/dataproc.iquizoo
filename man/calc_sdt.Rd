% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_sdt.R
\name{calc_sdt}
\alias{calc_sdt}
\title{Signal Detection Theory}
\usage{
calc_sdt(data, by, name_acc, name_type, keep_counts = TRUE)
}
\arguments{
\item{data}{Raw data of class \code{data.frame}.}

\item{by}{The column name(s) in \code{data} used to be grouped by.}

\item{name_acc}{The column name of the \code{data} input whose values are user's correctness, in which is a \code{numeric} vector so coded that 1 means scoring correct, 0 means scoring incorrect, and that -1 means no response is made.}

\item{name_type}{The column name of the \code{data} input whose values are the
stimuli types, in which is a \code{character} vector with value \code{"s"} (denoting
"\emph{signal}") and \code{"n"} (denoting "\emph{non-signal}") only. It will be coerced as
a \code{factor} vector with these two levels.}

\item{keep_counts}{A logical value. Whether the counts of correct and error
be returned. Default is \code{TRUE}.}
}
\value{
A \link[tibble:tibble-package]{tibble} contains sensitivity index and
bias (and other counts measures)
}
\description{
Calculate sensitivity index and bias based on signal detection theory. The
correction for extreme proportions of zero and one is the "log-linear" rule
recommended by Hautus (1995).
}
\keyword{internal}
