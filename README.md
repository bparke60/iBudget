# iBudget – SwiftUI Secure Budgeting App

> A Swift Playgrounds project demonstrating secure budgeting, biometric authentication, and AES-256 encryption using Apple's native frameworks.

---

## Overview

iBudget helps users manage expenses securely, using biometric authentication and simulated AES-256 encryption to reinforce secure coding concepts.
The project highlights principles of data protection, user authentication, and secure design — aligned with technologies used in enterprise financial systems.

---

## Features

- Face ID / Touch ID authentication using `LocalAuthentication`
- Expense tracking with category-based filtering and input validation
- AES-256 encryption simulation using Apple's `CryptoKit`
- Security Center dashboard with login activity logs and data protection info
- Automatic lockout after multiple failed authentication attempts
- Log out button to end session manually

---

## Project Structure

| File | Description |
|------|-------------|
| **IBudgetApp.swift** | Entry point that initializes the shared `BudgetViewModel` |
| **Models.swift** | Contains `Expense`, `LoginAttempt`, encryption helpers, and `BudgetViewModel` |
| **RootView.swift** | Main biometric login screen and expense dashboard |
| **AddExpenseView.swift** | Secure form for adding new expenses with validation |
| **SecurityCenterView.swift** | Displays security status, failed login logs, and data protection info |

---

## Technologies Used

- Swift 5
- SwiftUI
- LocalAuthentication
- CryptoKit
- MVVM Architecture

---

## How to Run

1. Open the project in **Swift Playgrounds (Mac)** or **Xcode**
2. Ensure all `.swift` files are included in the same Swift package
3. Press **Run**
4. Tap **Unlock with Biometrics** and authenticate with Face ID or Touch ID
5. Add expenses and explore the Security Center tab

---

## Learning Focus

This project demonstrates:
- Integration of cybersecurity principles into iOS app development
- Implementation of Apple frameworks such as `CryptoKit` and `LocalAuthentication`
- Clean MVVM architecture with SwiftUI
- Secure and user-focused design for financial data handling

---

## Author

**Brian Parker**
University of North Carolina at Charlotte
B.S. Artificial Intelligence – Machine Learning Concentration
bparke60@charlotte.edu

---

## License

This project is shared for educational and portfolio purposes.
You may reference or adapt portions for personal learning projects.
