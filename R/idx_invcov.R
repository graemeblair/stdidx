
#' Create Inverse Covariance-Weighted Index from Several Variables
#'
#' With code by Cyrus Samii, see https://github.com/cdsamii/make_index/blob/master/r/index_comparison.R
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
#' idx_invcov(var1, var2, var3)
#'
#' library(dplyr)
#'
#' df <- tibble(var1, var2, var3)
#'
#' mutate(df, idx_var = idx_invcov(var1, var2, var3))
#'
#' @importFrom rlang list2
#' @importFrom stats cov.wt
idx_invcov <- function(..., wt, fill_na = TRUE, na.rm = TRUE) {

  # code from https://github.com/cdsamii/make_index/blob/master/r/index_comparison.R

  # fill in NA values (if chosen) and convert to a matrix
  variables <- prep_data(..., fill_na = fill_na)

  if(missing(wt)) wt <- rep(1, nrow(variables))

  # calculate index
  i.vec <- as.matrix(rep(1, ncol(variables)))
  Sx <- cov.wt(variables, wt = wt)[[1]]
  # wts <- solve(t(i.vec) %*% solve(Sx) %*% i.vec) %*% t(i.vec) %*% solve(Sx)

  index <- (t(solve(t(i.vec) %*% solve(Sx) %*% i.vec) %*% t(i.vec) %*% solve(Sx) %*% t(variables)))[, 1]

  index

}


# icwIndex <- function(	xmat,
#                       wgts=rep(1, nrow(xmat)),
#                       revcols = NULL,
#                       sgroup = rep(TRUE, nrow(xmat))){
#   X <- matStand(xmat, sgroup)
#   if(length(revcols)>0){
#     X[,revcols] <-  -1*X[,revcols]
#   }
#   i.vec <- as.matrix(rep(1,ncol(xmat)))
#   Sx <- cov.wt(X, wt=wgts)[[1]]
#   weights <- solve(t(i.vec)%*%solve(Sx)%*%i.vec)%*%t(i.vec)%*%solve(Sx)
#   index <- t(solve(t(i.vec)%*%solve(Sx)%*%i.vec)%*%t(i.vec)%*%solve(Sx)%*%t(X))
#   return(list(weights = weights, index = index))
# }


