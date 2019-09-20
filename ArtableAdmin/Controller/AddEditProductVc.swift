//
//  AddEditProductVc.swift
//  ArtableAdmin
//
//  Created by Abdullah Gebreil on 1/19/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class AddEditProductVc: UIViewController {

    // Varaible
    var producttoEditing : Product?
    var category: Category!
    var name:String = ""
    var price:Double = 0.0
    var descriptionproduct:String = ""
    
    //Outlets
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var ProductDescription: UITextView!
    @IBOutlet weak var activityindictor: UIActivityIndicatorView!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var addproductBtn : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(launch))
        tap.numberOfTapsRequired = 1
        
        productimage.addGestureRecognizer(tap)
        if let productedit = producttoEditing {
            
            // category will be edit
            
            productName.text = productedit.name
          productPrice.text = String (productedit.price)
            ProductDescription.text = productedit.description
            
            addproductBtn.setTitle("Saving Changes", for: .normal)
            let url = URL(string: productedit.imageurl)
            productimage.contentMode = .scaleAspectFill
            productimage.kf.setImage(with: url)
            
    }
    }
    
    
        @objc func launch() {
        launchPickerImage()
    }



    
    @IBAction func addProduct(_ sender: Any) {
        activityindictor.startAnimating()
        uploadImage()
    }
    func uploadImage() {
        guard let image = productimage.image , let name = productName.text , !name.isEmpty,let des = ProductDescription.text , !des.isEmpty  , let pricestring = productPrice.text ,
            let price  =  Double(pricestring) else {
            simpleAlartforSomeError(title: "Error", message: "must add name and price and select image")
            return
        }
        self.name = name
        self.price = price
        self.descriptionproduct = des
        
        //Turn image to Data
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {return }
        
        //Creat storge image refernce
        let imgRef = Storage.storage().reference().child("/Products Image/\(name).jpg")
        
        //metaData
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        //UploadData
        imgRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
               self.simpleAlartforSomeError(title: "Error", message: "Cann't upload Data")
                self.activityindictor.stopAnimating()
                return
            }
            imgRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    self.simpleAlartforSomeError(title: "Error", message: "Cann't upload Data")
                    self.activityindictor.stopAnimating()
                    return
                }
                
                guard let url = url  else{return}
                
               self.addDocument(url: url.absoluteString)
            })
         
        }
        
    }
    
    
    func addDocument(url: String) {
        
        
        let docRef : DocumentReference!
//
//        let formatter =  NumberFormatter()
//        formatter.numberStyle = .currency
//        if let price = formatter.string(from: product!.price as NSNumber)

  
        var product = Product(name: name , id: "", imageurl: url, category: category.id,price: price, stock: 0, description: descriptionproduct, timeStamp: Timestamp())
        
        
        if let productEdit = producttoEditing {
            docRef = Firestore.firestore().collection("Product").document(productEdit.id)
            product.id = productEdit.id
            
            
        }else {
            docRef = Firestore.firestore().collection("Product").document()
            product.id = docRef.documentID
        }
        
        
         let data = product.convertModelToDictionary(product: product)
        docRef.setData(data, merge: true) { (error) in
            
            if let error  = error {
                debugPrint(error)
                self.simpleAlartforSomeError(title: "Error", message: "cann't upload data")
                self.activityindictor.stopAnimating()
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
}

extension AddEditProductVc: UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    func launchPickerImage() {
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        present(imagepicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] else {return }
        productimage.contentMode = .scaleAspectFill
        productimage.image = image as! UIImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
