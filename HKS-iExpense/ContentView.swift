//
//  ContentView.swift
//  HKS-iExpense
//
//  Created by Pankaj Mangotra on 08/07/21.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    let name: String
    let type: String
    let amount: Int
    let id = UUID()
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
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
