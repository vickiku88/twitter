//
//  TweetViewController.swift
//  Twitter
//
//  Created by victoria_ku on 6/10/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource {
  var tweets:[Tweet]!

  @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.

        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
          self.tweets = tweets
          self.tableView.reloadData()

        }, failure: { (error:Error) in
          print("error")
        })
        

    }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let tweets = tweets {
      return tweets.count
    }else{
    return 0
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  @IBAction func onLogoutButton(_ sender: Any) {
    TwitterClient.sharedInstance?.logout()
  }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
