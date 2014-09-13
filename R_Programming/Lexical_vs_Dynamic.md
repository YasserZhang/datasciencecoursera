##How R seaches a value that is bound to a symbol
When R tries to bind a value to a symbol, it searches through a series of *environments* to find the appropriate value. When you are working on the command line and need to retrieve the value of an R object, the order is roughly
*1. Search the golabl environment for a symbol name matching the one requested.
*2. Search the namespaces of each of the packages on the search list.
The search list can be found by using the *search* function.
##Seveval points to be paid attention to:
*The _global environment_ or the user's workspace is always the first element of the search list and the _base_ package is always the last.
*The order of the packages on the search list matters!
*Users can configure which packages get loaded on startup so you cannot assume that there will be a set list of packages available.
*When a user loads a package with _library_ the namespace of that package gets put in position 2 of the search list (by default) and everything else gets shifted down the list.
*Note that R has separate namespaces for functions and non-functions so it's possible to have an object names c and a function named c.

##Scoping Rules
The scoping rules for R are the main feature that make it different from the original S language.
*The scoping rules determine how a value is associated with a free variable in a function. A free variable is a variable not defined in the function and computer has to find its definition out of the function.
*R uses _lexical scoping_ or _static scoping_, as opposed to _dynamic scoping_.
*Related to the scoping rules is how R uses the search _list_ to bind a value to a symbol
*Lexical scoping turns out to be particularly useful for simplifying statistical computations
Consider the following function
f <- function(x, y) {
 x^2 + y / z
}
This function has 2 formal arguments x and y. In the body of the function there is another symbol z.
In this case z is called a free variable. The scoping rules of a language determine how values are
assigned to free variables. Free variables are not formal arguments and are not local variables
(assigned insided the function body).

###Lexical scoping in R means that
the values of free variables are searched for in the environment in which the function was deﬁned.
###What is an environment?
*An _environment_ is a collection of (symbol, value) pairs, i.e. x is a symbol and 3.14 might be its
value.
*Every environment has a parent environment; it is possible for an environment to have multiple
“children”
*the only environment without a parent is the empty environment
*A function + an environment = a _closure_ or _function closure_.

##Searching for the value for a free variable:
*If the value of a symbol is not found in the environment in which a function was deﬁned, then the search is continued in the parent environment.
*The search continues down the sequence of parent environments until we hit the top-level environment; this usually the global environment (workspace) or the namespace of a package.
*After the top-level environment, the search continues down the search list until we hit the empty environment. If a value for a given symbol cannot be found once the empty environment is arrived at, then an error is thrown.

#Lexical vs. Dynamic Scoping
y <- 10
f <- function(x) {
 y <- 2
 y^2 + g(x)
}
g <- function(x) { 
 x*y
}
## what is the value of 
f(3)

* With lexical scoping the value of y in the function g is looked up in the environment in which the function was defined, in this case the global environment, so the value of y is 10.
* With dynamic scoping, the value of y is looked up in the environment from which the function was _called_ (sometimes referred to as the _calling environment_)
	-- In R the calling envrionment is known as the _parent frame_
For example, a function can be defined in the global environment, and is called inside another function, in which case the global environment is the defining environment and the latter function is the calling environment.
* So the value of y would be 2

When a function is deﬁned in the global environment and is subsequently called from the global
environment, then the deﬁning environment and the calling environment are the same. This can
sometimes give the appearance of dynamic scoping.

### Consequences of Lexical Scoping
* In R, all objects must be stored in memory
* All functions must carry a pointer to their respective defining environments, which could be anywhere
* In S-PLUS, free variables are always looked up in the global workspace, so everything can be stored on the disk because the "defining environment" of all functions is the same.

##静态值域和动态值域的区别
R采用的是静态值域。
两者的区别主要在于搜寻自由变量的值的方法的不同。
采用静态值域时，计算机在运行某函数时如果遇到自由变量符号，计算机会先到函数被定义时所在的环境中寻找这个自由变量的符号，然后发现其对应的值；而采用动态值域时，计算机则会先到该函数被调用时所在的环境中寻找这个自由变量符号及其对应值。