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
        //Update element
    }
    
    func removeModel(with indexPath: IndexPath) {
        //Delete element
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let editAction = self.editAction(indexPath)
        let deleteAction = self.deleteAction(indexPath)
        
        return [deleteAction, editAction]
    }
    
    //Delete Action appear in swipe to delete note.
    private func deleteAction(_ indexPath: IndexPath) -> SwipeAction {
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.removeModel(with: indexPath)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "Trash-circle")
        
        return deleteAction
    }
    
    //Edit Action appear in swipe to edit note.
    private func editAction(_ indexPath: IndexPath) -> SwipeAction {
        
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            // handle action by updating model with edit
            self.updateModel(with: indexPath)
        }
        
        // customize the action appearance
        editAction.image = UIImage(named: "Flag-circle")
        
        return editAction
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
}
