//
//  User.swift
//  ChatApp
//
//  Created by MacMini on 24/07/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    
    let username: String
    let email: String
    let id: String
    
    init?( firebaseUser: FirebaseAuth.User ){
        
        guard
            let displayName = firebaseUser.displayName,
            let email = firebaseUser.email
            else { return nil }
        self.username = displayName
        self.email = email
        self.id = firebaseUser.uid
        
    }
    
}

extension User: CustomStringConvertible {
var description: String {
    let userDescription = """
    id       = \(id)
    username = \(username)
    email    = \(email)
    """
    return userDescription
    }

}

