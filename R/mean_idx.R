
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

  dots <- list2(...)
  mat <- matrix(unlist(dots, use.names = FALSE), ncol = length(dots), byrow = FALSE)

  if(fill_na == TRUE) {
    na_cols <- which(apply(mat, 2, function(x) any(is.na(x))))

    for(i in na_cols) {
      mat[, i] <- fill_na_col(mat[, i, drop = FALSE], mat[, -i, drop = FALSE])
    }
  }

  apply(mat, 1, mean, na.rm = na.rm)

}


# internal function to make a simple linear prediction
#  to values with missing
#' @importFrom stats coef lm predict
fill_na_col <- function(col, x) {
  fit <- lm(col ~ x)
  print(coef(fit))
  pred <- predict(fit, newdata = as.data.frame(x))
  ifelse(is.na(col), pred, col)
}

