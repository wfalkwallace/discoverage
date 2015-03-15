//
//  DiscoverageClient.swift
//  discoverage
//
//  Created by William Falk-Wallace on 3/15/15.
//  Copyright (c) 2015 Discoverage. All rights reserved.
//

import UIKit

let baseURL = NSURL(string: "https://discoverage.herokuapp.com")

class DiscoverageClient: NSObject {
   
}


//
//  TwitterClient.swift
//  twitter
//
//  Created by William Falk-Wallace on 2/19/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

let twitterConsumerKey = NSBundle.mainBundle().objectForInfoDictionaryKey("CONSUMER_KEY") as String
let twitterConsumerSecret = NSBundle.mainBundle().objectForInfoDictionaryKey("CONSUMER_SECRET") as String

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginBlock: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func userTimelineWithParams(params: NSDictionary?, block: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/user_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            block(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                block(tweets: nil, error: error)
        })
    }
    
    func mentionsTimelineWithParams(params: NSDictionary?, block: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/mentions_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            block(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                block(tweets: nil, error: error)
        })
    }
    
    func homeTimelineWithParams(params: NSDictionary?, block: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            block(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                block(tweets: nil, error: error)
        })
    }
    
    func loginWithBlock(block: (user: User?, error: NSError?) -> ()) {
        loginBlock = block
        
        // fetch request token and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "wfwtwitterapp://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            //println("got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                println("failed to get the request token")
                self.loginBlock?(user: nil, error: error)
        }
    }
    
    func statusUpdateWithBlock(tweet: Tweet, block: (tweet: Tweet?, error: NSError?) -> ()) {
        var params = ["status": tweet.text!] as NSDictionary
        // TODO also use reply_to_status_id param
        POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweet = Tweet(dictionary: response as NSDictionary)
            block(tweet: tweet, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                block(tweet: nil, error: error)
        })
    }
    
    func retweetWithBlock(tweet: Tweet, block: (tweet: Tweet?, error: NSError?) -> ()) {
        // TODO add unretweet
        POST("1.1/statuses/retweet/\(tweet.id!).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweet = Tweet(dictionary: response as NSDictionary)
            block(tweet: tweet, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                block(tweet: nil, error: error)
        })
    }
    
    func favoriteWithBlock(tweet: Tweet, block: (tweet: Tweet?, error: NSError?) -> ()) {
        var params = ["id": tweet.id!] as NSDictionary
        POST("1.1/favorites/create.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweet = Tweet(dictionary: response as NSDictionary)
            block(tweet: tweet, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                block(tweet: nil, error: error)
        })
    }
    
    func unFavoriteWithBlock(tweet: Tweet, block: (tweet: Tweet?, error: NSError?) -> ()) {
        var params = ["id": tweet.id!] as NSDictionary
        POST("1.1/favorites/destroy.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweet = Tweet(dictionary: response as NSDictionary)
            block(tweet: tweet, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                block(tweet: nil, error: error)
        })
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            //println("got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println("user: \(response)")
                var user = User(dictionary: response as NSDictionary)
                User.currentUser = user
                //println("user: \(user.name)")
                self.loginBlock?(user: user, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error in getting current user")
                    self.loginBlock?(user: nil, error: error)
            })
            }) { (error: NSError!) -> Void in
                println("failed to receive access token")
                self.loginBlock?(user: nil, error: error)
        }
        
    }
    
}