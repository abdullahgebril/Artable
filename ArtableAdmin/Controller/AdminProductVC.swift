//
//  AdminProductVC.swift
//  ArtableAdmin
//
//  Created by Abdullah Gebreil on 1/19/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit

class AdminProductVC: ProductsVC {

    //Varaibles
    var selectedProduct:Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let editCategorytBtn = UIBarButtonItem(title: "Edit Category", style: .plain, target: self, action: #selector(editCategory))
        
        
        let addProductBtn = UIBarButtonItem(title: "+ Product", style: .plain, target: self, action: #selector(addProduct))
        navigationItem.setRightBarButtonItems([editCategorytBtn,addProductBtn], animated: false)
    

    }
    override func viewWillDisappear(_ animated: Bool) {
        products.removeAll()
    }
    
   @objc func editCategory() {
    performSegue(withIdentifier: "ToEditCategory", sender: self)
        
    }
    @objc func addProduct() {
          performSegue(withIdentifier: "ToAddEditProduct", sender: self)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            selectedProduct = products[indexPath.row]
            performSegue(withIdentifier: "ToAddEditProduct", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToAddEditProduct" {
            if let destination = segue.destination as? AddEditProductVc {
                destination.producttoEditing = selectedProduct
                destination.category = category
            }
        } else if segue.identifier == "ToEditCategory" {
            if let destination = segue.destination as? AddEditCategoryVC {
               
                destination.categoryToEditing = category
            }
        }
    }
}
