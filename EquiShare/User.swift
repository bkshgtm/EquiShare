import Foundation

struct User: Identifiable {
    var id = UUID()
    var name: String
    var balance: Double = 0
    var totalSpent: Double = 0
    var expenses: [Expense] = []
}

