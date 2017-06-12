//
//  DetailViewController.swift
//  Twitter
//
//  Created by victoria_ku on 6/11/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


  @IBOutlet weak var tableView: UITableView!
  var tweet: Tweet?


    override func viewDidLoad() {
      super.viewDidLoad()
      tableView.delegate = self
      tableView.dataSource = self
      //tableView.register("ReplyCell", forCellReuseIdentifier: "ReplyCell")


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
    cell.tweet = self.tweet
    cell.accessoryType = UITableViewCellAccessoryType.none


    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

  }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //currently learning how to segue from a button. the following isn't complete
      let cell = sender as! UITableViewCell
      let indexPath = tableView.indexPath(for: cell)
      let tweet = self.tweet
      print(tweet)

      let replyViewController = segue.destination as! ReplyViewController
      replyViewController.tweet = tweet
      print("prepare for next, Reply")


        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
