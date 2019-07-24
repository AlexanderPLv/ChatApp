//
//  RoundedButton.swift
//  ChatApp
//
//  Created by MacMini on 19/07/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
    }

}
