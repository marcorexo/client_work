REBOL []

; check if text fields are all filled
completed-text-fields?: func [fullName address telephone] [
     either all [
            not empty? fullName/text
            not empty? address/text
            not empty? telephone/text
    ][ return true]
    [ return false]
]

generate-folder-name: func [base-folder] [
    ; Remove spaces from full name
    name-no-spaces: replace/all fullName/text " " ""
    ; Get current date and time
    current-date-time: now
    ; Extract date and time components
    date-part: current-date-time/date
    time-part: current-date-time/time

    return join base-folder ["-" name-no-spaces "-" date-part "-" time-part]
]

; Function to check if the canvas has a signature
has-signature: func [] [
    either greater? length? scrn/effect/draw 1 [
        return true
    ][
        return false
    ]
]

save-image-file: func [folder-name] [
    image-file: join folder-name %/signature.png
    save/png image-file to-image layout [
        origin 0x0
        box black 600x200 effect scrn/effect ; Use `scrn/effect` directly
    ]
]

save-data-file: func [folder-name] [
    text-file: join folder-name %/details.txt
    write text-file reform [
        "Full name: " fullName/text newline
        "Address: " address/text newline
        "Telephone: " telephone/text
    ]
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

    across
        btn "Save" green [
            text_fields_completed: completed-text-fields? fullName address telephone
            is-signed: has-signature

            ; Request a folder from the user
            either is-signed and text_fields_completed [
                base-folder: request-dir
                either all [base-folder not none? base-folder] [
                    folder-name: generate-folder-name base-folder
                    print folder-name
                    make-dir/deep folder-name
                    save-image-file folder-name
                    save-data-file folder-name
                ][
                    alert "No folder was selected. Please select a folder to save."
                ]
            ][
                alert "Please fill all fields with a signature."
            ]
        ] 

        btn "Clear" [scrn/effect/draw: copy [line] show scrn]
    return
]
