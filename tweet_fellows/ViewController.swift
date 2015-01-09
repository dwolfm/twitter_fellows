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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
   
   var tweets: [Tweet] = []
   let networkController = NetworkController()
   @IBOutlet weak var tableView: UITableView!
   var time_to_set: String = ""

   override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "tweet fellows"
      
      // setup tableView
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TWEET_CELL")
    self.tableView.estimatedRowHeight = 100
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
      self.networkController.fetchHomeTimeLine { (tweets, errorString) -> () in
         if errorString == nil {
            self.tweets = tweets!
            self.tableView.reloadData()
         } else {
            let alert = UIAlertView()
            alert.message = errorString!
            alert.show()
            
         }
      }
  } // view did load
   
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
      networkController.fetchPhotoID(tweets[indexPath.row], photoURL: tweets[indexPath.row].userPhotoUrl!)
      cell.userPhotoId?.image = tweets[indexPath.row].userPhotoId
      println(tweets[indexPath.row].tweetID)
      
      return cell
   }
   
   
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      let detailTweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("DETAIL_VIEW") as DetailTweetViewController
      let tweetSelected = self.tweets[indexPath.row]
      detailTweetVC.tweet = tweetSelected
      detailTweetVC.networkController = self.networkController
      navigationController?.pushViewController(detailTweetVC, animated: true)
      
   }
   
   
   


   
}