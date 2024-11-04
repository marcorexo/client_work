REBOL []

numbers: [1 2 3 4 5]

append numbers 6
remove at numbers 2

print numbers

text: "REBOL Programming"
print lowercase text
print find text "pro"

fruits: ["apple" "banana" "cherry" "date"]
foreach fruit fruits[
    print fruit
]

if find fruits "banana" [
    print "Banana is in the list"
]

mixed-data: [1 "two" 3 "four" 5]



sum-numbers: func [block][
    total: 0
    foreach item block [
        if number? item [total: total + item]
    ]
    return total
]

print ["Sum: " sum-numbers mixed-data]

print "Press enter to exit."
input
