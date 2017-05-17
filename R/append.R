
#' @rdname append
#' @export
append <- function(x, y, ...) {
  UseMethod("append")
}


#' Append a vector to an lvec
#' 
#' @param x \code{\link{lvec}} to append to.
#' @param y vector to append to \code{x}. Is converted to \code{\link{lvec}}
#'   using \code{\link{as_lvec}}.
#' @param clone should \code{x} be cloned first. If not, the input \code{x} is
#'   modified. 
#' @param ... ignored; used to pass additional arguments to other methods.
#'
#' @return
#' Returns an lvec combining both \code{x} and \code{y}. When \code{x} is 
#' \code{NULL} a clone of \code{y} is returned.
#'
#' @rdname append
#' @export
append <- function(x, y, clone = TRUE, ...) {
  if (!is_lvec(y)) y <- as_lvec(y)
  if (is.null(x) || length(x) == 0) return(clone(y))
  if (!is_lvec(x)) stop("x should be of type lvec (or NULL)")
  lx <- length(x)
  if (clone) x <- clone(x)
  if (lvec_type(x) == "character" && lvec_type(x) == "character" &&
    strlen(x) < strlen(y)) strlen(x) <- strlen(y)
  length(x) <- lx + length(y)
  lset(x, range = c(lx+1, length(x)), values = y)
}

