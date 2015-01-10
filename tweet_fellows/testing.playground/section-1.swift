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


