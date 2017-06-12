//
//  TweetCell.swift
//  Twitter
//
//  Created by victoria_ku on 6/10/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  @IBOutlet weak var profileImg: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var screenLabel: UILabel!
  @IBOutlet weak var hoursPosted: UILabel!
  @IBOutlet weak var tweetText: UILabel!


  var tweet:Tweet?{
    didSet{
      if let tweet = tweet {
        if let text = tweet.text {
          tweetText.text = text
        }
        if let timestampString = tweet.timestamp{
          let formatter = DateFormatter()
          formatter.dateFormat = "MM/dd/yy"

          //hoursPosted.text = formatter.string(from: timestampString as Date)

          let elapsed = Int(Date().timeIntervalSince(timestampString))
          print(elapsed/60)
          hoursPosted.text = String(elapsed/60) + "m"
        }
        if let name = tweet.name{
          nameLabel.text = name
        }
        if let screenname = tweet.screenname{
          screenLabel.text = "@" + screenname
        }
        if let profileImgURL = tweet.profileImg{
          profileImg.setImageWith(profileImgURL)

        }


        


      }
    }
  }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      profileImg.layer.cornerRadius = 3
      profileImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
