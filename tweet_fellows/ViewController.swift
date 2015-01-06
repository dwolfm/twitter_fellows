//
//  ViewController.swift
//  tweet_fellows
//
//  Created by nacnud on 1/5/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
   
   var tweets : [Tweet] = []
   @IBOutlet weak var tableView: UITableView!

   override func viewDidLoad() {
      super.viewDidLoad()
      tableView.dataSource = self
      
      // parse json file and make Tweets
      if let jsonArray = getJsonArray("tweet.json") {
         parseTweetsFromJsonArray(jsonArray)
      }
      
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   
   // Conform to UITableViewDataSource
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tweets.count
   }
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL") as TweetCell
      cell.usernameLabel.text = tweets[indexPath.row].username
      cell.tweetTextLabel.text = tweets[indexPath.row].text
      return cell
   }


   func getJsonArray(file: String) -> [AnyObject]? {
      let fileSplit = file.componentsSeparatedByString(".")
      let filename = fileSplit[0]
      let filetype = fileSplit[1]
      var result : [AnyObject]?
      if let jsonPath = NSBundle.mainBundle().pathForResource(filename, ofType: filetype) {
         if let jsonData = NSData(contentsOfFile: jsonPath) {
            var error: NSError?
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [AnyObject] {
               result =  jsonArray
            }
         }
      }
      return result
   }
   
   func parseTweetsFromJsonArray(jsonArray:[AnyObject]){
      for object in jsonArray {
         if let jsonDictionary = object as? [String: AnyObject] {
            let tweet = Tweet(jsonDictionary)
            tweets.append(tweet)
         }
      }
   }
   
}