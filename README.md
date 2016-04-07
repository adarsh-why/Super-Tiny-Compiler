# Super-Tiny-Compiler
A Super Tiny compiler written based on the same by James kyle at https://github.com/thejameskyle/the-super-tiny-compiler

Try following input in terminal after running compiler.rb
----------------------------------------------------------

(add 3 (subtract 4 6))

(add 3 (subtract 4 (add 7 8)))

(add (subtract 5 7) (add 19 34) )

(add (add 2 3) (subtract 6 (add 9 2)  )  )


Add following statements inside run_compiler function to print tokens and AST
-----------------------------------------------------------------------------

puts "\n\n#{input}\n\n" ---  Prints Input 
puts "#{@tokens}\n\n"   ---  Prints tokenized input
puts "#{parser}\n\n"    ---  Prints Abstract Syntax Tree
