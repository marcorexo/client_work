REBOL [
    Title: "Customer Details & Signature Saver"
    Date: 4-Nov-2024
    Purpose: "GUI for capturing and saving customer details with signature"
    Author: "Marc Edwards"
]

; Check if all text fields are filled
completed-text-fields?: func [fullName address telephone] [
    all [
        not empty? fullName/text
        not empty? address/text
        not empty? telephone/text
    ]
]

generate-folder-name: func [base-folder fullName] [
    ; Generate folder name with no spaces and formatted date-time
    current-date-time: now
    time-part: replace/all to-string current-date-time/time ":" "-"
    join base-folder [
        replace/all fullName/text " " "" "-" 
        current-date-time/date "-" time-part
    ]
]

; Check if the canvas has a signature
has-signature?: func [] [
    greater? length? scrn/effect/draw 1
]

save-image-file: func [folder-name] [
    save/png join folder-name %/signature.png to-image layout [
        origin 0x0
        box black 600x200 effect scrn/effect
    ]
]

save-data-file: func [folder-name fullName address telephone] [
    write join folder-name %/details.txt reform [
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
            either all [
                completed-text-fields? fullName address telephone
                has-signature?
            ][
                base-folder: request-dir
                if base-folder [
                    folder-name: generate-folder-name base-folder fullName
                    print folder-name
                    make-dir/deep folder-name
                    save-image-file folder-name
                    save-data-file folder-name fullName address telephone
                ]
            ][
                alert "Please fill all fields with a signature."
            ]
        ]

        btn "Clear" [scrn/effect/draw: copy [line] show scrn]
    return
]
