//
//  ReplyCell.swift
//  Twitter
//
//  Created by victoria_ku on 6/11/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit

class ReplyCell: UITableViewCell {
  var user: User?

  

  @IBOutlet weak var profileImg: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var handleLabel: UILabel!

  var tweet: Tweet?{
    didSet {
      if let tweet = tweet{
        print("tweet:",tweet)
        if let name = tweet.name {
          nameLabel.text = name
        }
        if let screenname = tweet.screenname{
          handleLabel.text = "@" + screenname
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
