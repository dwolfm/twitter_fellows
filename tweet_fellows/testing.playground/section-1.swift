// Playground - noun: a place where people can play

import UIKit


let haha = "lulwat.json"



let  file = haha.componentsSeparatedByString(".")

let filename = file[0]
let filetype = file[1]


var testString = "hello string"


func changeString(inout str:String){
   println("beforeChange: \(str)")
   str = "changed"
   println("afterChange: \(str)")

}


var color = 0xffaa05
var red = color - 0xffff00

var num:Int = 0xfa
var fist = num - 0x0f





changeString(&testString)

println("afterFunc: \(testString)")


let string = "123 Main St. / (555) 555-5555"
let types: NSTextCheckingType = .Address | .PhoneNumber
let scrnme: NSTextCheckingType = NSTextCheckingType.RegularExpression
var error: NSError?
let detector = NSDataDetector(types: types.rawValue, error: &error)

detector?.enumerateMatchesInString(string, options: nil, range: NSMakeRange(0, (string as NSString).length)) { (result, flags, _) in
    println(result)
}
        