import SwiftUI
import Charts

struct ExpenseChartView: View {
    @EnvironmentObject var expenseManager: ExpenseManager
    
    var body: some View {
        VStack {
            Text("Expenses by Category")
                .font(.largeTitle)
                .padding()
            
            if expenseManager.expenses.isEmpty {
                Text("No expenses available.")
            } else {
                Chart {
                    ForEach(expenseManager.categories, id: \.self) { category in
                        let expensesForCategory = expenseManager.getExpenses(for: category)
                        let totalAmount = expensesForCategory.reduce(0) { $0 + $1.amount }
                        
                        BarMark(
                            x: .value("Category", category),
                            y: .value("Total", totalAmount)
                        )
                        .foregroundStyle(by: .value("Category", category))
                    }
                }
                .frame(height: 300)
            }
        }
        .navigationTitle("Expense Chart")
    }
}

