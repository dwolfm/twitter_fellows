//
//  NetworkController.swift
//  tweet_fellows
//
//  Created by nacnud on 1/7/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

import Foundation
import Accounts
import Social


class NetworkController {
   var twitterAccount: ACAccount?
   
   // class with optional properties require init to be implemented
   init(){
      
   }
   
   func requestAccount(){
      let accountStore = ACAccountStore()
      let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
      accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
         if granted {
            let accounts = accountStore.accountsWithAccountType(accountType)
            if !accounts.isEmpty {
               self.twitterAccount = accounts.first as? ACAccount
            } else {
               // aint a twitter account
               NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  let alert = UIAlertView()
                  alert.title = "Dummy"
                  alert.message = "You Dont Have A Twitter Accout Registered to this device"
                  alert.addButtonWithTitle("Understod")
                  alert.show()
               })// end NSOPERATION MAINQUE FOR ALERT
               
            }
         } else {
            // access not granted
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
               let alert = UIAlertView()
               alert.title = "Dummy"
               alert.message = "Now you needa allow access to titter in the Settings App"
               alert.addButtonWithTitle("Understod")
               alert.show()
            })// end NSOPERATION MAINQUE FOR ALERT
            
         }
      }
   } // end func request account
   
   
   func fetchHomeTimeLine( completionHandler: ([Tweet]?, String?) -> ()){
      let accountStore = ACAccountStore()
      let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
      accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
         if granted {
            let accounts = accountStore.accountsWithAccountType(accountType)
            if !accounts.isEmpty {
               self.twitterAccount = accounts.first as? ACAccount
               let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
               let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
               twitterRequest.account = self.twitterAccount
               twitterRequest.performRequestWithHandler { (data, response, error) -> Void in
                  if error == nil {
                     switch response.statusCode {
                     case 200...299:
                        if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] {
                           var tweets: [Tweet] = []
                           for object in jsonArray {
                              if let jsonDictionary = object as? [String: AnyObject] {
                                 let tweet = Tweet(jsonDictionary)
                                 tweets.append(tweet)
                              }
                           }// end for
                           NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                              completionHandler(tweets, nil)
                           })
                        }
                        
                     case 300...599:
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                           completionHandler(nil, "Error of type \(error)")
                        })
                        
                     default:
                        println("unexpected error")
                     }// switch
                     
                  } // error
                  
                  
               }
            } else {
               // aint a twitter account
               NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  let alert = UIAlertView()
                  alert.title = "Dummy"
                  alert.message = "You Dont Have A Twitter Accout Registered to this device"
                  alert.addButtonWithTitle("Understod")
                  alert.show()
               })// end NSOPERATION MAINQUE FOR ALERT
               
            }
         } else {
            // access not granted
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
               let alert = UIAlertView()
               alert.title = "Dummy"
               alert.message = "Now you needa allow access to titter in the Settings App"
               alert.addButtonWithTitle("Understod")
               alert.show()
            })// end NSOPERATION MAINQUE FOR ALERT
            
         }
         
      }
      
   }
   
   func fetchTweetDetail(tweetId: String ,completionHandler: ([String:AnyObject]?, String?) -> () ){
      let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/show.json?id=\(tweetId)")
      let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
      twitterRequest.account = self.twitterAccount
      twitterRequest.performRequestWithHandler { (data, response, error) -> Void in
         if error == nil {
            switch response.statusCode {
            case 200...299:
               if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String: AnyObject] {
                     NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completionHandler(jsonDictionary, String(response.statusCode))
                     })
                  }

            case 300...599:
               NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(nil, "Error of type \(response.statusCode )")
               })
               
            default:
               println("unexpected error")
               completionHandler(nil, "Error of type \(response.statusCode )")
            } // switch
         } // error
      }
   }
   
   func fetchUserTimeline(username: String, completionHandler: ([AnyObject]?, String?) -> () ){
      let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?username=\(username)")
      let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
      twitterRequest.account = self.twitterAccount
      twitterRequest.performRequestWithHandler { (data, response, error) -> Void in
         if error == nil {
            switch response.statusCode {
            case 200...299:
               if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] {
                  var tweets: [Tweet] = []
                  for object in jsonArray {
                     if let jsonDictionary = object as? [String: AnyObject] {
                        let tweet = Tweet(jsonDictionary)
                        tweets.append(tweet)
                     }
                  }// end for
                  NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                     completionHandler(tweets, nil)
                  })
               }
               
            case 300...599:
               NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(nil, "Error of type \(error)")
               })
               
            default:
               println("unexpected error")
            }// switch
            
         } // error
      }
   }
   
   
   
   func fetchImageFromURL(inout image: UIImage?, photoURL: NSURL){
      if let photoData = NSData(contentsOfURL: photoURL) {
         image = UIImage(data: photoData)
      }
   }

}
