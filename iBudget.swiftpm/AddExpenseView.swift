import SwiftUI

struct AddExpenseView: View {
    @EnvironmentObject var viewModel: BudgetViewModel
    @Binding var isPresented: Bool
    
    @State private var title: String = ""
    @State private var category: String = ""
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var showValidationError = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Title (e.g. Groceries)", text: $title)
                    TextField("Category (e.g. Food)", text: $category)
                }
                
                Section("Amount") {
                    TextField("Amount in USD", text: $amount)
                        .keyboardType(.decimalPad)
                }
                
                Section("Date") {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                if showValidationError {
                    Section {
                        Text("Please enter a valid positive amount.")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("New Expense")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let success = viewModel.addExpense(
                            title: title,
                            category: category,
                            amountString: amount,
                            date: date
                        )
                        if success {
                            isPresented = false
                        } else {
                            showValidationError = true
                        }
                    }
                }
            }
        }
    }
}
