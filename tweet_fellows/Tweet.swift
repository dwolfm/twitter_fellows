//
//  Tweet.swift
//  tweet_fellows
//
//  Created by nacnud on 1/5/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

import Foundation

class Tweet{
   var text:String
   var username:String
   
   init( _ jsonDictionary: [String: AnyObject] ){
      self.text = jsonDictionary["text"] as String
      let dict = jsonDictionary["user"] as [String: AnyObject]
      self.username = dict["name"] as String
      }
}
