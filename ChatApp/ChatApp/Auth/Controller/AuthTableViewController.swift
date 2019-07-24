//
//  AuthTableViewController.swift
//  ChatApp
//
//  Created by MacMini on 19/07/2019.
//  Copyright © 2019 com.blablabla. All rights reserved.
//

import UIKit

class AuthTableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let defaultHeight = super.tableView(tableView, heightForRowAt: indexPath)
        
        guard indexPath.row == 0 else { return defaultHeight}
        let firstRowHeight = tableView.bounds.height * 0.4
        
        return firstRowHeight
        }
    
    
    
    func standardSegueToApp( segue: UIStoryboardSegue, sender: Any? ) {
      if let navController = segue.destination as? UINavigationController,
         let messagesVC = navController.topViewController as? MessagesVC,
         let user = sender as? User {
        messagesVC.user = user
        }
    }
    
    
    func showInvalidFormAlert(with message: String? = nil) {
        
        let alertMessage = message ?? "Please enter valid information below"
        let alert = UIAlertController(title: "Invalid Info", message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel)
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
}
