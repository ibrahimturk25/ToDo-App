//
//  HomePageViewController.swift
//  ToDoListApp
//
//  Created by İbrahim Türk on 14.09.2023.
//

import UIKit
import Firebase
class HomePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableViewList: UITableView!
    var tic = true
    var todoArray : [String] = []
    var idArray :[String] = []
    var priorityArray: [Int] = []  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewList.dataSource = self
        tableViewList.delegate = self
//        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(topBarAdd))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(topBarAdd))
        let logOut = UIBarButtonItem(title: "logOut   ", style: .plain, target: self, action: #selector(logOutTapped))
        let history = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(historyTapped))
        let rightButton4 = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(sag4Button))
        navigationItem.title = "To Do"
        navigationItem.rightBarButtonItems = [addButton,flexibleSpace,flexibleSpace,flexibleSpace,history]
        navigationItem.leftBarButtonItems = [logOut,rightButton4]
        getData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }

    func clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
        } catch {
            print("Failed to delete launch screen cache: \(error)")
        }
    }

    @objc func sag4Button(){
        
    }
    @objc func logOutTapped(){
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
            
        }catch{
            print("Error")
        }
        
    }
    @objc func topBarAdd(){
        performSegue(withIdentifier: "toUploadVC", sender: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    @objc func historyTapped(){
        performSegue(withIdentifier: "toHistoryVC", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! TableViewCellList
        cell.buttonOutletSelect.tag = indexPath.row
        cell.buttonOutletSelect.addTarget(self, action: #selector(selectButton), for: UIControl.Event.touchUpInside)
        cell.labelInfo.text = todoArray[indexPath.row]
//        cell.labelPriority.text = String(priorityArray[indexPath.row])
        cell.labelDocumentId.text = idArray[indexPath.row]
        switch priorityArray[indexPath.row] {
        case 0:
            cell.labelPriority.text = "Low"
        case 1:
            cell.labelPriority.text = "Medium"
        case 2:
            cell.labelPriority.text = "High"
        default:
            break
        }
        return cell
    }
    @objc func getData(){
        let user = Auth.auth().currentUser?.email
        let fireBaseStore = Firestore.firestore()
        fireBaseStore.collection(user!).whereField("completed", isEqualTo: false).order(by: "priority",descending: true).addSnapshotListener { querySnapshot, error in
            if error != nil{
                
            }else{
                if querySnapshot != nil{
                    self.todoArray.removeAll(keepingCapacity: true)
                    self.idArray.removeAll(keepingCapacity: true)
                    self.priorityArray.removeAll(keepingCapacity: true)
                    for document in querySnapshot!.documents{
                        let documentId = document.documentID
                        if let todo = document.get("ToDo") as? String{
                            if let priority = document.get("priority") as? Int{
                                self.todoArray.append(todo)
                                self.idArray.append(documentId)
                                self.priorityArray.append(priority)
                                
                            }
                    
                            
                        }
                    }
                    self.tableViewList.reloadData()
                }
            }
        }
    }
    @objc func selectButton(sender: UIButton){
        
        let fireStoreBase = Firestore.firestore()
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        let cell = tableViewList.cellForRow(at: myIndexPath as IndexPath) as! TableViewCellList
        let user = Auth.auth().currentUser?.email
        let data = ["completed" : true] as? [String : Any]
        getData()
        fireStoreBase.collection(user!).document(cell.labelDocumentId.text!).setData(data!, merge: true)
        tic = false
   
    }
 

}
