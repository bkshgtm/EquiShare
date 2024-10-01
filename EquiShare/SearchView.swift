import SwiftUI

struct SearchView: View {
    @StateObject private var expenseManager = ExpenseManager()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List {
                    // Filter and display expenses based on the search text
                    ForEach(expenseManager.expenses.filter { $0.name.contains(searchText) || searchText.isEmpty }, id: \.id) { expense in
                        HStack {
                            Text(expense.name)
                            Spacer()
                            Text("$\(expense.amount, specifier: "%.2f")")
                        }
                    }
                    
                    // Filter and display users based on the search text
                    ForEach(expenseManager.users.filter { $0.name.contains(searchText) || searchText.isEmpty }, id: \.id) { user in
                        HStack {
                            Text(user.name)
                            Spacer()
                            Text("$\(user.balance, specifier: "%.2f")")
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Search")
        }
    }
}

