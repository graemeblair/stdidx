
#' Create Mean Index from Several Variables
#'
#' @param ... One or more unquoted variables
#'
#' @return
#' @export
#'
#' @examples
#'
#' var1 <- rnorm(100, mean = 0.5, sd = 0.25)
#' var2 <- rnorm(100, mean = -1, sd = 0.5)
#' var3 <- rnorm(100, mean = 1, sd = 1)
#'
#' mean_idx(var1, var2, var3)
#'
#' library(tibble)
#' df <- tibble(var1, var2, var3)
#'
#' mutate(df, idx_var = mean_idx(var1, var2, var3))
#'
#' @importFrom rlang list2
mean_idx <- function(..., fill_na = TRUE) {

  dots <- list2(...)
  mat <- matrix(unlist(dots, use.names = FALSE), ncol = length(dots), byrow = TRUE)

  if(fill_NA == TRUE) {
    na_cols <- which(apply(mat, 2, function(x) any(is.na(x))))

    for(i in na_cols) {
      fit <- lm(mat[, i] ~ mat[, -i])
      mat[, i] <- predict(fit, newdata = as.data.frame(mat[, -i]))
    }
  }

  apply(mat, 1, mean, na.rm = TRUE)

}

