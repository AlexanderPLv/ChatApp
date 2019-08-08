//
//  TableViewExtensions.swift
//  ChatApp
//
//  Created by MacMini on 06/08/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit

extension UITableView {
    
    func scrollToBottom() {
        
        DispatchQueue.main.async {
            
            let section = self.numberOfSections - 1
            let row = self.numberOfRows(inSection: section) - 1
            
            if section >= 0 && row >= 0 {
                
                let bottomIndexPath = IndexPath(row: row, section: section)
                self.scrollToRow(at: bottomIndexPath, at: .bottom, animated: true)
                
            }
            
        }
        
    }
    
}
