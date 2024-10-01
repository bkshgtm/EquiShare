import SwiftUI

struct UserProfileView: View {
    var user: User

    var body: some View {
        VStack {
            Text(user.name)
                .font(.largeTitle)
                .padding()

            Text("Total Spent: $\(user.totalSpent, specifier: "%.2f")")
                .padding()

            Text("Balance: $\(user.balance, specifier: "%.2f")")
                .padding()

            List(user.expenses) { expense in
                HStack {
                    Text(expense.name)
                    Spacer()
                    Text("$\(expense.amount, specifier: "%.2f")")
                }
            }
        }
        .navigationTitle(user.name)
    }
}

