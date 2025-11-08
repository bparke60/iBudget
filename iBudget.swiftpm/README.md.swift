//
//  README.swift
//  iBudget
//

// --------------------------------------------------------------
//  iBudget: Secure Budgeting App
// --------------------------------------------------------------
//
//  Overview:
//  iBudget is a lightweight SwiftUI budgeting application designed
//  for Swift Playgrounds. It demonstrates secure data handling,
//  biometric authentication, and AES encryption simulation.
//
//  The project was built to showcase practical skills in
//  Swift, app security, and UI/UX — reflecting real FinTech and
//  cybersecurity workflows used by organizations such as Wells Fargo.
//
// --------------------------------------------------------------
//  Key Features
// --------------------------------------------------------------
//
//  • Biometric Login (Face ID / Touch ID) using LocalAuthentication
//  • Expense Tracking with categories, dates, and totals
//  • AES-256 Encryption simulation via CryptoKit
//  • Security Center tab with login-attempt logging
//  • Local data storage (no external network use)
//  • Privacy-focused SwiftUI interface
//
// --------------------------------------------------------------
//  File Overview
// --------------------------------------------------------------
//
//  IBudgetApp.swift
//    → Launches the app and injects the shared BudgetViewModel.
//
//  Models.swift
//    → Defines Expense and LoginAttempt models,
//      manages encryption, and handles app data logic.
//
//  RootView.swift
//    → Main dashboard with biometric unlock, logout,
//      expense list, and navigation layout.
//
//  AddExpenseView.swift
//    → Form sheet for adding new expenses with validation.
//
//  SecurityCenterView.swift
//    → Displays authentication status, failed logins,
//      encryption export info, and security guidance.
//
// --------------------------------------------------------------
//  How To Run
// --------------------------------------------------------------
//
//  1. Open Swift Playgrounds or Xcode → New Playground (App template).
//  2. Add all five Swift files listed above into the same project folder.
//  3. Press “Run My Code” ▶︎ to build and launch iBudget.
//  4. Use Face ID or Touch ID to unlock.
//  5. Add expenses, use filters, and review the Security Center tab.
//
// --------------------------------------------------------------
//  Technologies Used
// --------------------------------------------------------------
//
//  • Swift 5
//  • SwiftUI
//  • LocalAuthentication
//  • CryptoKit
//  • MVVM architecture pattern
//
// --------------------------------------------------------------
//  Developer Notes
// --------------------------------------------------------------
//
//  iBudget is a demonstration project emphasizing secure
//  design, clarity, and real-world banking app principles.
//  It combines cybersecurity awareness with accessible,
//  beginner-friendly SwiftUI engineering.
//
// --------------------------------------------------------------
//  Author
// --------------------------------------------------------------
//
//  Developed by: Brian Parker
//  UNC Charlotte – Computer Science (Cybersecurity Concentration)
//  Contact: bparke60@charlotte.edu
//
