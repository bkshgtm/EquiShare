import SwiftUI

@main
struct EquiShareApp: App {
    @StateObject private var expenseManager = ExpenseManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(expenseManager) // Provide ExpenseManager to the environment
        }
    }
}

