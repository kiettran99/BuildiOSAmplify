//
//  SwipeViewController.swift
//  	
//
//  Created by MSI on 6/5/20.
//  Copyright © 2020 MSI. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateModel(with indexPath: IndexPath) {
            //Delete element
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SwipeTableViewCell
            
            cell.delegate = self
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                // handle action by updating model with deletion
                self.updateModel(with: indexPath)
            }

            // customize the action appearance
            deleteAction.image = UIImage(named: "Trash-circle")

            return [deleteAction]
        }
        
        func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeOptions()
            options.expansionStyle = .destructive
            options.transitionStyle = .border
            return options
        }
}
