

Functions and Methods for Working with Out of Memory Vectors
============================================================

This package contains functions for working with `lvec` objects. These objects
can be used to work with data too large to fit into memory. The data itself is
stored in memory mapped files. The `lvec` package contains the core
functionality: creating and indexing `lvec` objects. This package implements
additional functionality to make working with these objects easier. It
implements various base R methods, such a `mean ` and `table`, for `lvec`
objects. Furthermore, it implements data.frame-like objects that can be used to
work with data sets too large to fit into memory. 

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
- `table`: cross tables of lvec objects.
- `duplicated`: check for duplicated values in an lvec object.
- `unique`: select unique values from an lvec object.
- `which`: return the indices of true elements.
- `match`: lookup elements in a other vector
- `is.na`: logical vector with missing values.

## Data.frame-like objects ##

`ldat` objects can be used to work with data sets. A `ldat` objects mimics as
close as possible the functionality of a `data.frame`. Under the hood it is a
list with `lvec` objects.

Create a new ldat

```r
dta <- ldat(a = 1:10, b = rnorm(10))
print(dta)
```

```
## ldat with 10 rows and 2 columns:
##     a          b
## 1   1 -1.4765325
## 2   2 -1.2332267
## 3   3 -0.4501801
## 4   4 -0.2250629
## 5   5  1.3402019
## 6   6 -0.1692386
## 7   7  0.8634156
## 8   8 -1.1074591
## 9   9 -1.0278717
## 10 10  0.5260446
```

Create one from an existing dataset

```r
dta <- as_ldat(iris)
```

An `ldat` object can be indexed as regular data.frame (one difference is that
rows and or columns will not be dropped, e.g. `drop = FALSE`). It will return a new
`ldat` object.

```r
dta[1:3, ]
```

```
## ldat with 3 rows and 5 columns:
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
```

```r
dta[dta$Sepal.Width > 5, ]
```

```
## ldat with 0 rows and 5 columns:
## [1] Sepal.Length Sepal.Width  Petal.Length Petal.Width  Species     
## <0 rows> (or 0-length row.names)
```

```r
dta[1:5, 1:2]
```

```
## ldat with 5 rows and 2 columns:
##   Sepal.Length Sepal.Width
## 1          5.1         3.5
## 2          4.9         3.0
## 3          4.7         3.2
## 4          4.6         3.1
## 5          5.0         3.6
```

```r
dta[1:5, "Sepal.Width"]
```

```
## ldat with 5 rows and 1 columns:
##   Sepal.Width
## 1         3.5
## 2         3.0
## 3         3.2
## 4         3.1
## 5         3.6
```

Converting to a data.frame:

```r
as.data.frame(dta[1:4, ])
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
```


## Other functions for working with lvec object ##

- `elementwise`: apply a function to each element of an lvec, returning a new 
  lvec with the same length as the input. 
- `chunkwise`:divide an lvec object into chunks and apply a function to each 
  chunk. This can be used to calculate summary statistics.
- `append`: append elements to an lvec object. 
- `generate`: generate an lvec object filled with (random) values. 
- `partial_sort`: ensure that an lvec is sorted in such a way, that values
  before a given element number are smaller than that element and values after
  that element are larger. 
- `partial_order`: as above, but returns the order, e.g. the indexing vector 
  that would result in a partiallr sorted vector. 




