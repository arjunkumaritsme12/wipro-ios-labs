
import Foundation

print("===== Bank Account Management =====")

guard let account = BankAccount(
    accountHolder: "Arjun Kumar",
    openingBalance: 1000
) else {
    print("Invalid Account Setup")
    exit(1)
}

print("\n===== Account Details =====")
print(account.accountDetails())

print("\n===== Deposit Operations =====")

print("Deposit 500: \(account.deposit(500))")
print("Deposit 0: \(account.deposit(0))")
print("Deposit -100: \(account.deposit(-100))")

print("\n===== Withdrawal Operations =====")

print("Withdraw 200: \(account.withdraw(200))")
print("Withdraw 2000: \(account.withdraw(2000))")
print("Withdraw -50: \(account.withdraw(-50))")

print("\n===== Final Account Balance =====")
print("Balance: \(account.currentBalance)")

print("\n===== Account Validation =====")

let invalidAccount1 = BankAccount(
    accountHolder: "",
    openingBalance: 500
)

let invalidAccount2 = BankAccount(
    accountHolder: "Arjun Kumar",
    openingBalance: -500
)

print("Empty Account Holder: \(invalidAccount1 == nil ? "Rejected" : "Accepted")")
print("Negative Opening Balance: \(invalidAccount2 == nil ? "Rejected" : "Accepted")")

print("\n===== Transaction History =====")

for transaction in account.transactionHistory {
    print(transaction)
}

print("\n===== Internal Access Demo =====")
print(internalAccessExample())

print("\n===== Program Completed =====")
