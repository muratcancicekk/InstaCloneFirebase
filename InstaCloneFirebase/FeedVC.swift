//
//  FeedVC.swift
//  InstaCloneFirebase
//
//  Created by Murat on 9.11.2021.
//

import UIKit

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
   
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.likeLabel.text="10"
        cell.userMailLabel.text="muratcancicekk"
        cell.commentLabel.text="süper"
        cell.userImageView.image=UIImage(named: "select.png")
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    

 

}
