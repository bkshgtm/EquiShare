import SwiftUI

struct ExpenseChartView: View {
    @EnvironmentObject var expenseManager: ExpenseManager // Access ExpenseManager

    var body: some View {
        VStack {
            Text("Expense Distribution")
                .font(.largeTitle)
                .padding()

            // Check if there are any expenses to show
            if expenseManager.expenses.isEmpty {
                Text("No expenses available")
                    .font(.headline)
                    .padding()
            } else {
                // Call a function to generate chart data
                ChartView(data: generateChartData())
                    .padding()
            }
        }
        .padding()
        .navigationTitle("Expense Chart")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Function to generate chart data
    private func generateChartData() -> [ExpenseChartData] {
        var chartData: [ExpenseChartData] = []

        // Group expenses by category
        let groupedExpenses = Dictionary(grouping: expenseManager.expenses, by: { $0.category })
        
        for (category, expenses) in groupedExpenses {
            let totalAmount = expenses.reduce(0) { $0 + $1.amount }
            chartData.append(ExpenseChartData(category: category, amount: totalAmount))
        }

        return chartData
    }
}

// Sample data structure for chart data
struct ExpenseChartData {
    let category: String
    let amount: Double
}

// Dummy ChartView for demonstration (replace with your actual charting implementation)
struct ChartView: View {
    let data: [ExpenseChartData]

    var body: some View {
        BarChartView(data: data)
    }
}

// Dummy BarChartView for demonstration (replace with your actual charting implementation)
struct BarChartView: View {
    let data: [ExpenseChartData]

    var body: some View {
        VStack {
            ForEach(data, id: \.category) { entry in
                HStack {
                    Text(entry.category)
                    Spacer()
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: CGFloat(entry.amount) * 10, height: 20) // Adjust scale as necessary
                    Text("\(entry.amount, specifier: "%.2f")")
                }
                .padding(2)
            }
        }
    }
}

