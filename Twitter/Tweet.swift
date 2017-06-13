//
//  Tweet.swift
//  Twitter
//
//  Created by victoria_ku on 6/10/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  var text: String?
  var timestamp: Date?
  var retweetCount: Int = 0
  var favCount: Int = 0
  var screenname: String?
  var name: String?
  var profileImg: URL?

  init(dictionary:NSDictionary) {
    text = dictionary["text"] as? String
    retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
    favCount = (dictionary["favourites_count"] as? Int) ?? 0

    let timestampString = dictionary["created_at"] as? String

    if let timestampString = timestampString {
      let formatter = DateFormatter()
      formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      timestamp = formatter.date(from: timestampString)
    }
     screenname = dictionary.value(forKeyPath: "user.screen_name") as? String
     name = dictionary.value(forKeyPath: "user.name") as? String
    let profileImgString = dictionary.value(forKeyPath: "user.profile_image_url_https") as? String
    if profileImgString != nil {
      profileImg = URL(string: profileImgString!)
    } else {
      profileImg = nil
    }


    }


  class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()

    for dictionary in dictionaries{
      let tweet = Tweet(dictionary: dictionary)
      tweets.append(tweet)
    }

    return tweets
  }



}
