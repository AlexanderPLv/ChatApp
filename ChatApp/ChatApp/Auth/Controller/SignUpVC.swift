//
//  SignUpVC.swift
//  ChatApp
//
//  Created by MacMini on 19/07/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: AuthTableViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    func assign(_ username: String, to firebaseUser: FirebaseAuth.User) {
        let changeRequest = firebaseUser.createProfileChangeRequest()
        changeRequest.displayName = username
        changeRequest.commitChanges { (requestError) in
            if let requestError = requestError {
                self.showInvalidFormAlert(with: requestError.localizedDescription)
            } else if let user = User(firebaseUser: firebaseUser) {
                self.performSegue(withIdentifier: "segue.Auth.signUpInApp", sender: user)
            }
        }
    }
    
   func createUser() {
    
    guard
        let username = usernameTextField.text,
        username.count > 3,
        let email = emailTextField.text,
        email.isValidEmail ,
        let password = passwordTextField.text
        else { showInvalidFormAlert(); return }
    
    Auth.auth().createUser(withEmail: email, password: password) { (authResult, authError) in
        if let authError = authError {
            self.showInvalidFormAlert( with: authError.localizedDescription )
        }
        if let authResult = authResult {
            self.assign(username, to: authResult.user)
        }
    }
}
    
    @IBAction func didTapSignUpVC(_ sender: Any) {
        createUser()
    }
    

}
