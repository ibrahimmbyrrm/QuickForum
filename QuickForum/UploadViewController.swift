//
//  UploadViewController.swift
//  QuickForum
//
//  Created by İbrahim Bayram on 29.11.2022.
//

import UIKit
import Parse

class UploadViewController: UIViewController {

    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = PFUser.current()?.username
        
        
    }

    @IBAction func shareButtonClicked(_ sender: Any) {
        let post = PFObject(className: "Post")
        if PFUser.current() != nil {
            post["username"] = PFUser.current()?.username
            post["content"] = postTextView.text
            
            post.saveInBackground { (success, error) in
                if error != nil {
                    let alert = UIAlertController(title: "HAT", message: error?.localizedDescription ?? "HATA", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                    alert.addAction(okButton)
                    self.present(alert, animated: true)
                }else {
                    self.postTextView.text = ""
                    self.tabBarController?.selectedIndex = 0
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "veriGirildi"), object: nil)
                }
            }
        }
        
    }
    
}
