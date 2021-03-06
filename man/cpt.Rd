% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cpt.R
\name{cpt}
\alias{cpt}
\title{Continuous Performance Test}
\usage{
cpt(data, by, vars_input)
}
\arguments{
\item{data}{Raw data of class \code{data.frame}.}

\item{by}{The column name(s) in \code{data} used to be grouped by.}

\item{vars_input}{The matched variable names for further processing. Typically set by the high-level function \code{\link[=preproc_data]{preproc_data()}}.}
}
\value{
A \link[tibble:tibble-package]{tibble} contains following values:
\item{nc}{Count of correct responses.}
\item{mrt}{Mean reaction time of hits.}
\item{rtsd}{Standard deviation of reaction times of hits.}
\item{dprime}{Sensitivity (d').}
\item{c}{Bias index.}
\item{commissions}{Number of errors caused by action.}
\item{omissions}{Number of errors caused by inaction.}
}
\description{
Continuous Performance Test (CPT) is a classical test for attention. There
are many methods used to calculate the performance index of this task, and
here only includes those common ones.
}
