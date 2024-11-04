REBOL[]

greet: func [] [
    print "Hello, REBOL!"
]

display-message: func [/greeting name] [
    either greeting [
        print ["Hello," name "!"]
    ][
        print ["Goodbye," name "!"]
    ]
]

display-message/greeting "Alice"  ; Outputs: Hello, Alice!
display-message "Bob"             ; Outputs: Goodbye, Bob!


print "Press enter to exit."
input