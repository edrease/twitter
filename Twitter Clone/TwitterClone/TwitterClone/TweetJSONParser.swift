//
//  TweetJSONParser.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/3/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import Foundation

class TweetJSONParser {
  
  class func tweetsFromJSONData(jsonData: NSData) -> [Tweet]? {
    
    var error: NSError?
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String : AnyObject]] {
      
      var tweets = [Tweet]()
      
      for object in rootObject {
        if let text = object["text"] as? String,
               id = object["id_str"] as? String,
               userInfo = object["user"] as? [String: AnyObject],
               username = userInfo["name"] as? String,
               profileImageURL = userInfo["profile_image_url"] as? String,
               screenName = userInfo["screen_name"] as? String {
               
                var tweet = Tweet(text: text, username: username, userID: id, profileImageURL: profileImageURL, wasRetweeted: false, isQuote: false,originalAuthor: nil, retweetText: nil, screenName: screenName, profileImage: nil)
      
               if let retweet = object["retweeted_status"] as? [String: AnyObject] {
                  
                  if let userInfo = retweet["user"] as? [String: AnyObject], text = retweet["text"] as? String {
                  
                  if let username = userInfo["name"] as? String,
                  profileImageURL = userInfo["profile_image_url"] as? String,
                  id = userInfo["id_str"] as? String {
                  
                    tweet.retweetText = text
                    tweet.originalAuthor = username
                    tweet.userID = id
                    tweet.profileImageURL = profileImageURL
                    tweet.wasRetweeted = true
                  }
                 }
                } else if let isQuote = object["quoted_status"] as? [String: AnyObject] {
                if let userInfo = isQuote["user"] as? [String: AnyObject], text = isQuote["text"] as? String {
                  
                  if let username = userInfo["name"] as? String,
                    profileImageURL = userInfo["profile_image_url"] as? String,
                    id = userInfo["id_str"] as? String {
                      
                      tweet.retweetText = text
                      tweet.originalAuthor = username
                      tweet.userID = id
                      tweet.profileImageURL = profileImageURL
                      tweet.isQuote = true
                      
                  }
                }
	               }
                
              tweets.append(tweet)
            
            }
      }
      return tweets
    }
    return nil
  }
}
