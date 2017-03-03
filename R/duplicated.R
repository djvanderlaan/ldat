#' Find duplicates in a vector
#'
#' @param x an object of type \code{\link{lvec}}.
#' @param incomparables passed on to \code{link{duplicated}}. 
#' @param chunk_size passed on to \code{\link{chunk}}. Unlike most routines 
#'   that work with chunks, duplicated benefits from larger chunks.
#' @param fromLast not supported.
#' @param ... passed on to \code{\link{duplicated}}.
#'
#' @details
#' Because this function works on chunks of data the data first needs to be 
#' sorted. Since a non stable sort is used, which of the duplicates is marked
#' as duplicate is undefined. This is unlike the regular 
#' \code{\link{duplicated}} in which \code{fromLast} determines which records
#' are marked as duplicates.
#' 
#' @rdname duplicated
#' @export
duplicated.lvec <- function(x, incomparables = FALSE, chunk_size = 5E6, fromLast = FALSE, ...) {
  if (fromLast != FALSE) stop("fromLast is not supported")
  chunks <- chunk(x, chunk_size = chunk_size)
  # Calculate the order of the vector; we only need to sort between the
  # chunks; the chunks themselves do not need to be sorted
  pivots <- sapply(chunks, tail, n = 1)
  pivots <- head(pivots, -1)
  if (length(pivots)) {
    o <- partial_order(x, pivots = pivots)
  } else {
    o <- as_lvec(seq_len(length(x)))
  }
  # Same elements should now be sorted into same chunk (except at borders);
  # therefore, we can look for duplicates within chunks; we only need to take
  # into account the last value from the previous chunk
  result <- lvec(length(x), type="logical")
  prev <- NULL
  for (c in chunks) {
    oc <- lget(o, range = c)
    d <- as_rvec(lget(x, oc))
    dup <- duplicated(c(prev, d), incomparables = incomparables, ...)
    lset(result, index = oc, values = tail(dup, length(d)))
    # no need to use na.rm=TRUE; as the partial order will put NA's last
    prev <- max(d) 
  }
  result
}

#' @rdname duplicated
#' @export
unique.lvec <- function(x, incomparables = FALSE, chunk_size = 5E6, ...) {
  d <- duplicated(x, incomparables = incomparables, chunk_size = chunk_size, ...)
  lget(x, !d)
}

#duplicated.lvec <- function(x, incomparables = FALSE, ...) {
#  o <- order(x)
#  chunks <- chunk(o)
#  result <- lvec(length(x), type="logical")
#  prev <- NULL
#  for (c in chunks) {
#    oc <- lget(o, range = c)
#    d <- as_rvec(lget(x, oc))
#    dup <- duplicated(c(prev, d), incomparables = incomparables, ...)
#    lset(result, index = oc, values = tail(dup, length(d)))
#    prev <- tail(d, 1)
#  }
#  result
#}


