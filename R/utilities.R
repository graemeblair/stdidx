prep_data <- function(..., fill_na) {

  dots <- list2(...)

  mat <- matrix(unlist(dots, use.names = FALSE), ncol = length(dots), byrow = FALSE)

  if(fill_na == TRUE) {
    na_cols <- which(apply(mat, 2, function(x) any(is.na(x))))

    for(i in na_cols) {
      mat[, i] <- fill_na_col(mat[, i, drop = FALSE], mat[, -i, drop = FALSE])
    }
  }

  mat

}

# internal function to make a simple linear prediction
#  to values with missing
#' @importFrom stats coef lm predict
fill_na_col <- function(col, x) {
  fit <- lm(col ~ x)
  pred <- predict(fit, newdata = as.data.frame(x))
  ifelse(is.na(col), pred, col)
}

