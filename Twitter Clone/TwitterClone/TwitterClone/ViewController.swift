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
  lazy var imageQueue = NSOperationQueue()
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    title = "Shitter"
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.registerNib(UINib(nibName: "TweetCellNib", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
    
    LoginService.loginToTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        println("Shit")
      }
      
      if let account = account {
        TwitterService.sharedService.account = account
        TwitterService.getTweetsFromHomeTimeline({ (errorDescription, tweets) -> (Void) in
          
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
    if segue.identifier == "ToTweetDetailViewController" {
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
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
    cell.tag++
    let tag = cell.tag
    var tweet = tweets[indexPath.row]
    cell.userNameLabel.text = tweet.username
    cell.userNameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    cell.tweetBodyText.text = tweet.text
    
    if let profileImage = tweet.profileImage {
      cell.profileImage.image = profileImage
    } else {
      imageQueue.addOperationWithBlock({ () -> Void in
        
        if let image = DownloadImage.fetchImage(tweet.profileImageURL) {
         let size = ImageResizer.switchImageSize(image)
         let resizedImage = ImageResizer.resizeImage(image, size: size)
        
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            tweet.profileImage = resizedImage
            self.tweets[indexPath.row] = tweet
            if cell.tag == tag {
              cell.profileImage.image = resizedImage
          
            }
          })
        }
      })
    }
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ToTweetDetailViewController", sender: nil)
    
  }
}

