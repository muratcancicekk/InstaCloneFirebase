//
//  FeedVC.swift
//  InstaCloneFirebase
//
//  Created by Murat on 9.11.2021.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var userEmailArray = [String]()
    var commetArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        getDataFromFirestore()
        
        // Do any additional setup after loading the view.
    }
    
    
    func getDataFromFirestore(){
        
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                
                
                if error != nil {
                    
                    makeAlert(title: "Error", message: error?.localizedDescription ?? "error", self: self)
                }
                else {
                    if snapshot?.isEmpty != true && snapshot != nil {
                        self.userImageArray.removeAll(keepingCapacity: false)
                        self.userEmailArray.removeAll(keepingCapacity: false)
                        self.commetArray.removeAll(keepingCapacity: false)
                        self.likeArray.removeAll(keepingCapacity: false)
                        self.documentIdArray.removeAll(keepingCapacity: false)
                        
                        
                        for document in snapshot!.documents {
                            let documentID = document.documentID
                            self.documentIdArray.append(documentID)
                            
                            
                            if let postedBy = document.get("postedBy") as? String {
                                self.userEmailArray.append(postedBy)
                                
                            }
                            if let postComment = document.get("postComment") as? String {
                                self.commetArray.append(postComment)
                            }
                            if let likes = document.get("likes") as? Int {
                                self.likeArray.append(likes)
                            }
                            if let imageURL = document.get("imageUrl") as? String {
                                self.userImageArray.append(imageURL)
                                
                                
                            }
                            
                        }
                        self.tableView.reloadData()
                        
                    }
                }
                
            }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.likeLabel.text=String(likeArray[indexPath.row])
        cell.userMailLabel.text=userEmailArray[indexPath.row]
        cell.commentLabel.text=commetArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string:self.userImageArray[indexPath.row]))
        cell.documentIdLabel.text=documentIdArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    
    
    
}
