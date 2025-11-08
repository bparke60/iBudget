import SwiftUI

struct SecurityCenterView: View {
    @EnvironmentObject var viewModel: BudgetViewModel
    let isUnlocked: Bool
    
    var body: some View {
        NavigationView {
            List {
                statusSection
                loginActivitySection
                dataProtectionSection
                usageTipsSection
            }
            .navigationTitle("Security Center")
        }
    }
    
    // MARK: - Sections
    
    private var statusSection: some View {
        Section("Status") {
            HStack {
                Text("Authentication")
                Spacer()
                Text(isUnlocked ? "Unlocked" : "Locked")
                    .foregroundColor(isUnlocked ? .green : .secondary)
            }
            
            HStack {
                Text("Security Level")
                Spacer()
                Text(viewModel.securityStatus.rawValue)
                    .foregroundColor(colorForStatus())
            }
            
            HStack {
                Text("Failed Login Attempts")
                Spacer()
                Text("\(viewModel.failedLogins.count)")
            }
        }
    }
    
    private var loginActivitySection: some View {
        Section("Recent Login Activity") {
            if viewModel.failedLogins.isEmpty {
                Text("No failed logins recorded.")
                    .foregroundColor(.secondary)
            } else {
                ForEach(viewModel.failedLogins.suffix(5)) { attempt in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(attempt.reason)
                            .font(.subheadline)
                        Text(
                            attempt.date.formatted(
                                date: .abbreviated,
                                time: .shortened
                            )
                        )
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            }
        }
    }
    
    private var dataProtectionSection: some View {
        Section("Data Protection") {
            Text("Expenses are exported using AES-256 authenticated encryption before being sent (simulated) to a cloud endpoint.")
                .font(.footnote)
            
            if let encrypted = viewModel.encryptedExport {
                Text("Last secure export size: \(encrypted.count) bytes")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            } else {
                Text("No secure export performed yet.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var usageTipsSection: some View {
        Section("Secure Usage Tips") {
            Text("Log out when you are done, especially on shared devices.")
            Text("Avoid storing real account numbers or credentials in plain text.")
            Text("Review login activity regularly for unusual patterns.")
        }
    }
    
    // MARK: - Helpers
    
    private func colorForStatus() -> Color {
        switch viewModel.securityStatus {
        case .normal:
            return .green
        case .watch:
            return .orange
        case .locked:
            return .red
        }
    }
}
