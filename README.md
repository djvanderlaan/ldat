

ldat: out of memory vectors in R
===========================================================

This R package contains functions and methods for working with vectors and 
data sets that are too large to fit into memory. The data is kept (partially)
on disk using memory mapping. 

The package extends the basic functionality provided by the 
[`lvec`](https://github.com/djvanderlaan/lvec) package, which implements 
integer, logical, and numeric memory mapped vectors. It 
implements additional functionality to make working with these objects easier. It
implements various base R methods, such a `mean ` and `table`, for `lvec`
objects. Furthermore, it implements data.frame-like objects (`ldat` objects) 
that can be used to work with data sets too large to fit into memory. 


## Implementations for existing base R methods ##

The following functions and methods are implemented for `lvec` objects:

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

These methods make working with `lvec` objects almost the same as working with
regular R vectors. Some examples:

Create an vector with random numbers (in this case the vector is first 
generated in memory, for long vector the `generate` function can be used) and 
set some values to missing:

```r
x <- as_lvec(rnorm(1E6))
x[c(1,5)] <- NA
```

Calculate the mean

```r
mean(x, na.rm = TRUE)
```

```
## [1] 0.0004890163
```

Truncate values to the range -1--1:

```r
x[abs(x) > 1 & !is.na(x)] <- 1
```

Sort `x`:

```r
sort(x)
```

```
## numeric lvec of length 1,000,000:
##        [1] -0.9999991 -0.9999982 -0.9999964 -0.9999952 -0.9999877
##        [6] -0.9999705 -0.9999659 -0.9999638 -0.9999633 -0.9999611
##       [11] -0.9999602 -0.9999589 -0.9999493 -0.9999490 -0.9999450
##       [16] -0.9999441 -0.9999417 -0.9999415 -0.9999412 -0.9999384 
##       ... 
##   [999981]  1.0000000  1.0000000  1.0000000  1.0000000  1.0000000
##   [999986]  1.0000000  1.0000000  1.0000000  1.0000000  1.0000000
##   [999991]  1.0000000  1.0000000  1.0000000  1.0000000  1.0000000
##   [999996]  1.0000000  1.0000000  1.0000000         NA         NA
```

Attributes of vectors are preserved, which means that one can work with 
`factor` and `Date` objects:

```r
y <- as_lvec(factor(sample(letters, 1000, replace = TRUE)))
print(y)
```

```
## integer lvec of length 1,000:
##     [1] o k j a o k x v m e i v p q g b c k s k 
##    ... 
##   [981] o a w u i d x h s v i b a n o r o l u e
```

```r
table(y)
```

```
## Var1
##  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y 
## 44 46 37 37 33 43 38 40 42 44 45 28 38 42 38 37 27 42 38 37 31 41 29 48 37 
##  z 
## 38
```



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
##     a           b
## 1   1  0.92167674
## 2   2 -0.46541686
## 3   3  0.41387555
## 4   4 -0.07090688
## 5   5  0.32436058
## 6   6 -1.25921297
## 7   7  2.68307278
## 8   8 -0.04593168
## 9   9  1.02967927
## 10 10 -0.09501413
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



## Chunkwise processing of `lvec` and `ldat` objects ##

Although some basic functionality has been implemented for `ldat` and `lvec`
objects (see above), in practice, one will of course want to do stuff that isn't
implemented. One solution is to copy the data to a regular R-object, perform the
computation in R and if necessary copy the result back to an `lvec` or `ldat` 
object. This could for example be an option when a complete dataset doesn't fit
into memory, but the few columns needed for a computation do. An `lvec` object
can be converted to an R-object using `as_rvec` and an `ldat` object using 
`as.data.frame`. 


```r
dta <- as_ldat(iris)
cor(as_rvec(dta$Sepal.Length), as_rvec(dta$Sepal.Width))
```

```
## [1] -0.1175698
```

However, in practice, the data doesn't always fit into memory, or one can not
assume it does. In that case chunkwise, or blockwis, processing can often be
used. Many of the functions mentioned above have been implemented using 
chunkwise processing. With chunkwise processing one reads a chunk of data into
memory, performs some computation on that chunk before copying the next chunk 
into memory. The `ldat` and `lvec` packages contain some helper functions for
that. 

One use case is calculating a new value for each element in a vector. The code 
below demontrates how this can be done using the helper functions `chunk` and
`slice_range`. In this case the month name is calculated for each element in 
a `Date` vector.


```r
x <- as_lvec(seq.Date(as.Date("1900-01-01"), as.Date("2050-12-31"), 
    by = "days"))

m <- lvec(length(x), "character", strlen = 3)
chunks <- chunk(x)
for (c in chunks) {
  d <- slice_range(x, range = c, as_r = TRUE)
  m[range = c] = months(d, abbreviate = TRUE)
}
```

Since this is a common operation, `ldat` also contains a special helper function
for this use case, `elementwise`, which applies a function to each element, in 
this case `months`

```r
m <- elementwise(x, months, abbreviate = TRUE)
```




## Other functions for working with lvec objects ##


- `chunkwise`:divide an lvec object into chunks and apply a function to each 
  chunk. This can be used to calculate summary statistics.
- `append`: append elements to an lvec object. 
- `generate`: generate an lvec object filled with (random) values. 
- `partial_sort`: ensure that an lvec is sorted in such a way, that values
  before a given element number are smaller than that element and values after
  that element are larger. 
- `partial_order`: as above, but returns the order, e.g. the indexing vector 
  that would result in a partiallr sorted vector. 



