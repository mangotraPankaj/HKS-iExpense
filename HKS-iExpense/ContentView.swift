//
//  ContentView.swift
//  HKS-iExpense
//
//  Created by Pankaj Mangotra on 08/07/21.
//

import SwiftUI

struct User: Codable {
    var firstName : String
    var lastName: String
}

struct ContentView: View {
    
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
