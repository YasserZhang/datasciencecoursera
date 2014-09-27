| When you are at the R prompt (>):
| -- Typing skip() allows you to skip the current question.
| -- Typing play() lets you experiment with R on your own; swirl will ignore what you do...
| -- UNTIL you type nxt() which will regain swirl's attention.
| -- Typing bye() causes swirl to exit. Your progress will be saved.
| -- Typing main() returns you to swirl's main menu.
| -- Typing info() displays these options again.
-------------------------------------------------------------------
| If at any point you'd like more information on a particular topic related to R, you can type help.start() at the prompt,
| which will open a menu of resources (either within RStudio or your default web browser, depending on your setup).
| Alternatively, a simple web search often yields the answer you're looking for.
-------------------------------------------------------------------
| Anytime you have questions about a particular function, you can access R's built-in help files via the `?` command. For
| example, if you want more information on the c() function, type ?c without the parentheses that normally follow a function
| name. Give it a try.
--------------------------------------------------------------------------------
| When given two vectors of the same length, R simply performs the specified arithmetic operation (`+`, `-`, `*`, etc.)
| element-by-element. If the vectors are of different lengths, R 'recycles' the shorter vector until it is the same length as
| the longer vector.
-------------------------------------------------------------------
| If the length of the shorter vector does not divide evenly into the length of the longer vector, R will still apply the
| 'recycling' method, but will throw a warning to let you know something fishy might be going on.

3: Vectors

| Vectors come in two different flavors: atomic vectors and lists. An atomic vector contains exactly one data type, whereas a list may contain multiple data types.
-------------------------------------------------------------------

5: Subsetting vectors

| Index vectors come in four different flavors -- logical vectors, vectors of positive integers, vectors of negative integers, and
| vectors of character strings

| What if we're interested in all elements of x EXCEPT the 2nd and 10th? It would be pretty tedious to construct a vector containing all numbers 1 through
| 40 EXCEPT 2 and 10.

| Luckily, R accepts negative integer indexes. Whereas x[c(2, 10)] gives us ONLY the 2nd and 10th elements of x, x[c(-2, -10)] gives us all elements of x
| EXCEPT for the 2nd and 10 elements. 

| A shorthand way of specifying multiple negative numbers is to put the negative sign out in front of the vector of positive numbers. Type x[-c(2, 10)] to
| get the exact same result.
-------------------------------------------------------------------
6: Matrices and Data Frames

let's check that vect and vect2 are the same by passing them as arguments to the identical() function

when we tried to combine a character vector with a numeric matrix, R was forced to 'coerce' the numbers to
| characters, hence the double quotes.

| This is called 'implicit coercion', because we didn't ask for it. It just happened.
-------------------------------------------------------------------
7: lapply and sapply

| These powerful functions, along with their close relatives (vapply() and tapply(), among others) offer a concise and
| convenient means of implementing the Split-Apply-Combine strategy for data analysis.

