//
//  DetailTweetViewController.swift
//  tweet_fellows
//
//  Created by nacnud on 1/7/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//


/////////////----------------->>> THESE ARE THE TWEET PROPERTIES
//var username: String
//var screenName: String
//var tweetID: String
//var createdAt: String?
//var favorites: Int?
//var text: String
//var userPhotoUrl: NSURL?
//var userPhotoId: UIImage?
//var userBackgroundPhotoUrl: NSURL?
//var userBackgroundPhoto: UIImage?

import UIKit

class DetailTweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var userPhotoButton: UIButton!
   @IBOutlet weak var tweetTextLabel: UILabel!
   @IBOutlet weak var bannerImage: UIImageView!
   
   var networkController : NetworkController!
   var tweet: Tweet!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      println("got tweetid \(self.tweet.tweetID)")
      self.title = self.tweet.username
      self.tableView.dataSource = self
      self.tableView.delegate = self
      
      self.bannerImage.layer.masksToBounds = true
      networkController.fetchTweetDetail(self.tweet.tweetID, completionHandler: { (jsonDict, stringerror) -> () in
         // println(jsonDict!)
         if let screenName = jsonDict!["screen_name"] as? String {
            self.tweet.screenName = screenName
         }
         
         if let createdAt = jsonDict!["created_at"] as? String {
            self.tweet.createdAt = createdAt
         }
         
         if let favorites = jsonDict!["favorite_count"] as? Int {
            self.tweet.favorites = favorites
         }
         
         
         
         self.userPhotoButton.layer.cornerRadius = 35.0
         self.userPhotoButton.layer.masksToBounds = true
         self.userPhotoButton.layer.borderColor = UIColor.blackColor().CGColor
         self.userPhotoButton.layer.borderWidth = 5.0
         self.userPhotoButton.setBackgroundImage(self.tweet.userPhotoId!, forState: UIControlState.Normal)
         
         
         
         //            self.userNameLabel.text = self.tweet.username
         //            self.screenNameLabel.text = self.tweet.screenName
         //            self.tweetTextView.text = self.tweet.text
         //
         
         
      }) // end network.fetchTweetDatail
      
      
      
   } // end view  did load
   
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
   }
   
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("DETAIL_TWEET") as DetailTableViewCell
      cell.tweetText.text = self.tweet.text
      cell.tweetText.layer.cornerRadius = 5.0
      cell.tweetText.layer.masksToBounds = true
      return cell
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   @IBAction func userPhotoButton(sender: AnyObject) {
      let userTimelineVC = self.storyboard?.instantiateViewControllerWithIdentifier("USER_TIMELINE") as UserTimelineViewController
      //      userTimelineVC.networkController = self.networkController
      self.navigationController?.pushViewController(userTimelineVC, animated: true)
   }
   
   /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
   
}
