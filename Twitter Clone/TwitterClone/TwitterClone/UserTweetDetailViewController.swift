//
//  UserTweetDetailViewController.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/9/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class UserTweetDetailViewController: UIViewController {
  
  var selectedTweet: Tweet!
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.estimatedRowHeight = 150
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.registerNib(UINib(nibName: "TweetCellNib", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }

}

extension UserTweetDetailViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
    var tweet = selectedTweet
    if tweet.wasRetweeted == true || tweet.isQuote == true {
      cell.userNameLabel.text = tweet.originalAuthor
      cell.tweetBodyText.text = tweet.retweetText
    } else {
      cell.userNameLabel.text = tweet.username
      cell.tweetBodyText.text = tweet.text
    }
    cell.userNameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    cell.userNameLabel.font.fontWithSize(100)
    cell.profileImage.image = selectedTweet.profileImage

    return cell
  }
  
}
