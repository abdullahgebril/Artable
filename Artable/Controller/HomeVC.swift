//
//  ViewController.swift
//  Artable
//
//  Created by Abdullah Gebreil on 1/3/1441 AH.
//  Copyright © 1441 AH Abdullah Gebreil. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

   
    //Outlets
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var loginOutBtn: UIBarButtonItem!
    
    //Varaibles
    var categories = [Category]()
    var selectedCaregory: Category!
    var db:Firestore!
    var listener:ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPCollectioView()
        db = Firestore.firestore()
        setUPIntialAnonymous()
      
        
    }
    
    func setUPCollectioView(){
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UINib.init(nibName: "CategoryCell" , bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
    }
    
    func setUPIntialAnonymous() {
        
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    Auth.auth().handleFireAuthError(error: error, vc: self)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
        categories.removeAll()
        collectionview.reloadData()
    }
    
    func setDocuments() {
        
        listener = db.collection("Categories").order(by: "timestamp", descending: true).addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            snap?.documentChanges.forEach({ (change) in
                
                let data = change.document.data()
                let category = Category(data: data)
                switch change.type{
                case .added:
                    self.onDocumentAdd(chnage: change, category: category)
                case .modified:
                    self.onDocumentModified(change: change, category: category)
                case .removed:
                    self.onDocumentRemove(change: change)
                    
                }
            })
        })
    }
    
    


    
    override func viewDidAppear(_ animated: Bool) {
        
        setDocuments()
        if let user = Auth.auth().currentUser , !user.isAnonymous{
            
            loginOutBtn.title = "Logout"
        }
            
        else {
            loginOutBtn.title = "Login"
        }
        
    }
    func presentLogin() {
        
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier:"LoginVC")
        self.present(controller, animated: true)
    }
    
    
    @IBAction func loginOutPresent(_ sender: Any) {
        //login
        
        
        guard  let user = Auth.auth().currentUser else {return}
        
        
        if user.isAnonymous {
            presentLogin()
        }
        else {
            do {
                try Auth.auth().signOut()
                Auth.auth().signInAnonymously { (result, error) in
                    if let error = error {
                        Auth.auth().handleFireAuthError(error: error, vc: self)
                    }
                }
                presentLogin()
            }catch {
                Auth.auth().handleFireAuthError(error: error, vc: self)
            }
            
            //        if let _ = Auth.auth().currentUser {
            //            do {
            //             //try Auth.auth().signOut()
            //                presentLogin()
            //            } catch {
            //                print("error")
            //            }
            //        } else {
            //            presentLogin()
            //        }
            
        }
        
    }
}


extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func onDocumentAdd(chnage: DocumentChange , category: Category) {
        let newIndex = Int(chnage.newIndex)
        categories.insert(category, at: newIndex)
        collectionview.insertItems(at: [IndexPath(item: newIndex, section: 0)])
    }
    func onDocumentRemove(change: DocumentChange){
        let oldIndex = Int(change.oldIndex)
        categories.remove(at: oldIndex)
        collectionview.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
    }
    func onDocumentModified(change: DocumentChange , category: Category) {
        if change.oldIndex == change.newIndex {
            //Item is change but remainded in samepostion
            let index = Int(change.newIndex)
            categories[index] = category
            collectionview.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
        else {
            
            // Item changed and change postion
            
            let oldIndex = Int(change.oldIndex)
            let newindex = Int(change.newIndex)
            categories.remove(at: oldIndex)
            categories.insert(category, at: newindex)
            collectionview.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newindex, section: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell" , for: indexPath) as? CategoryCell {
            cell.configureCell(Category: categories[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 50) / 2
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCaregory = categories[indexPath.row]
        performSegue(withIdentifier: "ToProducts", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "ToProducts" {
            if let productvc = segue.destination as? ProductsVC {
                productvc.category = selectedCaregory
            }
        }
    }
}





// fetch document
//    func fetchData(){
//
//
//
//
//        func fetchData() {
//            let docRef = Firestore.firestore().collection("Categories").document("gblH5GPHgoGEuWbs2TqD")
//
//            docRef.addSnapshotListener { (snap, error) in
//                guard let data = snap?.data() else{return}
//           let category = Category.init(data: data)
//                self.categories.append(category)
//                self.collectionview.reloadData()
//            }

//        }
//    func fetchData(){
//
//        let docref = Firestore.firestore().collection("Categories").document("gblH5GPHgoGEuWbs2TqD")
//       listener = docref.addSnapshotListener { (snap, error) in
//
//         self.categories.removeAll()
//            guard let data = snap?.data() else{return}
//
//
//            let category = Category(data: data)
//
//            self.categories.append(category)
//           self.collectionview.reloadData()
//
//        }
//
//    }

