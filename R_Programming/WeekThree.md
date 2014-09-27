###Looping on the Command Line
Writing for, while loops is useful when programming but not particularly easy when working interactively on the command line. There are some functions which implement looping to make life easier.
* _lapply_: Loop over a list and evaluate a function on each element
* _sapply_: Same as _lappy_ but try to simplify the result
* _apply_: Apply a function over the margins of an array
* _tapply_: Apply a function over subsets of a vector
* _mapply_: Multivariate version of _lapply_

##An auxiliary function _split_ is also useful, particularly in conjunction with _lapply_.

###lapply
##_lapply_ always returns a list, regardless of the class of the input.

> x <- list(a = 1:5, b = rnorm(10))
> lapply(x,mean)

> x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
> lapply(x, mean)

> x <- 1:4
> lapply(x, runif)


> x <- 1:4
> lapply(x, runif, min = 0, max = 10) you can add more arguments munipulating the function.

##_lapply_ and friends make heavy use of anonymous functions.
> x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2)) 
#An anonymous function for extracting the first column of each matrix.
> lapply(x, function(elt) elt[,1])

###Sapply
_sapply_ will try to simplify the result of _lapply_ if possible.
* If the result is a list where every element is length 1, then a vector is returned.
* If the result is a list where every element is a vector of the same length (> 1), a matrix is returned.
* If it can't figure things out, a list is returned.

> x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
> lapply(x, mean)

> sapply(x, mean)

###apply
_apply_ is used to evaluate a function (often an anonymous one) over the _margins_, or say dimensions, of an array.
* It is most often used to apply a function to the rows or columns of a matrix
* It can be used with general arrays, e.g. taking the average of an array of matrices
* It is not really faster than writing a loop, but it works in one line!

> str(apply)
function (X, MARGIN, FUN, ...)

* x is an array
* MARGIN is an integer vector indicating which margins should be "retained".
* ... is for other arguments to be passed to FUN
> x <- matrix(rnorm(200), 20, 10)
> apply(x, 2, mean) # 2 stands for column
> apply(x, 1, sum) # 1 stands for row

##col/row sums and means col/row sums and means

For sums and means of matrix dimensions, we have some shortcuts.
* rowSums = apply(x, 1, sum)
* rowMeans = apply(x, 1, mean)
* colSums = apply(x, 2, sum)
* colMeans = apply(x, 2, mean)

The shortcut functions are _much_ faster, but you won¡¯t notice unless you¡¯re using a large matrix.

###Other Ways to Apply Other Ways to Apply
Quantiles of the rows of a matrix.

> x <- matrix(rnorm(200), 20, 10)

> apply(x, 1, quantile, probs = c(0.25, 0.75))

##Average matrix in an array
> a <- array(rnorm(2 * 2 * 10), c(2, 2, 10)) # build a list of 10 2x2 matrices
> apply(a, c(1, 2), mean) # mean of [1,1], [1,2],[2,1] and [2,2] of all matrices.

> rowMeans(a, dims = 2) # the same thing done with rowMeans

###tapply
_tapply_ is used to apply a function over subsets of a vector.

> str(tapply)
function (X, INDEX, FUN = NULL, ..., simplify = TRUE)
* X is a vector
* INDEX is a factor or a list of factors (or else they are coerced to factors)
* FUN is a function to be applied
* ... contains other arguments to be passed FUN
* _simplify_, should we simplify the result?

> x <- c(rnorm(10), runif(10), rnorm(10, 1))
> f <- gl(3, 10)
> f
>
 [1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3

> [24] 3 3 3 3 3 3 3
> Levels: 1 2 3

> tapply(x, f, mean)

> 1 2 3
0.1144464 0.5163468 1.2463678

Take group means without simplification.
> tapply(x, f, mean, simplify = FALSE)

> $‘1’
> [1] 0.1144464

> $‘2’
> [1] 0.5163468

> $‘3’
> [1] 1.246368

###split
_split_ takes a vector or other objects and splits it into groups determined by a factor or list of factors.

> str(split)
function (x, f, drop = FALSE, ...)

* x is a vector (or list) or data frame
* f is a factor (or coerced to one) or a list of factors
* drop indicate whether empty factors levels should be dropped

> x <- c(rnorm(10), runif(10), rnorm(10, 1))
> f <- gl(3, 10)
> split(x, f)

$‘1’
 [1] -0.8493038 -0.5699717 -0.8385255 -0.8842019
 [5] 0.2849881 0.9383361 -1.0973089 2.6949703
 [9] 1.5976789 -0.1321970
 
$‘2’
 [1] 0.09479023 0.79107293 0.45857419 0.74849293
 [5] 0.34936491 0.35842084 0.78541705 0.57732081
 [9] 0.46817559 0.53183823
 
$‘3’
 [1] 0.6795651 0.9293171 1.0318103 0.4717443
 [5] 2.5887025 1.5975774 1.3246333 1.4372701

> lapply(split(x, f), mean)

$‘1’
[1] 0.1144464

$‘2’
[1] 0.5163468

$‘3’
[1] 1.246368

> library(datasets)
> head(airquality)
> s <- split(airquality, airquality$Month)
> lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
# apply a function to columns in a neater way
> sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])) 
> sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))

###Splitting on More than One Level Splitting on More than One Level
> x <- rnorm(10)
#creating two factor vectors
> f1 <- gl(2, 5)
> f2 <- gl(5, 2)
# join the two factor vectors
> interaction(f1, f2)

#split x by the join factor levels of f1 and f2
split(x, list(f1, f2))
str(split(x, list(f1, f2)))
# dropping empty factor levels
> str(split(x, list(f1, f2), drop = TRUE))

###mapply
_mapply_ is a multivariate apply of sorts which applies a function in parallel over a set of arguments.

> str(mapply)
function (FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE,
 USE.NAMES = TRUE)

* FUN is a function to apply
* ... contains arguments to apply over
* MoreArgs is a list of other arguments to FUN
* SIMPLIFY indicates whether the result should be simplified

# a tedious method to produce several repeating vectors
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))

# Instead we can do
> mapply(rep, 1:4, 4:1)

##Instant Vectorization
> noise <- function(n, mean, sd) {
+ rnorm(n, mean, sd)
+ }

> mapply(noise, 1:5, 1:5, 2)

#Which is the same as 
list(noise(1, 1, 2), noise(2, 2, 2), noise(3, 3, 2), noise(4, 4, 2), noise(5, 5, 2))