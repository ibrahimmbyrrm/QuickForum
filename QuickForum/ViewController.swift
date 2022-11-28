//
//  ViewController.swift
//  QuickForum
//
//  Created by İbrahim Bayram on 29.11.2022.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
   
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error != nil {
                    self.alertBox(title: "HATA", message: error?.localizedDescription ?? "HATA")
                }else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: nil)
    }
    
    func alertBox(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}

