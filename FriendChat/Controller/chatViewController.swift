//
//  chatViewController.swift
//  FriendChat
//
//  Created by Phi Hoang Huy on 7/13/18.
//  Copyright © 2018 Phi Hoang Huy. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework
class chatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var heightConstranit: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    var messageArray : [Message] = [Message]()
    // Send data to Firebase
    @IBAction func sendPressed(_ sender: Any) {
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        let messagesDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender" : Auth.auth().currentUser?.email, "MessageBody" : messageTextField.text! ]
        messagesDB.childByAutoId().setValue(messageDictionary)
        {
            (error, reference) in
            if error != nil {
                print (error!)
            } else {
                print("Successfully")
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
        }
    }
    // Set up number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    // update UI
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customeMessageCell", for: indexPath) as! messageCustomCell
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUserName.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "happy")
        if cell.senderUserName.text == Auth.auth().currentUser?.email as String? {
            cell.avatarImageView.backgroundColor = UIColor.flatPurple()
            cell.messageBackGround.backgroundColor = UIColor.flatSkyBlue()
        } else {
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            cell.messageBackGround.backgroundColor = UIColor.flatRed()
        }
        return cell
    }
    // Fix auto layout
    func configureTableView(){
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.8) {
            self.heightConstranit.constant = 311
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.8) {
            self.heightConstranit.constant = 53
            self.view.layoutIfNeeded()
        }
        
    }
    //TODO: Grab messages from Firebase
    func retrieveMessage() {
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            let message = Message()
            message.messageBody = text
            message.sender = sender
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
        }
    }
    @objc func tableViewTapped() {
        messageTextField.endEditing(true)
    }
    override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        super.viewDidLoad()
        messageTextField.delegate = self
     messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.register(UINib(nibName: "messageCustomCell", bundle: nil), forCellReuseIdentifier: "customeMessageCell")
        // Do any additional setup after loading the view.
        configureTableView()
        retrieveMessage()
        messageTableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoutPressed(_ sender: Any) {
        do {
        try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        }
        catch
        {
            print("Error")
        }
    }
}
