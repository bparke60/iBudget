import SwiftUI
import LocalAuthentication

struct RootView: View {
    @EnvironmentObject var viewModel: BudgetViewModel
    
    @State private var isUnlocked = false
    @State private var authErrorMessage: String?
    @State private var showAddExpense = false
    @State private var selectedCategory: String = "All"
    
    var body: some View {
        TabView {
            NavigationView {
                Group {
                    if isUnlocked {
                        budgetDashboard
                    } else {
                        lockedView
                    }
                }
                .navigationTitle("iBudget")
            }
            .tabItem {
                Label("Dashboard", systemImage: "creditcard.fill")
            }
            
            SecurityCenterView(isUnlocked: isUnlocked)
                .tabItem {
                    Label("Security", systemImage: "shield.checkered")
                }
        }
    }
}

// MARK: - Locked View & Authentication

extension RootView {
    var lockedView: some View {
        VStack(spacing: 24) {
            Image(systemName: "lock.circle.fill")
                .font(.system(size: 80))
            
            Text("Secure Access Required")
                .font(.title2).bold()
            
            Text("Unlock your budget securely with Touch ID or Face ID.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Button(action: authenticate) {
                HStack {
                    Image(systemName: "faceid")
                    Text("Unlock with Biometrics")
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal)
            
            if let authErrorMessage {
                Text(authErrorMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            if !viewModel.failedLogins.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Security Log")
                        .font(.headline)
                    
                    Text("Recent failed login attempts:")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    List(viewModel.failedLogins.suffix(3)) { attempt in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(attempt.reason)
                                .font(.footnote)
                            Text(
                                attempt.date.formatted(
                                    date: .abbreviated,
                                    time: .shortened
                                )
                            )
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        }
                    }
                    .frame(height: 140)
                    .listStyle(.plain)
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) {
            let reason = "We use biometrics to keep your budget data secure."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                        self.authErrorMessage = nil
                    } else {
                        let message = authError?.localizedDescription ?? "Unknown error"
                        self.authErrorMessage = "Authentication failed. Please try again."
                        self.viewModel.recordFailedLogin(reason: message)
                        
                        if self.viewModel.securityStatus == .locked {
                            self.authErrorMessage = "Multiple failed attempts – account temporarily locked."
                        }
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.authErrorMessage = "Biometric authentication not available on this device."
                self.viewModel.recordFailedLogin(reason: "Biometrics unavailable")
            }
        }
    }
}

// MARK: - Budget Dashboard

extension RootView {
    var budgetDashboard: some View {
        VStack(spacing: 0) {
            // Security tip banner
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "exclamationmark.shield.fill")
                    .font(.title3)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Security Tip")
                        .font(.headline)
                    Text("When you are done, log out of the app, especially on shared devices.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
            .background(Color.yellow.opacity(0.15))
            
            // Summary card
            VStack(alignment: .leading, spacing: 8) {
                Text("Total Spent")
                    .font(.callout)
                    .foregroundColor(.secondary)
                Text(viewModel.totalSpent, format: .currency(code: "USD"))
                    .font(.largeTitle).bold()
                
                if viewModel.securityStatus != .normal {
                    HStack(spacing: 8) {
                        Image(systemName: "shield.lefthalf.filled")
                        Text("Security status: \(viewModel.securityStatus.rawValue)")
                    }
                    .font(.footnote)
                    .foregroundColor(.red)
                }
            }
            .padding()
            
            // Category filter chips
            if !viewModel.distinctCategories.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.distinctCategories, id: \.self) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                Text(category)
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(
                                        selectedCategory == category
                                        ? Color.blue.opacity(0.2)
                                        : Color.gray.opacity(0.15)
                                    )
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 4)
                }
            }
            
            // Expense list
            if viewModel.expenses.isEmpty {
                Spacer()
                Text("No expenses yet.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            } else {
                List {
                    ForEach(filteredExpenses()) { expense in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(expense.title)
                                    .font(.headline)
                                Spacer()
                                Text(expense.amount,
                                     format: .currency(code: "USD"))
                                .bold()
                            }
                            
                            HStack {
                                Text(expense.category)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(
                                    expense.date,
                                    format: .dateTime.month().day().year()
                                )
                                .font(.caption)
                                .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.plain)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isUnlocked = false
                } label: {
                    Label("Log Out", systemImage: "lock.fill")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button {
                        viewModel.exportEncryptedExpenses()
                    } label: {
                        Image(systemName: "icloud.and.arrow.up.fill")
                    }
                    
                    Button {
                        showAddExpense = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
        .sheet(isPresented: $showAddExpense) {
            AddExpenseView(isPresented: $showAddExpense)
                .environmentObject(viewModel)
        }
    }
    
    func filteredExpenses() -> [Expense] {
        let sorted = viewModel.expenses.sorted { $0.date > $1.date }
        
        if selectedCategory == "All" {
            return sorted
        } else {
            return sorted.filter { $0.category == selectedCategory }
        }
    }
}
