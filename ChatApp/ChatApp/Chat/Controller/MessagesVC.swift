//
//  MessagesVC.swift
//  ChatApp
//
//  Created by MacMini on 24/07/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MessagesVC: UIViewController {
    
    @IBOutlet weak var messageTextView: MessageTextView!
    @IBOutlet weak var chatContainerViewHieghtConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    let database = Firestore.firestore()
    lazy var messagesCollection = database.collection("messages")
    
    var user: User!
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        addObservers()
        observeMessages()
        messageTextView.growingTextViewDelegate = self
        
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil,
                                               queue: .main,
                                               using: keyboardWillShow)
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil,
                                               queue: .main,
                                               using: keyboardWillHide)
    }
    
    func observeMessages() {
        
        messagesCollection.order(by: "creationDate").addSnapshotListener { (snapshot, error) in
            
            if let snapshot = snapshot {
                
                var messagesFromFirestore = [Message]()
                
                for document in snapshot.documents {
                    let dictionary = document.data()
                    guard
                    let sender = dictionary["sender"] as? String,
                    let body = dictionary["body"] as? String
                    else { return }
                    
                    let message = Message(sender: sender, body: body)
                    messagesFromFirestore.append(message)
                }
                self.messages = messagesFromFirestore
                self.tableView.reloadData()
            }
            
            
        }
        
    }
    
    
    func keyboardWillShow (notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else{ return }
        
        let bottomInset = self.view.safeAreaInsets.bottom
        let keyboardHieght = keyboardFrame.cgRectValue.height
        
        chatContainerViewBottomConstraint.constant = bottomInset - keyboardHieght
        UIView.animate(withDuration: 0.25, animations: view.layoutIfNeeded)
    }
    
    
    func keyboardWillHide(notification: Notification) {
        chatContainerViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: view.layoutIfNeeded)
    }
    
    func sendMessage() {
        
        let dataDictionary: [String: Any] = [ "sender": user.username,
                                              "body"  : messageTextView.text as Any,
                                              "creationDate": FieldValue.serverTimestamp()]
        
        messagesCollection.addDocument(data: dataDictionary) { (error) in
            if let error = error {
                print(error)
            } else {
                self.messageTextView.text.removeAll()
                print("complete")
                
            }
        }
        
        
    }
    
    @IBAction func didTapSignOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "segue.Chat.messagesToSignIn", sender: nil)
        } catch let signOutError {
            print(signOutError)
        }
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        messageTextView.endEditing(true)
        sendMessage()
    }
    
}

extension MessagesVC: GrowingTextViewDelegate {
    func growingTextView(_ growingTextView: GrowingTextView, hieghtDidChangeTo height: CGFloat) {
        let verticalPadding: CGFloat = 8
        chatContainerViewHieghtConstraint.constant = height + verticalPadding
    }
}


extension MessagesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell
            else { return UITableViewCell() }
        let message = messages[indexPath.row]
        let currentUser = message.sender == user?.username
        
        cell.populate(with: message, isFromCurrentUser: currentUser)
        
        return cell
    }
    
    
}
