//
//  MessageStyleView.swift
//  ChatApp
//
//  Created by MacMini on 01/08/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit

class MessageStyleView: UIView {
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
    }
    
    func setupView() {
        layer.cornerRadius = 10
        clipsToBounds = true
        }
    
    func design(style: MessageStyle) {
        switch style {
        case .sent:
            backgroundColor = UIColor(named: "messageBubbleColor")
            layer.borderWidth = 0
            layer.borderColor = UIColor.clear.cgColor
            
        case .received:
            backgroundColor = UIColor.clear
            layer.borderWidth = 1
            layer.borderColor = UIColor(named: "messageBubbleColor")?.cgColor
        }
        
    }

}
