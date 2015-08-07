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
      tableView.estimatedRowHeight = 150
      tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension TweetDetailViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TweetDetailCell
    let tweet = selectedTweet
    if tweet.wasRetweeted == true || tweet.isQuote == true {
      cell.username.text = tweet.originalAuthor
      cell.detailedTweetText.text = tweet.retweetText
    } else {
      cell.username.text = tweet.username
      cell.detailedTweetText.text = tweet.text
    }
    
    cell.username.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)

    return cell
    
  }
  
}
