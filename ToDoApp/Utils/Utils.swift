//
//  utils.swift
//  ToDoApp	
//
//  Created by MSI on 6/5/20.
//  Copyright © 2020 MSI. All rights reserved.
//

import Foundation
import Amplify
import AmplifyPlugins

class Utils {
    
    func createItem(with item: Todo, _ callback: @escaping () -> Void) {
        Amplify.DataStore.save(item) { (result) in
            switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem)")
                callback()
            case .failure(let error):
                print("Coudn't save item to datastore: \(error)")
            }
        }
    }
    
    func readItem() -> [Todo] {
        
        var todolist = [Todo]()
        
        Amplify.DataStore.query(Todo.self) { (result) in
            switch(result) {
            case .success(let todos):
                todolist = todos
            case .failure(let error):
                print("Coudn't query items: \(error)")
            }
        }
        
        return todolist
    }
    
    func updateItem(_ id: String, _ updateItem: Todo, _ callback: @escaping () -> Void) {
        Amplify.DataStore.query(Todo.self, where: Todo.keys.id.eq(id)) { (result) in
            switch(result) {
            case .success(let todos):
                guard todos.count == 1, var updatedTodo = todos.first else {
                    print("Did not find extactly one todo, bailing")
                    return
                }
                updatedTodo.name = updateItem.name
                
                createItem(with: updateItem) {
                    callback()
                }
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        }
    }
    
    private func removeItem(_ toDeleteTodo: Todo, _ callback: @escaping () -> Void) {
        Amplify.DataStore.delete(toDeleteTodo) { (result) in
            print(result)
            switch(result) {
            case .success:
                print("Removed item: \(toDeleteTodo.name)")
                callback()
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        }
    }
    
    func removeItem(_ id: String, _ callback: @escaping () -> Void) {
        Amplify.DataStore.delete(Todo.self, withId: id) { (result) in
            print(result)
            switch(result) {
            case .success:
                print("Removed item Sucessfully")
                callback()
            case .failure(let error):
                print("Could not query DataStore: \(error)")
            }
        }
    }
}
