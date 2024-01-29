//
//  UploadViewController.swift
//  ToDoListApp
//
//  Created by İbrahim Türk on 15.09.2023.
//

import UIKit
import Firebase
class UploadViewController: UIViewController {
    @IBOutlet weak var textFieldComment: UITextField!

    var alert = Alert()
    var segmentCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func buttonSaveClicked(_ sender: Any) {
        if textFieldComment.text == "" {
            alert.MakeAlert(title: "Error", message: "cannot be empty", vc: self)
        }else{
            let fireStoreBase = Firestore.firestore()
            var fireStoreReferance : DocumentReference? = nil
            let user = Auth.auth().currentUser?.email
            let fireStoreMission = ["user":Auth.auth().currentUser!.email!,"ToDo":textFieldComment.text!,"priority": segmentCount ,"completed":false,"date":FieldValue.serverTimestamp()] as [String:Any]
            fireStoreReferance = fireStoreBase.collection(String(user!)).addDocument(data: fireStoreMission, completion: { error in
                if error != nil{
                    self.alert.MakeAlert(title: "Error", message: error?.localizedDescription ?? "Error", vc: self)
                }else{
                    NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
                    self.textFieldComment.text = ""
                }
            })
        }
    }
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            segmentCount = 0
        }else if sender.selectedSegmentIndex == 1{
           segmentCount = 1
        }else{
            segmentCount = 2
        }
    }
}
