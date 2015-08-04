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
               profileImageURL = userInfo["profile_image_url"] as? String
              {
          let tweet = Tweet(text: text, username: username, userID: id, profileImageURL: profileImageURL)
          tweets.append(tweet)
        }
      }
      return tweets
    }
    return nil
  }
}
