

#' Standardize Variable
#'
#' @param variable Unquoted name of variable to standardize
#' @param compare Variable to use to calculate mean and standard deviation from
#' @param condition Logical vector (TRUE or FALSE) used to subset \code{compare} variable before calculating mean and standard deviation.
#' @param na.rm
#'
#' @return
#' @export
#'
#' @examples
stdize <- function(variable, compare, condition, na.rm = TRUE) {
  if(missing(compare)) compare <- variable
  if(missing(condition)) condition <- TRUE
  (variable - mean(compare[condition == TRUE], na.rm = TRUE)) / sd(compare[condition == TRUE], na.rm = TRUE)
}