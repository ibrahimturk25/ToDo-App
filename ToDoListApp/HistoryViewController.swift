//
//  HistoryViewController.swift
//  ToDoListApp
//
//  Created by İbrahim Türk on 18.09.2023.
//

import UIKit
import Firebase
class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableViewHistory: UITableView!
    var tic = false
    var todoArray: [String] = []
    var idArray: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHistory.dataSource = self
        tableViewHistory.delegate = self
        let user = Auth.auth().currentUser?.email
        let fireBaseStore = Firestore.firestore()
        
        fireBaseStore.collection(user!).whereField("completed", isEqualTo: true).addSnapshotListener { querySnapshot, error in
            if error != nil{
                
            }else{
                if querySnapshot != nil{
                    self.todoArray.removeAll()
                    self.idArray.removeAll()
                    for document in querySnapshot!.documents{
                        let documentId = document.documentID
                        if let todo = document.get("ToDo") as? String{
                            self.todoArray.append(todo)
                            self.idArray.append(documentId)
                        }
                    }
                    self.tableViewHistory.reloadData()
                }
            }
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellHistory",for: indexPath) as! HistoryTableViewCell
        cell.labelInfo.text = todoArray[indexPath.row]
        cell.buttonTicOutlet.addTarget(self, action: #selector(ticButton), for: .touchUpInside)
        cell.buttonTrashOutlet.addTarget(self, action: #selector(trashButton), for: .touchUpInside)
        cell.buttonTicOutlet.tag = indexPath.row
        cell.buttonTrashOutlet.tag = indexPath.row
        return cell

    }
    
    @objc func ticButton(sender: UIButton){
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        let cell = tableViewHistory.cellForRow(at: myIndexPath as IndexPath) as! HistoryTableViewCell
        let fireStoreBase = Firestore.firestore()
        let user = Auth.auth().currentUser?.email
        let data = ["completed" : false] as? [String : Any]
        fireStoreBase.collection(user!).document(idArray[sender.tag]).setData(data!, merge: true)
        print(cell.labelDocumentId.text!)
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
    }
    @objc func trashButton(sender: UIButton){
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        let cell = tableViewHistory.cellForRow(at: myIndexPath as IndexPath) as! HistoryTableViewCell
        let fireStoreBase = Firestore.firestore()
        let user = Auth.auth().currentUser?.email
        fireStoreBase.collection(user!).document(idArray[sender.tag]).delete { error in
            if error == nil {
                NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
            }
        }
        
    }
    


}
