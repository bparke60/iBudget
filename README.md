# iBudget
A Swift Playgrounds app showcasing secure budgeting, encryption, and biometric authentication.

# iBudget – SwiftUI Secure Budgeting App

**iBudget** is a Swift Playgrounds project built with **SwiftUI**, designed to demonstrate secure budgeting features and modern iOS development practices.  
It simulates the type of privacy-first experience found in FinTech and cybersecurity-focused applications.

---

## Overview

iBudget helps users manage expenses securely, using biometric authentication and simulated AES-256 encryption to reinforce secure coding concepts.  
The project highlights principles of data protection, user authentication, and secure design—aligned with technologies used in enterprise financial systems.

---

## Features

- Face ID / Touch ID authentication using `LocalAuthentication`
- Expense tracking with category-based organization and input validation
- AES-256 encryption simulation using Apple’s `CryptoKit`
- Security Center dashboard with login logs and protection tips
- Privacy mode for hiding totals and category data
- Session timeout feature that locks the app after inactivity

---

## Project Structure

| File | Description |
|------|--------------|
| **IBudgetApp.swift** | Entry point that initializes the shared `BudgetViewModel` |
| **Models.swift** | Contains `Expense`, `LoginAttempt`, and encryption helpers |
| **RootView.swift** | Main biometric login and expense dashboard |
| **AddExpenseView.swift** | Secure form for adding new expenses |
| **SecurityCenterView.swift** | Displays security status, failed logins, and data protection info |
| **README.swift** | In-Playgrounds summary reference |

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
2. Ensure all `.swift` files are included in the same Swift package or Playground  
3. Press **Run My Code**  
4. Authenticate using Face ID or Touch ID  
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
B.S. Computer Science – Cybersecurity Concentration  
bparke60@charlotte.edu  

---

## License

This project is shared for educational and portfolio purposes.  
You may reference or adapt portions for personal learning projects.
