//
//  PlaceholderTextView.swift
//  ChatApp
//
//  Created by MacMini on 31/07/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit

class PlaceholderTextView: UITextView {

    let placeholderTextView = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    func setupView() {
        delegate = self
        
        placeholderTextView.frame = CGRect(x: 5, y: -6, width: bounds.width, height: bounds.height)
        placeholderTextView.textColor = .lightGray
        placeholderTextView.font = font
        
        
        addSubview(placeholderTextView)
        
    }

}

extension PlaceholderTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderTextView.isHidden = textView.text.count != 0
    }
    
}
