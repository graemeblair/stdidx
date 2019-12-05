
#' Create Mean Index from Several Variables
#'
#' @param ... One or more unquoted variables
#' @param fill_na Option to fill missing values from any variable with linear predictions from all of the other variables. \code{TRUE} by default.
#' @param na.rm Option to remove NA's when calculating mean index. \code{TRUE} by default.
#'
#' @return A vector with the mean index
#'
#' @export
#'
#' @examples
#'
#' var1 <- rnorm(100, mean = 0.5, sd = 0.25)
#' var2 <- rnorm(100, mean = -1, sd = 0.5)
#' var3 <- rnorm(100, mean = 1, sd = 1)
#'
#' idx_mean(var1, var2, var3)
#'
#' library(dplyr)
#'
#' df <- tibble(var1, var2, var3)
#'
#' mutate(df, idx_var = idx_mean(var1, var2, var3))
#'
#' @importFrom rlang list2
#' @importFrom stats sd
idx_mean <- function(..., fill_na = TRUE, na.rm = TRUE) {

  # fill in NA values (if chosen) and convert to a matrix
  variables <- prep_data(..., fill_na = fill_na)

  # calculate index
  index <- apply(variables, 1, mean, na.rm = na.rm)

  index

}

