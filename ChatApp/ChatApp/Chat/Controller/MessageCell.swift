//
//  MessageCell.swift
//  ChatApp
//
//  Created by MacMini on 01/08/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    

    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var senderUsernameLabel: UILabel!
    @IBOutlet weak var messageStyleView: MessageStyleView!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    func populate(with message: Message, isFromCurrentUser: Bool) {
        senderUsernameLabel.text = message.sender
        messageBodyLabel.text = message.body
        
        contentStackView.alignment = isFromCurrentUser ? .trailing : .leading
        let style: MessageStyle = isFromCurrentUser ? .sent : .received
        messageStyleView.design(style: style)
    }
    
    
    
}
