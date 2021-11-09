//
//  SettingsVC.swift
//  InstaCloneFirebase
//
//  Created by Murat on 9.11.2021.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
   
    
    @IBAction func button(_ sender: Any) {
        
        do {
          try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }
        catch{
            print("error")
        }
       
    }
    
}
