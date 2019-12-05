
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stdidx

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/stdidx)](https://CRAN.R-project.org/package=stdidx)
<!-- badges: end -->

This small package provides a set of simple tools for standardizing
variables (based on summary statistics from another variable or a
subset, such as a control group in an experiment) and constructing
indices of multiple variables. It provides simple mean indexing and
inverse covariance-weighted
indices.

## Installation

<!-- You can install the released version of stdidx from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("stdidx") -->

<!-- ``` -->

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("graemeblair/stdidx")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(stdidx)

var1 <- rnorm(100, mean = 0.5, sd = 0.25)
var2 <- rnorm(100, mean = -1, sd = 0.5)
var3 <- rnorm(100, mean = 1, sd = 1)

idx <- idx_mean(var1, var2, var3)
head(idx)
#> [1] -0.1859023  0.4049927  0.4201676  1.2139986 -0.3697271 -0.2082099
```

`stdidx` is set up to work with a `tidyverse` workflow out of the box:

``` r
library(dplyr)

df <- tibble(var1, var2, var3)

df %>% mutate(idx_var = idx_mean(var1, var2, var3)) %>% head
#> # A tibble: 6 x 4
#>    var1    var2   var3 idx_var
#>   <dbl>   <dbl>  <dbl>   <dbl>
#> 1 0.843 -0.400  -1.00   -0.186
#> 2 0.359 -0.478   1.33    0.405
#> 3 0.591 -1.50    2.17    0.420
#> 4 0.658 -0.0758  3.06    1.21 
#> 5 0.601 -1.33   -0.377  -0.370
#> 6 0.473 -0.947  -0.151  -0.208
```
