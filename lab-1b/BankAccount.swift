
import Foundation

public final class BankAccount {

    private var balance: Double
    private let accountHolder: String

    fileprivate static let bankCode = "WIPRO-001"

    public private(set) var transactionHistory: [String] = []

    public var currentBalance: Double {
        return balance
    }

    public init?(accountHolder: String, openingBalance: Double = 0) {

        guard !accountHolder.trimmingCharacters(in: .whitespaces).isEmpty,
              openingBalance.isFinite,
              openingBalance >= 0 else {
            return nil
        }

        self.accountHolder = accountHolder
        self.balance = openingBalance

        transactionHistory.append("Account opened with balance: \(openingBalance)")
    }

    public func deposit(_ amount: Double) -> Bool {

        guard amount.isFinite, amount > 0 else {
            return false
        }

        balance += amount
        transactionHistory.append("Deposited: \(amount)")

        return true
    }

    public func withdraw(_ amount: Double) -> Bool {

        guard amount.isFinite, amount > 0, amount <= balance else {
            return false
        }

        balance -= amount
        transactionHistory.append("Withdrawn: \(amount)")

        return true
    }

    public func accountDetails() -> String {

        return """
        Account Holder: \(accountHolder)
        Bank Code: \(Self.bankCode)
        Current Balance: \(balance)
        """
    }
}

internal func internalAccessExample() -> String {
    return "Internal access is working successfully."
}
