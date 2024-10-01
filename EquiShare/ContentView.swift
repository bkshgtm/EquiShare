import SwiftUI
import AVFAudio

struct ContentView: View {
    @StateObject private var expenseManager = ExpenseManager()
    @State private var newExpenseName = ""
    @State private var newExpenseAmount = ""
    @State private var selectedUsers = Set<String>()
    @State private var newUser = ""
    @State private var showChart = false
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                // Dark Mode Toggle
                HStack {
                    Spacer()
                    Button(action: toggleDarkMode) {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                }
                
                // Add User Section
                HStack {
                    TextField("Add User", text: $newUser)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: addUser) {
                        Text("Add")
                            .padding()
                            .background(Color.buttonColor)
                            .foregroundColor(Color.buttonTextColor)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
                .padding()
                
                // List of Users
                List(expenseManager.users) { user in
                    HStack {
                        Text(user.name)
                        Spacer()
                        Text("$\(user.balance, specifier: "%.2f")")
                    }
                    .background(Color.expenseListBackground)
                }
                .listStyle(PlainListStyle())
                
                // Add Expense Section
                Form {
                    TextField("Expense Name", text: $newExpenseName)
                    TextField("Expense Amount", text: $newExpenseAmount)
                        .keyboardType(.decimalPad)
                    
                    // Select Users
                    Section(header: Text("Select Participants")) {
                        ForEach(expenseManager.users, id: \.id) { user in
                            MultipleSelectionRow(title: user.name, isSelected: selectedUsers.contains(user.name)) {
                                toggleSelection(for: user.name)
                            }
                        }
                    }
                    
                    // Add Expense Button
                    Button(action: addExpense) {
                        Text("Add Expense")
                            .padding()
                            .background(Color.buttonColor)
                            .foregroundColor(Color.buttonTextColor)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
                
                Spacer()
                
                // Show Total Balance
                Text("Total Balance: $\(expenseManager.totalBalance(), specifier: "%.2f")")
                    .font(.title)
                    .padding()
                
                // Show Chart Button
                NavigationLink("View Chart") {
                    ExpenseChartView()
                        .environmentObject(expenseManager) // Pass ExpenseManager here
                }
                .padding()
                .background(Color.buttonColor)
                .foregroundColor(Color.buttonTextColor)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .navigationTitle("Expense Manager")
            .background(Color.primaryBackground)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }

    private func addUser() {
        playSound()
        expenseManager.addUser(name: newUser)
        newUser = ""
    }

    private func addExpense() {
        playSound()
        if let amount = Double(newExpenseAmount), !selectedUsers.isEmpty {
            withAnimation(.easeInOut(duration: 0.3)) {
                expenseManager.addExpense(name: newExpenseName, amount: amount, participants: Array(selectedUsers), category: "General")
                newExpenseName = ""
                newExpenseAmount = ""
                selectedUsers.removeAll()
            }
        }
    }

    private func toggleSelection(for userName: String) {
        if selectedUsers.contains(userName) {
            selectedUsers.remove(userName)
        } else {
            selectedUsers.insert(userName)
        }
    }

    private func toggleDarkMode() {
        isDarkMode.toggle()
    }

    private func playSound() {
        guard let url = Bundle.main.url(forResource: "click", withExtension: "wav") else { return }
        let player = try? AVAudioPlayer(contentsOf: url)
        player?.play()
    }
}

