import SwiftUI

@main
struct IBudgetApp: App {
    @StateObject private var viewModel = BudgetViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewModel)
        }
    }
}
