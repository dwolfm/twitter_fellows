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
   var colorTheme:ColorTheme = ColorTheme()
   let networkController = NetworkController()
   @IBOutlet weak var tableView: UITableView!
   var time_to_set: String = ""

   override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "tweet fellows"
      self.navigationController?.navigationBar.barStyle = UIBarStyle(rawValue: 1)!
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
      let tweet = tweets[indexPath.row]
      let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL") as TweetCell
      cell.usernameLabel.text = tweet.username
      cell.tweetTextLabel.text = tweet.text
      cell.tweetTextLabel.layer.cornerRadius = 5
      cell.tweetTextLabel.layer.masksToBounds = true
      
//      networkController.fetchPhotoID(tweets[indexPath.row].userPhotoId! , photoURL: tweets[indexPath.row].userPhotoUrl!)
      networkController.fetchImageFromURL(&tweet.userPhotoId, photoURL: tweet.userPhotoUrl!)
      cell.userPhotoId?.image = tweet.userPhotoId
      cell.userPhotoId?.layer.cornerRadius = 35.0
      cell.userPhotoId?.layer.masksToBounds = true
      
      //layer.borderColor = [UIColor lightGrayColor].CGColor;
      cell.userPhotoId?.layer.borderColor = UIColor.blackColor().CGColor
      cell.userPhotoId?.layer.borderWidth = 4.0
//      cell.backgroundColor = self.colorTheme.randCellColors[indexPath.row % 5]
      cell.backgroundColor = UIColor(netHex: 0xfabbff)

      println(self.colorTheme.randCellColors[indexPath.row % 5])
      println(tweet.tweetID)
      return cell
   }
   
   
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      let detailTweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("DETAIL_VIEW") as DetailTweetViewController
      let tweetSelected = self.tweets[indexPath.row]
      detailTweetVC.tweet = tweetSelected
      detailTweetVC.networkController = self.networkController
      navigationController?.pushViewController(detailTweetVC, animated: true)
      
   }
   


    @IBAction func handlepinch(recognizer: UIPinchGestureRecognizer){
        if recognizer.state == UIGestureRecognizerState.Ended {
            self.networkController.fetchHomeTimeLine { (tweets, errorString) -> () in
                if errorString == nil {
                    self.tweets = tweets!
                    self.tableView.reloadData()
                    println("pinch has reloded data")
                } else {
                    let alert = UIAlertView()
                    alert.message = errorString!
                    alert.show()
                    println("pinch failed to reload data")
                    
                }
            }

        }
    }
   

   


   
}