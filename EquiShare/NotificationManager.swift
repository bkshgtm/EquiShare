import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() { }
    
    func scheduleNotification(for expense: Expense) {
        let content = UNMutableNotificationContent()
        content.title = "New Expense Added"
        content.body = "Expense '\(expense.name)' of $\(String(format: "%.2f", expense.amount)) added to category \(expense.category)."
        
        // Create a notification request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        
        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            }
        }
    }
}

