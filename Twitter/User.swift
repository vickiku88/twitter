//
//  User.swift
//  Twitter
//
//  Created by victoria_ku on 6/10/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit

class User: NSObject {
  var name: String?
  var screenname: String?
  var descript: String?
  var profileURL: URL?
  var dictionary: NSDictionary?

  init(dictionary: NSDictionary){
    self.dictionary = dictionary
    name = dictionary["name"] as? String
    screenname = dictionary["screenname"] as? String
    descript = dictionary["description"] as? String
    let profileURLString = dictionary["profile_image_url_https"] as? String
    if let profileURLString = profileURLString{
      profileURL = URL(string: profileURLString)
    }
  }
  static var _currentUser: User?
  static let userDidLogoutNotification = "UserDidLogout"

  class var currentUser: User? {
    get {
      if _currentUser == nil {
          let defaults = UserDefaults.standard
          let userdata = defaults.object(forKey: "currentUser")
        //print(userdata)
          if let userdata = userdata {
            let dictionary = try! JSONSerialization.jsonObject(with: userdata as! Data, options: [] ) as! NSDictionary
            _currentUser = User(dictionary: dictionary)

          }
      }
      return _currentUser
    }

    set(user){
      _currentUser = user
      let defaults = UserDefaults.standard
      if let user = user {
        let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
        defaults.set(data, forKey: "currentUser")
      } else {
        defaults.removeObject(forKey: "currentUser")
      }
      defaults.synchronize()

    }

  }

}
