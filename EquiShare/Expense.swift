import Foundation

struct Expense: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var participants: [String]
    var category: String
}

