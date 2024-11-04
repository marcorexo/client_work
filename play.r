REBOL []

REBOL []

view layout [
    h2 "Enter Customer Details"
    text "Full name:" fullName: field 300
    text "Address:" address: field 300
    text "Telephone:" telephone: field 300

    btn "Check" [
        either all [
            not empty? fullName/text
            not empty? address/text
            not empty? telephone/text
        ] [
            print "all filled"
        ][
            print "incomplete"
        ]
    ]
]



