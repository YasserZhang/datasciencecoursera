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


