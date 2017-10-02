//: Playground - noun: a place where people can play

import Foundation
import ObjectiveC

let str = "Hello, playground"
let index = str.index(str.startIndex, offsetBy: 1)
let newStr = str[index..<str.endIndex]
let newStr2 = str[..<index]

let s = "e\u{301}galite\u{301}"           // "égalité"
let i = Array(s.unicodeScalars.indices)

s[i[1]...]
s[..<i.last!]
s[i[1]]
s[i[1]..<i[4]]

