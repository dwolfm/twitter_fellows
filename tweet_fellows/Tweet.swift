//
//  Tweet.swift
//  tweet_fellows
//
//  Created by nacnud on 1/5/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

import Foundation
import UIKit

class Tweet{
   var text:String
   var username:String
   var userPhotoId: UIImage?
   
   init( _ jsonDictionary: [String: AnyObject] ){
      self.text = jsonDictionary["text"] as String
      let dict = jsonDictionary["user"] as [String: AnyObject]
      self.username = dict["name"] as String
      if let userPhotoUrlString = dict["profile_image_url"] as? String {
         let userPhotoUrl = NSURL(string: userPhotoUrlString)
         let userPhotoData = NSData(contentsOfURL: userPhotoUrl!)
         self.userPhotoId = UIImage(data: userPhotoData!)
      }

      
   }
}
