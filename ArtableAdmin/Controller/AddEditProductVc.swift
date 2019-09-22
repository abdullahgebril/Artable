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
    var name: String = ""
    var price: Double = 0.0
    var prodescription: String = ""
    
    
    
    //Outlets
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var ProductDescription: UITextView!
    @IBOutlet weak var activityindictor: UIActivityIndicatorView!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var addproductBtn : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let product = producttoEditing {
            
            productName.text = product.name
            productPrice.text = String(product.price)
            ProductDescription.text = product.description
            addproductBtn.setTitle("Saving changes", for: .normal)
            let url  = URL(string: product.imageurl)
            productimage.contentMode = .scaleAspectFill
            productimage.kf.setImage(with: url)
        }

    
        let tap = UITapGestureRecognizer(target: self, action: #selector(launchImagePicker))
      tap.numberOfTapsRequired = 1
        productimage.addGestureRecognizer(tap)
    }
 
        @objc func launchImagePicker() {
        launchPickerImage()
    }

    @IBAction func addProduct(_ sender: Any) {
        
     
        
        uplaodImages()
     
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HandelTableViewData"), object: self)
        
   
    }
    
    
    
    func uplaodImages() {
        guard let name = productName.text , !name.isEmpty ,
            let image = productimage.image ,
            let description = ProductDescription.text , !description.isEmpty ,
        let pricestring = productPrice.text ,
            let price = Double(pricestring) else {
                simpleAlartforSomeError(title: "Error", message: "Please fill out all feilds")
                return}
        self.name = name
        self.price = price
        self.prodescription = description
        activityindictor.startAnimating()
        
        guard let imageData = image.jpegData(compressionQuality: 0.2)  else {return}
        
        let imagaRef = Storage.storage().reference().child("/ProductImages/\(name).jpg")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imagaRef.putData(imageData, metadata: metaData) { (mateData, error) in
            if let error = error {
               self.simpleAlartforSomeError(title: "Error", message: "error in upload data")
                self.activityindictor.stopAnimating()
                return
            }
            imagaRef.downloadURL(completion: { (url, error) in
                if let error = error {
                 self.simpleAlartforSomeError(title: "Error", message: "error in upload data")
                    self.activityindictor.stopAnimating()
                    return
                }
                guard let url = url else {return}
            self.uplaodDocument(url: url.absoluteString)
            })
        }
    }
    func uplaodDocument(url: String) {
        
        
        let docmentRef: DocumentReference!
        var product = Product(name: name, id: "", imageurl: url, category: category.id, price: price, stock: 0.0, description: prodescription, timeStamp: Timestamp())
        if let producttoEdit = producttoEditing {
           docmentRef = Firestore.firestore().collection("Product").document(producttoEdit.id)
            product.id = producttoEdit.id
            
        }else {
              docmentRef = Firestore.firestore().collection("Product").document()
            product.id  = docmentRef.documentID
        }
    let data = product.convertModelToDictionary(product: product)
        docmentRef.setData(data, merge: true) { (error) in
            if let error = error {
                self.simpleAlartforSomeError(title: "Error", message: "error in upload data")
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

        guard let image = info[.originalImage] as? UIImage else{return }
        productimage.contentMode = .scaleAspectFill
        productimage.image = image
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}




