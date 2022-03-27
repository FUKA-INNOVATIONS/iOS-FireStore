//
//  TodoViewModel.swift
//  FireStore
//
//  Created by FUKA on 26.3.2022.
//

import Foundation
import Firebase

class TodoViewModel: ObservableObject {
    @Published var list = [Todo]()  //  [Todo]() creates and empty array
    
    
    func updateData(todoToUpdate: Todo) {
        let db = Firestore.firestore()  // Get a ref to the db
        
        // Set data to update. merge -> update only fields defined, absense of merge delets all existing fileds and replace with updated ones
        // db.collection("todos").document(todoToUpdate.id).setData(["name": "adsad"], merge: true) // -> Without completion block
        db.collection("todos").document(todoToUpdate.id).setData(["name":"Updated->\(todoToUpdate.name)"], merge: true) { error in
            // Check for errors
            if error == nil {
                // Get the new data
                self.getData()
            }
        }
    }
    
    func deleteData(todoToDelete: Todo) {
        let db = Firestore.firestore()  // Get a ref to the db
        
        // Specify the document to delete
        db.collection("todos").document(todoToDelete.id).delete { error in // This closure is called after request returns
            if error == nil {   // No errors, delete todo from the list
                // Update the UI from the main thread
                DispatchQueue.main.async {  // Run in main thread to affect the UI
                    // Remove the todo that was just delted from db
                    self.list.removeAll { todo in
                        return todo.id == todoToDelete.id   // Check for the todo to remove
                    }
                }
            }
        }
    }
    
    
    func addData(name: String, notes: String) {
        let db = Firestore.firestore()  // Get a ref to the db
        db.collection("todos").addDocument(data: ["name":name, "notes":notes]) { error in
            if error == nil {
                self.getData() // retrieve latest data
            }
            else {
                // Handle error
            }
        }
        
        
    } // end of addData()
    
    
    func getData() {
        let db = Firestore.firestore()  // Get a ref to the db
        db.collection("todos").getDocuments { snapshot, error in    // Read the documents a a specific path
            
            if error == nil {   // Check for errors
                
                if let snapshot = snapshot {    // No errors
                    // Get all the documents and create todos
                    // snapshot.documents returns an dictionary
                    
                    // In order to update the ui, Run in foreground thread
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { document in
                            // transform documents into todos
                            // Create a Todo item for each document returned
                            return Todo(id: document.documentID,
                                        name: document["name"] as? String ?? "",
                                        notes: document["notes"] as? String ?? "")
                        }
                    }
                }
                
            }
            else {
                // Handle the error
            }
        }
    } // end of getData()
    
}
