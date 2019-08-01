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
    
    @IBOutlet weak var chatContainerViewBottomConstraint: NSLayoutConstraint!
    
    var user: User?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        
        if let user = self.user {
            print("\(user)")
        }
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
