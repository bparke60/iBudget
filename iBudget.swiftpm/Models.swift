import Foundation
import SwiftUI
import CryptoKit

// MARK: - Data Models

struct Expense: Identifiable, Codable {
    let id: UUID
    var title: String
    var category: String
    var amount: Double
    var date: Date
    
    init(id: UUID = UUID(),
         title: String,
         category: String,
         amount: Double,
         date: Date) {
        self.id = id
        self.title = title
        self.category = category
        self.amount = amount
        self.date = date
    }
}

struct LoginAttempt: Identifiable {
    let id = UUID()
    let date: Date
    let reason: String
}

enum SecurityStatus: String {
    case normal = "Normal"
    case watch = "Watch"
    case locked = "Locked"
}

// MARK: - Encryption Helper

struct SecureStorage {
    static func encrypt(_ data: Data, key: SymmetricKey) -> Data? {
        do {
            let sealed = try AES.GCM.seal(data, using: key)
            return sealed.combined
        } catch {
            print("Encryption error: \(error)")
            return nil
        }
    }
    
    static func decrypt(_ data: Data, key: SymmetricKey) -> Data? {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            return try AES.GCM.open(sealedBox, using: key)
        } catch {
            print("Decryption error: \(error)")
            return nil
        }
    }
}

// MARK: - ViewModel

final class BudgetViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var failedLogins: [LoginAttempt] = []
    @Published var encryptedExport: Data?
    
    let encryptionKey = SymmetricKey(size: .bits256)
    
    var totalSpent: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    var distinctCategories: [String] {
        guard !expenses.isEmpty else { return [] }
        let categories = Set(expenses.map { $0.category })
        return ["All"] + categories.sorted()
    }
    
    @discardableResult
    func addExpense(title: String,
                    category: String,
                    amountString: String,
                    date: Date) -> Bool {
        guard let amount = Double(amountString),
              amount > 0 else {
            return false
        }
        
        let safeTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let safeCategory = category.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let expense = Expense(
            title: safeTitle.isEmpty ? "Untitled" : safeTitle,
            category: safeCategory.isEmpty ? "General" : safeCategory,
            amount: amount,
            date: date
        )
        
        expenses.append(expense)
        return true
    }
    
    func recordFailedLogin(reason: String) {
        let attempt = LoginAttempt(date: Date(), reason: reason)
        failedLogins.append(attempt)
    }
    
    var securityStatus: SecurityStatus {
        if failedLogins.count >= 5 {
            return .locked
        } else if failedLogins.count >= 3 {
            return .watch
        } else {
            return .normal
        }
    }
    
    func exportEncryptedExpenses() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(expenses)
            
            if let encrypted = SecureStorage.encrypt(data, key: encryptionKey) {
                encryptedExport = encrypted
                print("Secure export created (\(encrypted.count) bytes).")
                print("This simulates sending encrypted data to a cloud endpoint.")
            }
        } catch {
            print("Export error: \(error)")
        }
    }
}
