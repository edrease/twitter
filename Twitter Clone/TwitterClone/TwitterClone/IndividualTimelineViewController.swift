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
  var userTweets = [Tweet]()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var headerView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    TwitterService.getTweetsFromUserTimeline(screenName, completionHandler: { (errorDescription, tweets) -> (Void) in
      if let tweets = tweets {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.userTweets = tweets
          self.tableView.reloadData()
        })
      }
    })
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
