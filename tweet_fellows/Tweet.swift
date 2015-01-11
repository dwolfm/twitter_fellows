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
   var username: String
   var screenName: String
   var tweetID: String 
   var createdAt: String?
   var favorites: Int?
   var text: String
   var userPhotoUrl: NSURL?
   var userPhotoId: UIImage?
   var userBackgroundPhotoUrl: NSURL?
   var userBackgroundPhoto: UIImage?

   
   init( _ jsonDictionary: [String: AnyObject] ){
      self.text = jsonDictionary["text"] as String
      self.tweetID = jsonDictionary["id_str"] as String
      let dict = jsonDictionary["user"] as [String: AnyObject]
      self.username = dict["name"] as String
      self.screenName = dict["screen_name"] as String
      if let userPhotoUrlString = dict["profile_image_url"] as? String {
         if let url = NSURL(string: userPhotoUrlString) {
            self.userPhotoUrl = url
         }
      }
    
    

      if let userBackgroundPhotoUrlString = dict["profile_background_image_url"] as? String {
         if let url = NSURL(string: userBackgroundPhotoUrlString){
            self.userBackgroundPhotoUrl = url
         }
      }
   }
}

