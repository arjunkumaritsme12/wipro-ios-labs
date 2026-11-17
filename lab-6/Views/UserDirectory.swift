
import Foundation

struct UserDirectory {

    // MARK: - Display All Users

    func displayUsers(_ users: [User]) {

        print("\n========== USER DIRECTORY ==========")

        for user in users {

            print("""
            ID: \(user.id)
            Name: \(user.name)
            Email: \(user.email)
            -------------------------------
            """)
        }

        print("Total Users: \(users.count)")
        print("====================================")
    }

    // MARK: - User Detail View

    func displayDetails(_ user: User) {

        print("\n========== USER DETAILS ==========")

        print("ID: \(user.id)")
        print("Name: \(user.name)")
        print("Username: \(user.username)")
        print("Email: \(user.email)")
        print("Phone: \(user.phone)")
        print("Website: \(user.website)")

        print("\nAddress:")
        print("Street: \(user.address.street)")
        print("Suite: \(user.address.suite)")
        print("City: \(user.address.city)")
        print("ZIP: \(user.address.zipcode)")

        print("\nCompany:")
        print("Name: \(user.company.name)")

        print("==================================")
    }

    // MARK: - Search Users

    func searchUsers(
        users: [User],
        query: String
    ) -> [User] {

        return users.filter { user in

            user.name.localizedCaseInsensitiveContains(query) ||
            user.email.localizedCaseInsensitiveContains(query)
        }
    }
}
