//
//  TweetViewController.swift
//  Twitter
//
//  Created by victoria_ku on 6/10/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var tweets:[Tweet]!
  var user: User!

  @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

       // tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        // Do any additional setup after loading the view.
      let refreshControl = UIRefreshControl()
      refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
      tableView.insertSubview(refreshControl, at: 0)


        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
          self.tweets = tweets
          self.tableView.reloadData()

        }, failure: { (error:Error) in
          print("error")
        })
        

    }

  func refreshControlAction(_ refreshControl: UIRefreshControl) {
    TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
      self.tweets = tweets

      // Reload the tableView now that there is new data
      self.tableView.reloadData()

      // Tell the refreshControl to stop spinning
      refreshControl.endRefreshing()

    }, failure: { (error: Error) -> () in
      print(error.localizedDescription)
      // Reload the tableView now that there is new data
      self.tableView.reloadData()

      // Tell the refreshControl to stop spinning
      refreshControl.endRefreshing()
    })


  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
    cell.accessoryType = UITableViewCellAccessoryType.none
    cell.tweet = tweets[indexPath.row]
    cell.sizeToFit()
    cell.layoutIfNeeded()
    cell.setNeedsUpdateConstraints()
    cell.updateConstraintsIfNeeded()


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

 /* private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }*/

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
      override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets?[(indexPath?.row)!]

        let detailViewController = segue.destination as! DetailViewController
        detailViewController.tweet = tweet
        print("prepare")
    }


}
