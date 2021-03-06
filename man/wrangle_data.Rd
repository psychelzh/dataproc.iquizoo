% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrangle_data.R
\name{wrangle_data}
\alias{wrangle_data}
\title{Wrangle Raw Data}
\usage{
wrangle_data(
  data,
  name_data = "game_data",
  name_user = "user_id",
  name_key = ".id"
)
}
\arguments{
\item{data}{The raw data.}

\item{name_data}{The column name in the \code{data} that stores original data. It
is typically of a vector containing \code{JSON} string.}

\item{name_user}{The column name in the \code{data} that stores the identifier of
users.}

\item{name_key}{The key name used to match meta data. Should be a scalar
character. Default is \code{".id"}, which is appropriate for most cases.}
}
\value{
A \link[tibble:tibble-package]{tibble} with two pieces of meta data:
\code{info} and \code{name_key}. They stores other metadata from input raw data other
than game data from \code{name_datas}.
}
\description{
Data wrangling is the first step for data analysis.
}
\details{
These steps are performed in order:
\enumerate{
\item Data clean. Remove observations with invalid or empty (i.e., \code{"[]"} or
\code{"{}"}) json string data and then remove duplicates from data. If this step
produces data with no observation, following steps are skipped and \code{NULL}
is returned.
\item Data parse. Parse data stored in json string, convert the names to lower
case and stack the parsed data. Stacking have better performances than
\link[=group_nest]{group_nest}ing.
}
}
