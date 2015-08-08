//
//  TwitterService.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/5/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
  
  static let sharedService = TwitterService()
  private init() {}
  
  class func getTweetsFromHomeTimeline (twitterAccount: ACAccount?, completionHandler: (String?, [Tweet]?) -> (Void)) {
    
    let requestForTweets = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")!, parameters: nil)
    
    requestForTweets.account = twitterAccount
    
    requestForTweets.performRequestWithHandler { (data, httpResponse, error) -> Void in
      if let error = error {
        completionHandler("Sorry, there was an error!", nil)
        return
      } else {
        println(httpResponse.statusCode)
        switch httpResponse.statusCode {
        case 200...299:
          let tweets = TweetJSONParser.tweetsFromJSONData(data)
          completionHandler(nil, tweets)
        case 300...399:
          completionHandler("Hey I don't know", nil)
        case 400...499:
          completionHandler("I'm dumb! Sorry!", nil)
        case 500...599:
          completionHandler("Twitter sucks, not me", nil)
        default:
          completionHandler("Something terrible has happened(error)", nil)
        }
      }
    }
  }
  
  class func getTweetsFromUserTimeline (screenName: String, completionHandler: (String?, [Tweet]?) -> (Void)) {
    
    let requestForTweets = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(screenName)")!, parameters: nil)
    
    println(requestForTweets.preparedURLRequest())
    requestForTweets.performRequestWithHandler { (data, httpResponse, error) -> Void in
      if let error = error {
        completionHandler("Sorry, there was an error!", nil)
        return
      } else {
        println(httpResponse.statusCode)
        switch httpResponse.statusCode {
        case 200...299:
          let tweets = TweetJSONParser.tweetsFromJSONData(data)
          completionHandler(nil, tweets)
        case 300...399:
          completionHandler("Hey I don't know", nil)
        case 400...499:
          completionHandler("I'm dumb! Sorry!", nil)
        case 500...599:
          completionHandler("Twitter sucks, not me", nil)
        default:
          completionHandler("Something terrible has happened(error)", nil)
        }
      }
    }
  }
}