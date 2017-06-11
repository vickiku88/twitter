//
//  LoginViewController.swift
//  Twitter
//
//  Created by victoria_ku on 6/9/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


  @IBAction func onLoginButton(_ sender: Any) {
    let client = TwitterClient.sharedInstance
    client?.login(success: {
      //logged in now, so can segue to the next view controller
      print("I've logged in")
      self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }, failure: { (error:Error) in
      print(error.localizedDescription)
    })


  }




}
