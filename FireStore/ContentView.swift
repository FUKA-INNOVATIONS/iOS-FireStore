//
//  ContentView.swift
//  FireStore
//
//  Created by FUKA on 26.3.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = TodoViewModel()
    @State var showDeleteConfirm = false
    
    @State var name = ""
    @State var notes = ""
    
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Safe'eye")
                List (model.list) { item in
                    
                    /*  Having button/s in a list makes whole list item tappable
                        and creates issues when there is multiple buttons.
                        Workaround -> add buttonStyle to each button
                     */
                    
                    HStack {
                        Text(item.name)
                        Spacer()
                        
                        Button {    // Update button
                            model.updateData(todoToUpdate: item)
                        } label: {
                            Image(systemName: "pencil")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Button {    // Delete button
                            showDeleteConfirm = true
                        } label: {
                            Image(systemName: "minus.circle")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .alert("Are you sure?", isPresented: $showDeleteConfirm) {
                            Button("Delete", role: .destructive) {  // Deltetion confirmed
                                model.deleteData(todoToDelete: item)
                            }
                            Button("Cancel", role: .cancel) {
                                print("Cancel")
                            }
                        } message: {
                            Text("This will be delted permanently!")
                        }
                        

                    }
                    
                }
                
                Divider()
                
                VStack(spacing: 5) {
                    TextField("Name", text: $name)  // $name -> binding
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Notes", text: $notes)    // $notes -> binding
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button {
                        model.addData(name: name, notes: notes) // Add new todo to db
                        
                        // Clear text fileds
                        name = ""
                        notes = ""
                    } label: {
                        Text("Add todo")
                    }
                }
                .padding()
                
            }
        }
        
    }
    
    init() {
        model.getData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
