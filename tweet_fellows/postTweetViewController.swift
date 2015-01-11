//
//  postTweetViewController.swift
//  tweet_fellows
//
//  Created by nacnud on 1/10/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

import UIKit

class postTweetViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    var networkController:NetworkController?
    var userTweet:Tweet?
    var timeLine:[Tweet] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let tweetBubbleImage = UIImage(named: "tweet_bubble")
        let tweetBubbleItem = UIBarButtonItem(image: tweetBubbleImage, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("postTweet:"))
        navigationItem.rightBarButtonItem = tweetBubbleItem


        

        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func postTweet(UIBarButtonItem){
        println("time to post my tweet:)")
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
