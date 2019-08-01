//
//  GrowingTextView.swift
//  ChatApp
//
//  Created by MacMini on 31/07/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit

protocol GrowingTextViewDelegate: class {
    func growingTextView(_ growingTextView: GrowingTextView, hieghtDidChangeTo height: CGFloat)
}

class GrowingTextView: PlaceholderTextView {
    
    weak var growingTextViewDelegate: GrowingTextViewDelegate?

    let maxHeight: CGFloat = 100
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        isScrollEnabled = false
    }
    
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        
        let width = bounds.width
        
        let newSize = sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
        let newHieght = newSize.height
        let finalHeight = newHieght > maxHeight ? maxHeight : newHieght
        isScrollEnabled = newHieght > maxHeight
        
        growingTextViewDelegate?.growingTextView(self, hieghtDidChangeTo: finalHeight)
    }

}
