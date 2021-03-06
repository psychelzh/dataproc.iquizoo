% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calc_cong_eff.R
\name{calc_cong_eff}
\alias{calc_cong_eff}
\title{Congruence effect}
\usage{
calc_cong_eff(data, by, name_cong, name_acc, name_rt)
}
\arguments{
\item{data}{Raw data of class \code{data.frame}.}

\item{by}{The column name(s) in \code{data} used to be grouped by.}

\item{name_cong}{The column name of the \code{data} input whose values are the
congruence information, in which is a \code{character} vector with "incongruent
condition" (label: \code{"incongruent"}) and "congruent condition" (label:
\code{"congruent"}). It will be coerced as a \code{factor} vector with these two
levels.}

\item{name_acc}{The column name of the \code{data} input whose values are user's correctness, in which is a \code{numeric} vector so coded that 1 means scoring correct, 0 means scoring incorrect, and that -1 means no response is made.}

\item{name_rt}{The column name of the \code{data} input whose values are user's reaction time, in which is a \code{numeric} vector with \code{NA} values representing abnormal reaction times.}
}
\value{
A \link[tibble:tibble-package]{tibble} contains congruence effect results
on accuracy and response time.
}
\description{
Utility function to calculate congruence effect sizes.
}
\keyword{internal}
