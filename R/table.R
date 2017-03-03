

table.lvec <- function(..., useNA = c("ifany", "no", "always")) {
  # Process and check input
  columns <- list(...)
  if (length(columns) < 1) stop("No vectors given.")
  lengths <- sapply(columns, length)
  if (length(unique(lengths)) != 1) stop("Lengths of vectors differ.")
  islvec <- sapply(columns, is_lvec)
  if (!all(islvec)) stop("Not all vectors are of type lvec.")
  # Ready to go
  chunks <- chunk(columns[[1]])
  tab <- vector("list", length(chunks))
  i <- 1
  for (c in chunks) {
    d <- lapply(columns, lget, range = c)
    d <- lapply(d, as_rvec)
    t <- do.call(table, c(d, useNA=useNA))
    tab[[i]] <- as.data.frame(t)
    i <- i + 1
  }
  tab
}


df_to_matrix <- function(df) {
  indices <- df[seq_len(ncol(df)-1)]
  
  unique_indices <- lapply(indices, unique)
  tab <- do.call(expand.grid, rev(unique_indices))
  df <- merge(tab, df, all.x = TRUE)
  
  dim <- sapply(unique_indices, length)
  
  result <- array(df[[length(df)]], dim = dim,
    dimnames = unique_indices)
  result[is.na(result)] <- 0
}
