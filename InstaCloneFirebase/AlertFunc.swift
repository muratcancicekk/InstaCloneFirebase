//
//  AlertFunc.swift
//  InstaCloneFirebase
//
//  Created by Murat on 9.11.2021.
//

import Foundation
import UIKit

func makeAlert(title:String,message:String,self:UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
    alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    
    
}
