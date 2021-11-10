//
//  UploadVC.swift
//  InstaCloneFirebase
//
//  Created by Murat on 9.11.2021.
//

import UIKit
import Firebase

class UploadVC: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commitTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
        
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
        
    }
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    

    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let stroge = Storage.storage()
        let strogeReference = stroge.reference()
        let mediaFolder = strogeReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    makeAlert(title: "Error", message: error?.localizedDescription ?? "error",self: self)
                }
                else{
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreRefenrence : DocumentReference?
                            let firestorePost = ["imageUrl" : imageUrl , "postedBy": Auth.auth().currentUser!.email,"postComment" : self.commitTextField.text!,"date":"date", "likes" : 0] as [String : Any]
                            firestoreRefenrence = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    makeAlert(title: "error", message: error?.localizedDescription ?? "error", self: self)
                                }
                            })
                            
                          
                        }
                    }
                }
            }
        }
    }
}
