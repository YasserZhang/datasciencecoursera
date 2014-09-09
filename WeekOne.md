###R has ﬁve basic or “atomic” classes of objects:

###The most basic object is a vector

* character
* numeric (real numbers)
* integer
* complex
* logical (True/False)

A vector can only contain objects of the same class
BUT: The one exception is a list, which is represented as a vector but can contain objects of
different classes (indeed, that’s usually why we use them)
Empty vectors can be created with the vector() function.

##Numbers
* Numbers in R a generally treated as numeric objects (i.e. double precision real numbers)
* If you explicitly want an integer, you need to specify the L sufﬁx
Ex: Entering 1 gives you a numeric object; entering 1L explicitly gives you an integer.
* There is also a special number ####Inf which represents inﬁnity; e.g. 1 / 0;
Inf can be used in ordinary calculations; e.g. 1 / Inf is 0
* The value NaN represents an undeﬁned value (“not a number”); e.g. 0 / 0;
NaN can also be thought of as a missing value (more on that later)





