REBOL[]

; Define an integer variable with any value and print it.
integer-variable: 10
print rejoin ["Value of the integer variable: " integer-variable]
; rejoin combines the series of strings and values into a single string.


; Define a string variable containing your name and print it.
name: "John Doe" 
print rejoin ["Name: " name]

; Define a block with at least three different data types and print it.
data-types: [
    20
    "Hello, World!"
    true
    [1 2 3 4 5]
    [name: "John" age: 30]
]


print data-types

; Define two string variables and concatenate them.
str1: "Hello, "
str2: "World!"
result: join str1 str2
print result

print "Press enter to exit."
input