//
//  MessageTextView.swift
//  ChatApp
//
//  Created by MacMini on 01/08/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit

class MessageTextView: GrowingTextView {

    override func setupView() {
        super.setupView()
        
        layer.cornerRadius = 5
        placeholderTextView.text = "Enter a message"
    }

}
