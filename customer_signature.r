REBOL[
    Title: "Take a signature"
    Date: 1-1-2024
    File: %customer_signature.r
    Purpose: {
        This is a sample script that takes a signature from the user.
    }
]

 view layout [
    h1 "Paint with the mouse:"
    scrn: box black 400x400 feel [
        engage: func [face action event] [
            if find [down over] action [
                append scrn/effect/draw event/offset show scrn
            ]
            if action = 'up [append scrn/effect/draw 'line]
        ]
    ] effect [draw [line]]

    btn "Save" [
        save/png %/c/painting.png to-image layout [
            origin 0x0 box black 400x400 effect pick get scrn 9
        ] alert "Saved to C:\painting.png"
    ]
    btn "Clear" [scrn/effect/draw: copy [line] show scrn]
 ]