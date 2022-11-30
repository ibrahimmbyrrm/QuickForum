//
//  ProfileViewController.swift
//  QuickForum
//
//  Created by İbrahim Bayram on 29.11.2022.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tabelView: UITableView!
    
    @IBOutlet weak var usrnameLabel: UILabel!
    
    var ownPost = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        usrnameLabel.text = PFUser.current()?.username
        
        getItems()

    

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ownPost.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OwnCell", for: indexPath) as! OwnFeedTableViewCell
        cell.ownContent.text = ownPost[indexPath.row].content
        return cell
    }

    @IBAction func logOutButton(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                self.createAlert(title: "HATA", message: error?.localizedDescription ?? "HATA")
            }else {
                self.performSegue(withIdentifier: "toLoginVC", sender: nil)
            }
        }
    }
    
    func createAlert(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    @objc func getItems() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.whereKey("username", equalTo: PFUser.current()?.username)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.createAlert(title: "HATA", message: error?.localizedDescription ?? "HATA")
            }else {
                if objects!.count > 0 {
                    self.ownPost.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let ownContent = object.object(forKey: "content") as? String {
                            if let username = object.object(forKey: "username") as? String {
                                let post = Post(username: username, content: ownContent)
                                self.ownPost.append(post)
                            }
                        }
                    }
                    self.tabelView.reloadData()
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getItems), name: NSNotification.Name(rawValue: "veriGirildi"), object: nil)
    }
}
