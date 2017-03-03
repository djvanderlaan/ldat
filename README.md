
Basic statistical functionality for lvec objects
=======================================================

## Implementations for existing base R methods ##

- Indexing: `[]` and `[]<-`. Indexing returns an lvec object.
- Mathematical operators: `"+"`, `"-"`, `"*"`, `"/"`, `"^"`, `"%%"`, `"%/%"` 
  `"&"`, `"|"`, `"!"`, `"=="`, `"!="`, `"<"`, `"<="`, `">="`, `">"`. These
  return an lvec object.
- Summarising functions: `all`, `any`, `prod`, `sum`, `mean`, `max`, `min`, 
  `range`, `quantile`, `median`. These all return an R-vector.
- Math functions: `abs`, `sign`, `sqrt`, `floor`, `ceiling`, `trunc`,
  `round`, `signif` `exp`, `log`, `expm1`, `log1p`, `cos`, `sin`, `tan`,
  `cospi`, `sinpi`, `tanpi`, `acos`, `asin`, `atan`, `cosh`, `sinh`, `tanh`,
  `acosh`, `asinh`, `atanh`, `lgamma`, `gamma`, `digamma`, `trigamma`, `cumsum`, 
  `cumprod`, `cummax`, `cummin`. These all return an lvec.
- Other functions implemented for lvec objects: `is.na`.


## Other functions for working with lvec object ##

- `elementwise`: apply a function to each element of an lvec, returning a new 
  lvec with the same length as the input. 
- `chunkwise`:divide an lvec object into chunks and apply a function to each 
  chunk. This can be used to calculate summary statistics.
- `partial_sort`: partial sort an lvec object. 
