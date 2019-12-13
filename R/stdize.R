

#' Standardize Variable
#'
#' @param variable Unquoted name of variable to standardize
#' @param compare Variable to use to calculate mean and standard deviation from
#' @param condition Logical vector (TRUE or FALSE) used to subset \code{compare} variable before calculating mean and standard deviation.
#' @param na.rm Option to remove NA's when calculating mean and standard deviation. Set to \code{TRUE} by default. Note that all values will be NA in the standardized variable if set to \code{FALSE}.
#'
#' @return A vector with the standardized variable
#'
#' @export
#'
#' @examples
#'
#' var <- rnorm(100, mean = 0.5, sd = 1)
#'
#' var_std <- stdize(var)
#'
#' summary(var_std)
#'
stdize <- function(variable, to, condition, na.rm = TRUE) {

  # checks
  if(missing(variable)) stop("Please provide variable you wish to standardize.")
  if(!is.numeric(variable)) stop("variable must be numeric.")
  if(missing(to)) {
    to <- variable
  } else {
    if(is.numeric(to)) stop("to must be a numeric variable.")
  }
  if(missing(condition)) {
    condition <- TRUE
  } else {
    if(!is.logical(condition)) condition <- as.logical(condition)
  }

  # standardize
  (variable - mean(to[condition == TRUE], na.rm = na.rm)) / sd(to[condition == TRUE], na.rm = na.rm)
}
