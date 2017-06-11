//
//  TwitterClient.swift
//  Twitter
//
//  Created by victoria_ku on 6/10/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

  static let userDidLogoutNotification = "UserDidLogout"
  static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL, consumerKey: "WvnXSkai0wQPAJcAI9DsW9mMF", consumerSecret: "2d21wci9pC5szzeYfQyJ31gcUm757KTtQ6ISX28qfZWlJIG6JK")

  var loginSuccess: (() -> ())?
  var loginFailure: ((Error) -> ())?

  func logout() {
    User.currentUser = nil
    deauthorize()

    NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
  }

  func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
    loginSuccess = success
    loginFailure = failure

    deauthorize()
    fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth")! as URL, scope: nil, success: { (requestToken: BDBOAuth1Credential!) in
      let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token!)")
      print("got a token")
      if let url = url {
        UIApplication.shared.open(url as! URL, completionHandler: { (Bool) in
          print("url")
        })
      }
    }, failure: { (error: Error?) in
      self.loginFailure!(error!)
    })
  }

  func handleOpenURL(url: URL){
    let requestToken = BDBOAuth1Credential(queryString: url.query)
    fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken!, success: { (accessToken: BDBOAuth1Credential?) -> Void in

      self.currentAccount(success: { (user:User) in
        User.currentUser = user 
        self.loginSuccess!()

      }, failure: { (error: Error) in
        self.loginFailure!(error)
      })
      print("I have a token")

      self.loginSuccess!()
      }, failure: { (error: Error?) -> Void in
        self.loginFailure!((error)!)
      })

  }

  func currentAccount(success: @escaping (User)->(), failure: @escaping (Error) -> ()){
    get("1.1/account/verify_credentials.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
      print(response)
      let userDictionary = response as! NSDictionary
      let user = User(dictionary: userDictionary)
      success(user)
    }, failure: { (task: URLSessionDataTask?, error: Error) in
      failure(error)
    })
  }

  
  func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error)->()){
    get("1.1/statuses/home_timeline.json", parameters: nil, success: { (task:URLSessionDataTask, response: Any) -> Void in
      let dictionaries = response as! [NSDictionary]
      let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
      success(tweets)
    }, failure: { (task: URLSessionDataTask?, error: Error) in
      failure(error)
    })
  }

}
