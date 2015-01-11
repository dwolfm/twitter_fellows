//
//  old_code.swift
//  tweet_fellows
//
//  Created by nacnud on 1/6/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

// parse json file and make Tweets
//      if let jsonArray = getJsonArray("tweet.json") {
//         parseTweetsFromJsonArray(jsonArray)
//      }
//
//   func getJsonArray(file: String) -> [AnyObject]? {
//      let fileSplit = file.componentsSeparatedByString(".")
//      let filename = fileSplit[0]
//      let filetype = fileSplit[1]
//      var result : [AnyObject]?
//      if let jsonPath = NSBundle.mainBundle().pathForResource(filename, ofType: filetype) {
//         if let jsonData = NSData(contentsOfFile: jsonPath) {
//            var error: NSError?
//            if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [AnyObject] {
//               result =  jsonArray
//            }
//         }
//      }
//      return result
//   }
//
//   func parseTweetsFromJsonArray(jsonArray:[AnyObject]){
//      for object in jsonArray {
//         if let jsonDictionary = object as? [String: AnyObject] {
//            let tweet = Tweet(jsonDictionary)
//            tweets.append(tweet)
//         }
//      }
//   }
//
//navigationController.setNavigationBarHidden(false, animated:true)
//var myBackButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//myBackButton.addTarget(self, action: "popToRoot:", forControlEvents: UIControlEvents.TouchUpInside)
//myBackButton.setTitle("YOUR TITLE", forState: UIControlState.Normal)
//myBackButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//myBackButton.sizeToFit()
//var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
//self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem