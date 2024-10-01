import SwiftUI
import Combine

// User Model
struct ExpenseUser: Identifiable {
    var id = UUID()
    var name: String
    var balance: Double
}

// Expense Model
struct ExpenseItem: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var participants: [String]
    var category: String
}

// ExpenseManager Class
class ExpenseManager: ObservableObject {
    @Published var users: [ExpenseUser] = []              // List of users
    @Published var categories: [String] = []               // List of expense categories
    @Published var expenses: [ExpenseItem] = []            // List of expenses

    // Method to add a new user
    func addUser(name: String) {
        let newUser = ExpenseUser(name: name, balance: 0.0)
        users.append(newUser)
    }

    // Method to delete a user
    func deleteUser(at index: Int) {
        guard index >= 0 && index < users.count else { return }
        users.remove(at: index)
    }

    // Method to add a new category
    func addCategory(name: String) {
        guard !name.isEmpty, !categories.contains(name) else { return }
        categories.append(name)
    }

    // Method to add a new expense
    func addExpense(name: String, amount: Double, participants: [String], category: String) {
        let newExpense = ExpenseItem(name: name, amount: amount, participants: participants, category: category)
        expenses.append(newExpense)
        updateUserBalances(for: participants, amount: amount)  // Update balances of involved users
    }

    // Method to update user balances based on the expense participants
    private func updateUserBalances(for participants: [String], amount: Double) {
        let splitAmount = amount / Double(participants.count) // Split amount among participants
        
        for participant in participants {
            if let index = users.firstIndex(where: { $0.name == participant }) {
                users[index].balance += splitAmount  // Update balance for each participant
            }
        }
    }

    // Method to calculate total balance of all users
    func totalBalance() -> Double {
        return users.reduce(0) { $0 + $1.balance }
    }

    // Method to get expenses for a specific category
    func getExpenses(for category: String) -> [ExpenseItem] {
        return expenses.filter { $0.category == category }
    }
}

