% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_data_vars.R
\name{get_data_vars}
\alias{get_data_vars}
\alias{.get_input_vars}
\alias{.get_output_vars}
\title{Get variable names of data}
\usage{
.get_input_vars(prep_fun_name)

.get_output_vars(prep_fun_name)
}
\arguments{
\item{prep_fun_name}{The name of the called pre-processing function.}
}
\description{
An internal data-set is used to store data variables, which should not be
visited directly by any other functions. Here is two functions to get its
"input" and "output" variables.
}
\keyword{internal}
