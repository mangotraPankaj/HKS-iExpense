//
//  AddView.swift
//  HKS-iExpense
//
//  Created by Pankaj Mangotra on 08/07/21.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @ObservedObject var expenses: Expenses
    
    static let types = ["Business","Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name",text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }.navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button(action: {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                }
            }, label: {
                Image(systemName: "bolt.horizontal.circle.fill")
            }))
        }
    }
}
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

