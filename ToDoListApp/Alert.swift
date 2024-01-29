//
//  User.swift
//  ToDoListApp
//
//  Created by İbrahim Türk on 14.09.2023.
//

import Foundation
import Firebase


struct Alert{

    func MakeAlert(title: String, message: String,vc :UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        vc.present(alert, animated: true)
    }
}
