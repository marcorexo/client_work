REBOL[
    Title: "Take a signature"
    Date: 1-1-2024
    File: %customer_signature.r
    Purpose: {
        This is a sample script that takes a signature from the user.
    }
]

view layout [
    h2 "Enter Customer Details"
    text "Full name:" fullName: field 300
    text "Address:" address: field 300
    text "Telephone:" telephone: field 300
    
    h1 "Paint with the mouse:"
    scrn: box black 600x200 feel [
        engage: func [face action event] [
            if find [down over] action [
                append scrn/effect/draw event/offset show scrn
            ]
            if action = 'up [append scrn/effect/draw 'line]
        ]
    ] effect [draw [line]]

    btn "Save" [
        either all [fullName/text address/text telephone/text] [
            ; Request a folder from the user
            base-folder: request-dir
            if exists? base-folder [
                ; Remove spaces from full name
                name-no-spaces: replace/all fullName/text " " ""
                ; Function to pad numbers with zero if needed
                pad-zero: func [n][either n < 10 ["0" to-string n][to-string n]]
                ; Get current date and time
                current-date-time: now
                ; Extract date components
                date-part: current-date-time/date
                year: date-part/year
                month: date-part/month
                day: date-part/day
                ; Extract time components
                time-part: current-date-time/time
                hour: time-part/hour
                minute: time-part/minute
                second: time-part/second
                ; Format date and time strings without special characters
                date-str: rejoin [
                    to-string year
                    pad-zero month
                    pad-zero day
                ]
                time-str: rejoin [
                    pad-zero hour
                    pad-zero minute
                    pad-zero to-integer second
                ]
                ; Generate a folder name based on full name and current date-time
                folder-name: join base-folder to-file rejoin [
                    name-no-spaces "_" date-str "_" time-str
                ]
                print folder-name
                make-dir/deep folder-name
                
                ; Save the image in the new folder
                image-file: join folder-name %/signature.png
                save/png image-file to-image layout [
                    origin 0x0 box black 600x200 effect pick get scrn 9
                ]
                
                ; Save the details in a text file in the same folder
                text-file: join folder-name %/details.txt
                write text-file reform [
                    "Full name: " fullName/text newline
                    "Address: " address/text newline
                    "Telephone: " telephone/text
                ]
                
                alert join "Saved to " folder-name
            ]
        ][
            alert "Please fill in all fields before saving."
        ]
    ]
    
    btn "Clear" [scrn/effect/draw: copy [line] show scrn]
]
