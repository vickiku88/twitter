//
//  ReplyViewController.swift
//  Twitter
//
//  Created by victoria_ku on 6/11/17.
//  Copyright © 2017 victoria_ku. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tweet: Tweet?

  @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath) as! ReplyCell
    cell.tweet = self.tweet
    cell.accessoryType = UITableViewCellAccessoryType.none

    return cell
  }


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
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
