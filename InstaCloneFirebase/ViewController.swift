//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Murat on 9.11.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passworTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signButtonClicked(_ sender: Any) {
        if emailTextField.text != "" && passworTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passworTextField.text!) { authdata, error in
                if error != nil {makeAlert(title: "Error", message: error!.localizedDescription ,self: self)}
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
                
            }
          
            
        }
        
        else {
            makeAlert(title: "Error", message: "Username/Password?",self: self )
           
        }
        
    }
    
    @IBAction func singUpClicked(_ sender: Any) {
        singUpOparations()
    }
        
    
    
 //   func makeAlert(title:String,message:String){
 //       let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
 //       let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
 //       alert.addAction(okButton)
 //       self.present(alert, animated: true, completion: nil)
 //
 //
 //   }
        
        
    func singUpOparations(){
        
        if emailTextField.text != "" && passworTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passworTextField.text!) { authdata, error in
                
                if error != nil {
                    
                   makeAlert(title: "Error", message: error!.localizedDescription,self: self )
                }
                else {
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender:   nil)
                }
                
            }
            
        }
        else {
            makeAlert(title: "Error", message: "Username/Password?",self: self)
            
        }
        
    }
    
    
}

