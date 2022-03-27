//
//  FireStoreApp.swift
//  FireStore
//
//  Created by FUKA on 26.3.2022.
//

import SwiftUI
import Firebase

@main
struct FireStoreApp: App {
    
    init() { FirebaseApp.configure() }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
