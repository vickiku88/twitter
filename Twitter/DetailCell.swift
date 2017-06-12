//
//  DetailCell.swift
//  Twitter
//
//  Created by victoria_ku on 6/11/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit
import AFNetworking

class DetailCell: UITableViewCell {

  @IBOutlet weak var detProfURLView: UIImageView!
  @IBOutlet weak var detNameLabel: UILabel!
  @IBOutlet weak var detHandleLabel: UILabel!
  @IBOutlet weak var detNumFav: UILabel!
  @IBOutlet weak var detNumRetweet: UILabel!
  @IBOutlet weak var detTimeLabel: UILabel!
  @IBOutlet weak var detDateLabel: UILabel!
  @IBOutlet weak var detDesription: UILabel!

  var tweet: Tweet?{
    didSet{
      if let tweet = tweet{
        if let timestampString = tweet.timestamp{
          print(timestampString)
          let formatter = DateFormatter()
          formatter.dateFormat = "MM/dd/yy"
          detDateLabel.text = formatter.string(from: timestampString as Date)

          formatter.dateFormat = "H:mm a"
          detTimeLabel.text = formatter.string(from: timestampString as Date)

        }
        if let text = tweet.text {
          detDesription.text = text as String
          print(text)
        }
        if let name = tweet.name {
          detNameLabel.text = name
        }
        if let screenname = tweet.screenname{
          detHandleLabel.text = "@" + screenname
        }
        if let profileImgURL = tweet.profileImg{
          detProfURLView.setImageWith(profileImgURL)
        }
        detNumRetweet.text = String(tweet.retweetCount) + " retweets"
        detNumFav.text = String(tweet.favCount) + " favorites"

      }
    }
  }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      detProfURLView.layer.cornerRadius = 3
      detProfURLView.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
