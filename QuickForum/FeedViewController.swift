//
//  FeedViewController.swift
//  QuickForum
//
//  Created by İbrahim Bayram on 29.11.2022.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
   
    var postDizisi = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        verileriAl()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "protCell", for: indexPath) as! FeedTableViewCell
        cell.textView.text = postDizisi[indexPath.row].content
        cell.usernameLabel.text = "\(postDizisi[indexPath.row].username)'s Post"
        return cell
    }
    
    @objc func verileriAl() {
        print("done")
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.createAlert(title: "HATA", message: error?.localizedDescription ?? "HATA")
            }else {
                if objects!.count > 0 {
                    self.postDizisi.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let username = object.object(forKey: "username") as?  String {
                            if let userContent = object.object(forKey: "content") as? String {
                                    let post = Post(username: username, content: userContent)
                                        self.postDizisi.append(post)
                                    

                            }
                        }else {
                            print("hata aldık")
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func createAlert(title : String , message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(verileriAl), name: NSNotification.Name(rawValue: "veriGirildi"), object: nil)
    }

}
