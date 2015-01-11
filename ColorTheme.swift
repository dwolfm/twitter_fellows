//
//  ColorTheme.swift
//  tweet_fellows
//
//  Created by nacnud on 1/9/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

import Foundation
import UIKit


/// i got this UICOLOR Converter from stack overflow by Sulthan
//http://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
      assert(red >= 0 && red <= 255, "Invalid red component")
      assert(green >= 0 && green <= 255, "Invalid green component")
      assert(blue >= 0 && blue <= 255, "Invalid blue component")
      
      self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
   
   convenience init(netHex:Int) {
      self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
   }
}

class ColorTheme {
   var randCellColors: [UIColor] = []
   
   init (){

      let poiple = UIColor(red: CGFloat(165.0/255.0), green: CGFloat(165.0/255.0), blue: CGFloat(232.0/255.0), alpha: CGFloat(1))
      let geen = UIColor(red: 149.0/255.0, green: 255.0/255.0, blue: 217.0/255.0, alpha: 255.0/255.0)
      let pink = UIColor(red: 255.0/255.0, green: 158.0/255.0, blue: 182.0/255.0, alpha: 255.0/255.0)
      let yella = UIColor(red: 219.0/255.0, green: 253.0/255.0, blue: 144.0/255.0, alpha: 255.0/255.0)
      let buu = UIColor(red: 162.0/255.0, green: 221.0/255.0, blue: 255.0/255.0, alpha: 255.0/255.0)
    
      self.randCellColors.append(geen)
      self.randCellColors.append(pink)
      self.randCellColors.append(yella)
      self.randCellColors.append(buu)

   }
}