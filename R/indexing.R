
#' Indexing of lvec objects
#'
#' @param x an object of type \code{\link{lvec}}
#' @param i an index vector. See \code{\link{lget}}.
#' @param range an range of indices. See \code{\link{lget}}.
#' @param value new values. See \code{\link{lget}}.
#'
#' @details
#' These functions are a wrapper around \code{\link{lget}} and 
#' \code{\link{lset}}.
#'
#' @rdname indexing
#' @import lvec
#' @export
`[.lvec` <- function(x, i = NULL, range = NULL) {
  lget(x, index = i, range = range)
}

#' @rdname indexing
#' @import lvec
#' @export
`[<-.lvec` <- function(x, i, range, value) {
  if (!missing(range)) {
    lset(x, range = range, values = value)
  } else {
    lset(x, index = i, values = value)
  }
}

