//
//  AddEditCategoryVC.swift
//  ArtableAdmin
//
//  Created by Abdullah Gebreil on 1/16/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class AddEditCategoryVC: UIViewController {

    
    //Outlets
    
    @IBOutlet weak var nametxt: UITextField!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    @IBOutlet weak var addBtn: UIButton!
    
    
    //Varaible
    var categoryToEditing: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgtaped))
        tap.numberOfTapsRequired = 1
        categoryImage.addGestureRecognizer(tap)
        
        
        if let category = categoryToEditing {
        
            // category will be edit
            
            nametxt.text = category.name
            addBtn.setTitle("Sving Changes", for: .normal)
            
            let url = URL(string:category.imageurl)
            categoryImage.contentMode = .scaleAspectFill
            categoryImage.kf.setImage(with: url)
            
            
        }
       
        
    }
    
    @objc func imgtaped(_ tap : UITapGestureRecognizer) {
        
        luanchpicker()
    }
    

    @IBAction func addCaegoryClicked(_ sender: Any) {
        activityindicator.startAnimating()
        uploadImages()
    }
    
    
    func uploadImages() {
        
        guard let image = categoryImage.image , let name = nametxt.text , !name .isEmpty else {
            simpleAlartforSomeError(title: "Error", message: "must add name and category image")
            return
        }
        
        //turn image into data
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {return}
        
        //creat a storage image refernce
        let imageRef = Storage.storage().reference().child("/CategoryImages/ \(name).jpg")
        
        
        // set metaData
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        //upload Data
        
        
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error  = error {
                debugPrint(error)
                self.simpleAlartforSomeError(title: "Error", message: "cann't upload data")
                self.activityindicator.stopAnimating()
                return
            }
            // retrieve Dwomload url
            imageRef.downloadURL(completion: { (url, error) in
                if let error  = error {
                    debugPrint(error)
                    self.simpleAlartforSomeError(title: "Error", message: "cann't upload data")
                    self.activityindicator.stopAnimating()
                    return
                }
                guard let url = url else {return}
                
                self.AddDocument(url: url.absoluteString)
            })
            
            
        }
        
        
    }
    
    func AddDocument(url: String) {
        
        let docRef: DocumentReference!
        var category  = Category(name: nametxt.text!, id: "", imageurl: url, isActve: true, timestamp: Timestamp())
     
        if let categorytoedit = categoryToEditing {
            docRef = Firestore.firestore().collection("Categories").document(categorytoedit.id)
                category.id = categorytoedit.id
            
            
        }else {
            docRef = Firestore.firestore().collection("Categories").document()
            category.id = docRef.documentID
        }
        
        
       let data = category.convertModelToDictionary(category: category)
        
        
         docRef.setData(data, merge: true) { (error) in
            
            if let error  = error {
                debugPrint(error)
                self.simpleAlartforSomeError(title: "Error", message: "cann't upload data")
                self.activityindicator.stopAnimating()
                return
            }
           self.navigationController?.popViewController(animated: true)
        }
        
        
        
        
    }

}

extension AddEditCategoryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func luanchpicker() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage  else {return}
        categoryImage.contentMode = .scaleAspectFill
        categoryImage.image = image
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
