//
//  Tweet.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/3/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

struct Tweet {
  
  var text: String
  var username: String
  var userID: String
  var profileImageURL: String
  var wasRetweeted: Bool
  var isQuote: Bool
  var originalAuthor: String?
  var retweetText: String?
  var screenName: String
  var profileImage: UIImage?
  var originalAuthorScreenName: String?
  
}

