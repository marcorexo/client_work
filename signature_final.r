REBOL []

; check if text fields are all fileld
check-text-fields: func [fullName address telephone] [
     either all [
            not empty? fullName/text
            not empty? address/text
            not empty? telephone/text
    ][ return true]
    [ return false]
]

generate-file-name: func [base-folder] [
    ; Remove spaces from full name
    name-no-spaces: replace/all fullName/text " " ""
    ; Function to pad numbers with zero if needed
    pad-zero: func [n][either n < 10 ["0" to-string n][to-string n]]
    ; Get current date and time
     current-date-time: now
    ; Extract date components
    date-part: current-date-time/date
    time-part: current-date-time/time

    return join name-no-spaces "-" date-part
]

view layout [
    h2 "Enter Customer Details"
    text "Full name:" fullName: field 300
    text "Address:" address: field 300
    text "Telephone:" telephone: field 300

    is-filled: false
    btn "Check" [
        is-filled: check-text-fields fullName address telephone
        if is-filled [
            base-folder: request-dir
                if exists? base-folder [
                    file-name: generate-file-name base-folder
                    print file-name
                ]
        ]
    ]
]



