//
//  SignInVC.swift
//  ChatApp
//
//  Created by MacMini on 19/07/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC: AuthTableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    func signIn() {
        guard
            let email = emailTextField.text,
            email.isValidEmail,
            let password = passwordTextField.text,
            password.count > 3
            else { showInvalidFormAlert(); return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, authError) in
            if let authError = authError {
                self.showInvalidFormAlert( with: authError.localizedDescription )
            }
            if let authResult = authResult,
               let user = User(firebaseUser: authResult.user) {
                self.performSegue(withIdentifier: "segue.Auth.signInToApp", sender: user)
            }
        }
    }
    
    
    @IBAction func didTapSignInButton(_ sender: Any) {
        signIn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        standardSegueToApp(segue: segue, sender: sender)
    }
    
    
}
