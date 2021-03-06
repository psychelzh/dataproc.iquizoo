
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dataproc.iquizoo

<!-- badges: start -->

[![R-CMD-check](https://github.com/psychelzh/dataproc.iquizoo/workflows/R-CMD-check/badge.svg)](https://github.com/psychelzh/dataproc.iquizoo/actions)
[![Codecov test
coverage](https://codecov.io/gh/psychelzh/dataproc.iquizoo/branch/master/graph/badge.svg)](https://codecov.io/gh/psychelzh/dataproc.iquizoo?branch=master)
[![lint](https://github.com/psychelzh/dataproc.iquizoo/workflows/lint/badge.svg)](https://github.com/psychelzh/dataproc.iquizoo/actions)
<!-- badges: end -->

The goal of dataproc.iquizoo is to provide pre-processing functions for
IQUIZOO original data.

## Background

IQUIZOO is now a developing company shipped with a bunch of games
assessing psychological constructs. The original data from these games
have various formats, and this package tries to provide data
preprocessing APIs for them. The basic logic here is to use one dataset
named `game_info`, which is exported to provide information of each game
and its preprocessing function name, so that one can easily match the
correct function to preprocess data for these games based on this
dataset.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("psychelzh/dataproc.iquizoo")
```

## Usage

This package is best used in company with
[tarflow.iquizoo](https://github.com/psychelzh/tarflow.iquizoo) package.
Read the [documentation](https://psychelzh.github.io/tarflow.iquizoo)
there.
