###R has ﬁve basic or “atomic” classes of objects:

###The most basic object is a vector

* character
* numeric (real numbers)
* integer
* complex
* logical (True/False)

_A vector can only contain objects of the same class_
BUT: The one exception is a list, which is represented as a vector but can contain objects of
different classes (indeed, that’s usually why we use them)
Empty vectors can be created with the vector() function.

##Numbers
* Numbers in R a generally treated as numeric objects (i.e. double precision real numbers)
* If you explicitly want an integer, you need to specify the L sufﬁx
Ex: Entering 1 gives you a numeric object; entering 1L explicitly gives you an integer.
* There is also a special number _Inf_ which represents inﬁnity; e.g. 1 / 0;
Inf can be used in ordinary calculations; e.g. 1 / _Inf_ is 0
* The value _NaN_ represents an undeﬁned value (“not a number”); e.g. 0 / 0;
NaN can also be thought of as a missing value (more on that later)

##Attributes
R objects can have attributes
* names, dimnames
* dimensions (e.g. matrices, arrays)
* class
* length
* other user-defined attributes/metadata
Attributes of an object can be accessed using the attributes()function.

###Entering Input
At the R prompt we type expressions. The <- symbol is the assignment operator.

###Evaluation
When a complete expression is entered at the prompt, it is evaluated and the result of the evaluated
expression is returned. The result may be auto-printed.
> x <- 5 ## nothing printed
>
> x ## auto-printing occurs
>
> [1] 5
>
> print(x) ## explicit printing
>
> [1] 5

The [1] indicates that x is a vector and 5 is the ﬁrst element.

###Creating Vectors
The c() function can be used to create vectors of objects.
> x <- c(0.5, 0.6) ## numeric
> x <- c(TRUE, FALSE) ## logical
> x <- c(T, F) ## logical
> x <- c("a", "b", "c") ## character
> x <- 9:29 ## integer
> x <- c(1+0i, 2+4i) ## complex

Using the vector() function
> x <- vector("numeric", length = 10) 
> x
 [1] 0 0 0 0 0 0 0 0 0 0
 
###Mixing Objects
What about the following?
> y <- c(1.7, "a") ## character
>
> y <- c(TRUE, 2) ## numeric
>
> y <- c("a", TRUE) ## character
>

When different objects are mixed in a vector, coercion occurs so that every element in the vector is
of the same class.

###Explicit Coercion
Objects can be explicitly coerced from one class to another using the as.* functions, if available.
> x <- 0:6
>
> class(x)
>
[1] "integer"
>
> as.numeric(x)
>
[1] 0 1 2 3 4 5 6

> as.logical(x)
>
[1] FALSE TRUE TRUE TRUE TRUE TRUE TRUE
> as.character(x)
>
[1] "0" "1" "2" "3" "4" "5" "6"
>

Nonsensical coercion results in NAs
> x <- c("a", "b", "c")
> as.numeric(x)
[1] NA NA NA
Warning message:
NAs introduced by coercion
> as.logical(x)
[1] NA NA NA
> as.complex(x)
[1] 0+0i 1+0i 2+0i 3+0i 4+0i 5+0i 6+0i

###Matrices
Matrices are vectors with a dimension attribute. The dimension attribute is itself an integer vector of length 2(nrow, ncol)

Matrices are constructed column-wise, so entries can be thought of starting in the “upper left” corner
and running down the columns.
> m <- matrix(1:6, nrow = 2, ncol = 3) 
> m
    [,1] [,2] [,3]
[1,] 1    3     5
[2,] 2    4     6

Matrices can also be created directly from vectors by adding a dimension attribute.
> m <- 1:10 
> m
[1] 1 2 3 4 5 6 7 8 9 10 
> dim(m) <- c(2, 5)
> m
    [,1] [,2] [,3] [,4] [,5]
[1,] 1    3     5   7     9
[2,] 2    4     6   8     10

###cbind-ing and rbind-ing
Matrices can be created by column-binding or row-binding with cbind() and rbind().

###Lists
Lists are a special type of vector that can contain elements of different classes. Lists are a very
important data type in R and you should get to know them well.








