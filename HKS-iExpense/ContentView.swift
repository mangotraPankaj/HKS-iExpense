//
//  ContentView.swift
//  HKS-iExpense
//
//  Created by Pankaj Mangotra on 08/07/21.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let name: String
    let type: String
    let amount: Int
    var id = UUID()
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        } else {
            self.items = []
        }
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var counter = 100
    @State private var showAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: deleteItems(at:))
            }
            .sheet(isPresented: $showAddExpense) {
                AddView(expenses: self.expenses)
            }

            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing: Button(action: {
                self.showAddExpense = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }

    func deleteItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
