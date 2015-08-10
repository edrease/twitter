//
//  IndividualTimelineViewController.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/7/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class IndividualTimelineViewController: UIViewController {
  
  var screenName: String!
  var userProfileImage: UIImage!
  var userName: String!
  var userTweets = [Tweet]()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var userHeadlineProfileImage: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var userScreenNameLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.registerNib(UINib(nibName: "TweetCellNib", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
        
    TwitterService.getTweetsFromUserTimeline(screenName, completionHandler: { (errorDescription, tweets) -> (Void) in
      if let tweets = tweets {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.userTweets = tweets
          self.tableView.reloadData()
        })
      }
    })
    self.userHeadlineProfileImage.image = userProfileImage
    self.userScreenNameLabel.text = "@\(screenName)"
    self.userNameLabel.text = userName
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ToUserTweetDetailController" {
      if let userTweetDetailViewController = segue.destinationViewController as? UserTweetDetailViewController {
        if let indexPath = tableView.indexPathForSelectedRow() {
          let selectedRow = indexPath.row
          let selectedTweet = userTweets[selectedRow]
          userTweetDetailViewController.selectedTweet = selectedTweet
        }
      }
    }
  }
}

extension IndividualTimelineViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userTweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
    let tweet = userTweets[indexPath.row]
    cell.userNameLabel.text = tweet.username
    cell.userNameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    cell.tweetBodyText.text = tweet.text
    return cell
  }
  
}

extension IndividualTimelineViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ToUserTweetDetailController", sender: nil) 
  }
}
