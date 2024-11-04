REBOL []

temperature: 32
score: 72

if temperature >= 30 [
    print "It's a hot day!"
]

either score >= 50 [
    print "You passed the exam!"
] [
    print "You failed the exam."
]

number: 1
loop 10 [
    print number
    number: number + 1
]

colors: ["red" "green" "blue"]

foreach color colors [
    print color
]

print "Press enter to exit."
input