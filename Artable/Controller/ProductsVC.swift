//
//  ProductsVC.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/10/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ProductsVC: UIViewController {

    //Outlets
    @IBOutlet weak var tableview: UITableView!
    
    
    
    //Varaibles
    var category: Category!
    var products = [Product]()
 var  listener: ListenerRegistration!
    var db:Firestore!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
       
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName:"ProductCell" , bundle: nil), forCellReuseIdentifier: "ProductCell")
        tableview.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
         setDocuments()
    }
//    override func viewWillDisappear(_ animated: Bool) {
//    
//        listener.remove()
//        products.removeAll()
//        tableview.reloadData()
//        
//    }
    
    func setDocuments() {
        
        listener = db.collection("Product").whereField("category", isEqualTo: category.id).order(by: "timestamp", descending: true).addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            snap?.documentChanges.forEach({ (change) in
                
                let data = change.document.data()
                let product = Product(data: data)
                
                switch change.type{
                case .added:
                    self.onDocumentAdd(chnage: change, product: product)
                case .modified:
                    self.onDocumentModified(change: change, product: product)
                case .removed:
                    self.onDocumentRemove(chnage: change)
                }
            })
        })
    }
}


extension ProductsVC: UITableViewDelegate,UITableViewDataSource {
    
    

    
    func onDocumentAdd(chnage: DocumentChange , product: Product) {
        let newIndex = Int(chnage.newIndex)
        products.insert(product, at: newIndex)
        tableview.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .fade)
    }

    
    
    
    func onDocumentRemove(chnage: DocumentChange ) {
        let oldIndex = Int(chnage.oldIndex)
        products.remove(at: oldIndex)
        tableview.deleteRows(at: [IndexPath(row: oldIndex, section: 0)], with: .fade)
    }
    
    func onDocumentModified(change: DocumentChange , product: Product) {
        if change.oldIndex == change.newIndex {
            //Item is change but remainded in samepostion
            let index = Int(change.newIndex)
            products[index] = product
            tableview.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
        else {
            
            // Item changed and change postion
            
            let oldIndex = Int(change.oldIndex)
            let newindex = Int(change.newIndex)
            products.remove(at: oldIndex)
            products.insert(product, at: newindex)
            tableview.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newindex, section: 0))
            
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.row])
            return cell
        }
        return ProductCell()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ProductDetails()
       vc.product = products[indexPath.row]
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
