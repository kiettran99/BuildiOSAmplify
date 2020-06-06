//
//  ViewController.swift
//  ToDoApp
//
//  Created by MSI on 6/5/20.
//  Copyright © 2020 MSI. All rights reserved.
//

import UIKit

class ViewController: SwipeViewController {
    
    let utils = Utils()
    var todos = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performOnAppear()
        tableView.rowHeight = 80.0
        //utils.subscribeTodos()
    }
    
    override func removeModel(with indexPath: IndexPath) {
        //Remove this item
        let id = todos[indexPath.row].id
        utils.removeItem(id) {
            self.tableView.reloadData()
        }
    }
    
    override func updateModel(with indexPath: IndexPath) {
        //Remove this item
        let id = todos[indexPath.row].id
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Edit ToDo Items", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Edit Item", style: .default) { (action) in
            if let text = textField.text {
                let todo = Todo(name: text)
                self.utils.updateItem(id, todo) {
                    self.performOnAppear()
                }
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.text = self.todos[indexPath.row].name
            textField = alertTextField
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
    }
    
    func performOnAppear() {
        //let item = Todo(name: "Build ios app", description: "Build ios Application using Amlify")
        todos = utils.readItem()
        self.tableView.reloadData()
    }
    
    @IBAction func addItemButton() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Items", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let text = textField.text {
                let todo = Todo(name: text)
                self.utils.createItem(with: todo) {
                    self.performOnAppear()
                }
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new item."
            textField = alertTextField
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = String(todos[indexPath.row].name)
        
        return cell
    }
}

