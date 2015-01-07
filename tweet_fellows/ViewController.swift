//
//  ViewController.swift
//  tweet_fellows
//
//  Created by nacnud on 1/5/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

import UIKit
import Accounts
import Social

class ViewController: UIViewController, UITableViewDataSource {
   
   var tweets : [Tweet] = []
   @IBOutlet weak var tableView: UITableView!

   override func viewDidLoad() {
      super.viewDidLoad()
      self.tableView.dataSource = self

      let accountStore = ACAccountStore()
      let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
      
      accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
         if granted {
            let accounts = accountStore.accountsWithAccountType(accountType)
            if !accounts.isEmpty {
               let twitterAccount = accounts.first as ACAccount
               let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
               let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
               twitterRequest.account = twitterAccount
               twitterRequest.performRequestWithHandler(){ (data, response, error) -> Void in
                  switch response.statusCode {
                  case 200...299:
                     println("killin it, statuscode: \(response.statusCode)")
                     
                     if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] {
                        for object in jsonArray {
                           if let jsonDictionary = object as? [String: AnyObject] {
                              let tweet = Tweet(jsonDictionary)
                              self.tweets.append(tweet)
                              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                 self.tableView.reloadData()
                              })
                           } else {
                              println("failed to fill jsonArray")
                           }
                           
                        }
                     }
                  case 300...599:
                     println("this is bad! \(response.statusCode)")
                  default:
                     println("fail")
                  }
               }
            }
         }
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
      cell.userPhotoId?.image = tweets[indexPath.row].userPhotoId
      return cell
   }


   
}