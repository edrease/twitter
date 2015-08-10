//
//  TweetDetailViewController.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/5/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
  
  var selectedTweet: Tweet!

  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
      super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self 
      tableView.estimatedRowHeight = 150
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.registerNib(UINib(nibName: "TweetCellNib", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ToUserTweetTimeline" {
      if let individualTimelineViewController = segue.destinationViewController as? IndividualTimelineViewController {
          let userScreenName = selectedTweet.screenName
          individualTimelineViewController.screenName = userScreenName
          let profileImage = selectedTweet.profileImage
          individualTimelineViewController.userProfileImage = profileImage
          let userName = selectedTweet.username
          individualTimelineViewController.userName = userName 
      }
    }
  }
}

extension TweetDetailViewController: UITableViewDataSource {
  
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
    println(tweet.screenName)
    return cell
    
  }
}

extension TweetDetailViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ToUserTweetTimeline", sender: nil)
  }
}
