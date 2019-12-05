
#' Create Mean Index from Several Variables
#'
#' @param ... One or more unquoted variables
#'
#' @return
#' @export
#'
#' @examples
mean_idx <- function(...) {
  dots <- list2(...)
  mat <- matrix(unlist(dots, use.names = FALSE), ncol = length(dots), byrow = TRUE)
  apply(mat, 1, mean, na.rm = TRUE)
}

