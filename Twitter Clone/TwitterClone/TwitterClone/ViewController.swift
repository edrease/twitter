//
//  ViewController.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/3/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var tweets = [Tweet]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    self.title = "Shitter"
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
    
    LoginService.loginToTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        println("Shit")
      }
      
      if let account = account {
        TwitterService.getTweetsFromHomeTimeline(account, completionHandler: { (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.tweets = tweets
              self.tableView.reloadData()
            })
          }
        })
      }
    }
    tableView.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "toTweetDetailViewController" {
      if let tweetDetailViewController = segue.destinationViewController as? TweetDetailViewController {
        if let indexPath = tableView.indexPathForSelectedRow() {
          let selectedRow = indexPath.row
          let selectedTweet = tweets[selectedRow]
          tweetDetailViewController.selectedTweet = selectedTweet
        }
      }
    }
  }

}

extension ViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TweetCell
    let tweet = tweets[indexPath.row]
    cell.userNameLabel.text = tweet.username
    cell.userNameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    cell.tweetBodyText.text = tweet.text
    return cell
  }
}

