//
//  MessagesVC.swift
//  ChatApp
//
//  Created by MacMini on 24/07/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit
import FirebaseAuth
class MessagesVC: UIViewController {
    
    @IBOutlet weak var messageTextView: MessageTextView!
    @IBOutlet weak var chatContainerViewHieghtConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var user: User?
    var messages = [Message(sender: "Alex", body: "Hey whats up"), Message(sender: "Isha", body: "Hey, its okey"), Message(sender: "anonim", body: "Some text here but i dont know what i want write to see everythings gonna right. ")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        addObservers()
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
    
    
    @IBAction func didTapSignOutButton(_ sender: Any) {
        do {
           try Auth.auth().signOut()
            performSegue(withIdentifier: "segue.Chat.messagesToSignIn", sender: nil)
        } catch let signOutError {
            print(signOutError)
        }
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
