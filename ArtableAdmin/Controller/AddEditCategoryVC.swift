//
//  AddEditCategoryVC.swift
//  ArtableAdmin
//
//  Created by Abdullah Gebreil on 1/16/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit

class AddEditCategoryVC: UIViewController {

    
    //Outlets
    
    @IBOutlet weak var nametxt: UITextField!
    @IBOutlet weak var categoryImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgtaped))
        tap.numberOfTapsRequired = 1
        categoryImage.addGestureRecognizer(tap)
       
        
    }
    
    @objc func imgtaped(_ tap : UITapGestureRecognizer) {
        
        luanchpicker()
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
