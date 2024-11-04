REBOL[]

square: func [x] [
    x * x
]

calculate-area: func [height width] [
    height * width
]

check-age: func [age] [
    either age >= 18 [
        print "You are an adult."
    ][
        print "You are a minor."
    ]
]

greet-user: func [name /formal] [
    either formal [
        print ["Good day, " name]
    ][
        print ["Hi, " name]
    ]
]

print square 5
print calculate-area 4 6
check-age 25
greet-user/formal "Alice"
greet-user "Bob"

print "Press enter to exit."
input