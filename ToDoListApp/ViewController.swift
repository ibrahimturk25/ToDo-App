//
//  ViewController.swift
//  ToDoListApp
//
//  Created by İbrahim Türk on 13.09.2023.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPasswordAgain: UITextField!
    @IBOutlet weak var buttonOutletLogin: UIButton!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonOutletSignIn: UIButton!
    let alert = Alert()
    var girisDeger = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func buttonLogin(_ sender: Any) {
        if girisDeger == true{
            if textFieldEmail.text != "" && textFieldPassword.text != "" {
                Auth.auth().signIn(withEmail: textFieldEmail.text!, password: textFieldPassword.text!) { authData, error in
                    if error != nil{
                        self.alert.MakeAlert(title: "Error", message: error?.localizedDescription ?? "Error", vc: self)
                    }else{
                        self.performSegue(withIdentifier: "toHomePageVC", sender: nil)
                        self.textFieldEmail.text = ""
                        self.textFieldPassword.text = ""
                    }
                }
                
            }else{alert.MakeAlert(title: "Error", message: "UserName // Password ??", vc: self)}
        }else{
            if textFieldEmail.text != "" && textFieldPassword.text != "" && textFieldPasswordAgain.text != ""{
                if textFieldPassword.text == textFieldPasswordAgain.text {
                    Auth.auth().createUser(withEmail: textFieldEmail.text!, password: textFieldPassword.text!) { authData, error in
                        if error != nil{
                            self.alert.MakeAlert(title: "Error", message: error?.localizedDescription ?? "Error" , vc: self)
                        }else{
                            self.textFieldEmail.text = ""
                            self.textFieldPassword.text = ""
                            self.textFieldPasswordAgain.text = ""
                            self.performSegue(withIdentifier: "toHomePageVC", sender: nil)
                        }
                    }
                }
                else{alert.MakeAlert(title: "Error", message: "passwords do not match", vc: self)}
            }
            else{alert.MakeAlert(title: "Error", message: "UserName // Password ??", vc: self)}
        }
    }
    
    
    
    @IBAction func buttonSignIn(_ sender: Any) {
        if girisDeger == true{
            girisDeger = false
            textFieldPasswordAgain.isHidden = false
            buttonOutletLogin.setTitle("Sign In", for: .normal)
            buttonOutletSignIn.setTitle("Log In", for: .normal)
            labelInfo.text = "Do you  have an account?"
        }else{
            girisDeger = true
            textFieldPasswordAgain.isHidden = true
            buttonOutletLogin.setTitle("Log In", for: .normal)
            buttonOutletSignIn.setTitle("Sing In", for: .normal)
            labelInfo.text = "You don't have an account"
        }
        
         
    }
    
}

