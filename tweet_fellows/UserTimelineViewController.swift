//
//  UserTimelineViewController.swift
//  tweet_fellows
//
//  Created by nacnud on 1/9/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   // outlets
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var headerTest: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
   
   var networkController : NetworkController?
    var userTweet: Tweet?
    var tweets: [Tweet] = []
   
   

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TWEET_CELL")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.headerTest.text = "DSFL:JFD"
        
        if let screenName = userTweet?.screenName {
            println(screenName)
        }
        
        self.networkController?.fetchUserTimeline(self.userTweet!.screenName, completionHandler: { (tweets, errorString) -> () in
            if errorString == nil {
                self.tweets = tweets! as [Tweet]
                self.tableView.reloadData()
            } else {
                let alert = UIAlertView()
                alert.message = errorString!
                alert.show()
                
            }
            println(tweets)
        })
        
        if let backgroundURl = self.userTweet!.userBackgroundPhotoUrl{
            self.networkController!.fetchImageFromURL(&self.userTweet!.userBackgroundPhoto, photoURL: backgroundURl)
        }
        
        if let backgroundPhoto = self.userTweet!.userBackgroundPhoto {
            self.bannerImage.image = backgroundPhoto
        }

        self.bannerImage.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL") as TweetCell
        let tweet = tweets[indexPath.row]
        cell.usernameLabel.text = tweet.username
        cell.tweetTextLabel.text = tweet.text
        cell.tweetTextLabel.layer.cornerRadius = 5
        cell.tweetTextLabel.layer.masksToBounds = true
        
        self.networkController?.fetchImageFromURL(&tweet.userPhotoId, photoURL: tweet.userPhotoUrl!)

        cell.userPhotoId?.image = tweet.userPhotoId
        cell.userPhotoId?.layer.cornerRadius = 35.0
        cell.userPhotoId?.layer.masksToBounds = true
        cell.userPhotoId?.layer.borderColor = UIColor.blackColor().CGColor
        cell.userPhotoId?.layer.borderWidth = 4.0

        return cell
        
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
