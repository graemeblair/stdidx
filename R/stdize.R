

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
stdize <- function(variable, compare, condition, na.rm = TRUE) {

  # checks
  if(missing(variable)) stop("Please provide variable you wish to standardize.")
  if(!inherits(variable, "numeric")) stop("variable must be numeric.")
  if(missing(compare)) {
    compare <- variable
  } else {
    if(!inherits(compare, "numeric")) stop("compare must be numeric.")
  }
  if(missing(condition)) {
    condition <- TRUE
  } else {
    if(!inherits(condition, "logical")) condition <- as.logical(condition)
  }

  # standardize
  (variable - mean(compare[condition == TRUE], na.rm = na.rm)) / sd(compare[condition == TRUE], na.rm = na.rm)
}
