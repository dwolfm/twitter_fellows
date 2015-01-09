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

class DetailTweetViewController: UIViewController {

   @IBOutlet weak var userPhoto: UIButton!

   var networkController : NetworkController!
   var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
         println("got tweetid \(self.tweet.tweetID)")
      
      
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
         
      }) // end network.fetchTweetDatail
      
    } // end view  did load

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   @IBAction func userPhotoButton(sender: AnyObject) {
    let userTimelineVC = self.storyboard?.instantiateViewControllerWithIdentifier("USER_TIMELINE") as UserTimelineViewController
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
