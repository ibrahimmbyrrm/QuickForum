//
//  RegisterViewController.swift
//  QuickForum
//
//  Created by İbrahim Bayram on 29.11.2022.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var newUsernameTF: UITextField!
    
    @IBOutlet weak var newMailTF: UITextField!
    
    @IBOutlet weak var newPasswordTF: UITextField!
    
    @IBOutlet weak var newPasswordAgainTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signUpCompleted(_ sender: Any) {
        if newUsernameTF.text != "" && newMailTF.text != "" && newPasswordTF.text != "" && newPasswordAgainTF.text != "" {
            if newPasswordTF.text == newPasswordAgainTF.text {
                let user = PFUser()
                user.username = newUsernameTF.text!
                user.email = newMailTF.text!
                user.password = newPasswordTF.text!
                
                user.signUpInBackground { (success, error) in
                    if error != nil {
                        self.alertBox(title: "HATA", message: error?.localizedDescription ?? "HATA")
                    }else {
                        self.performSegue(withIdentifier: "newTabBar", sender: nil)
                    }
                }
            }else {
                self.alertBox(title: "HATA", message: "Your passwords must match!")
            }
        }else {
            self.alertBox(title: "HATA", message: "You have to enter all informations!")
        }
        
    }
    
    func alertBox(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
}
