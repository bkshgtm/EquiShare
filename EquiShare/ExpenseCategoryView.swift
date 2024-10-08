import SwiftUI

struct ExpenseCategoryView: View {
    @EnvironmentObject var expenseManager: ExpenseManager // Use EnvironmentObject
    @State private var newCategory = "" // Text for new category

    var body: some View {
        NavigationView {
            VStack {
                // Add Category Section
                HStack {
                    TextField("New Category", text: $newCategory)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: addCategory) {
                        Text("Add")
                            .padding()
                            .background(Color.buttonColor)
                            .foregroundColor(Color.buttonTextColor)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
                .padding()
                
                // List Categories
                List(expenseManager.categories, id: \.self) { category in
                    Text(category)
                }
                .navigationTitle("Categories")
            }
            .padding()
        }
    }
    
    private func addCategory() {
        // Only add if newCategory is not empty
        guard !newCategory.isEmpty else { return }
        expenseManager.addCategory(name: newCategory)
        newCategory = ""  // Clear the text field after adding
    }
}

