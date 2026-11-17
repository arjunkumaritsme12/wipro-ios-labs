
import Foundation

@main
struct Lab6 {

    static func main() async {

        // Public API endpoint
        let endpoint =
            "https://jsonplaceholder.typicode.com/users"

        let service = UserService(endpoint: endpoint)
        let directory = UserDirectory()

        var users: [User] = []

        print("====================================")
        print("     LAB 6: USER DIRECTORY")
        print("====================================")

        // MARK: - Loading and Retry

        while users.isEmpty {

            print("\nLoading users from API...")

            do {

                users = try await service.fetchUsers()

                print("\nSUCCESS: \(users.count) users fetched.")

            } catch {

                print("\nERROR: \(error.localizedDescription)")

                print("\n1. Retry")
                print("2. Exit")

                print("Select option: ", terminator: "")

                let choice = readLine() ?? ""

                if choice != "1" {

                    print("Application closed.")
                    return
                }
            }
        }

        // Display directory
        directory.displayUsers(users)

        // MARK: - Main Menu

        while true {

            print("\n========== MAIN MENU ==========")

            print("1. View User Details")
            print("2. Search Users")
            print("3. Refresh Directory")
            print("4. Exit")

            print("Select option: ", terminator: "")

            let choice = readLine() ?? ""

            switch choice {

            case "1":

                print("Enter User ID: ", terminator: "")

                let input = readLine() ?? ""

                if let id = Int(input),
                   let user = users.first(where: { $0.id == id }) {

                    directory.displayDetails(user)

                } else {

                    print("User not found.")
                }

            case "2":

                print("Enter name or email: ", terminator: "")

                let query = readLine() ?? ""

                let results = directory.searchUsers(
                    users: users,
                    query: query
                )

                if results.isEmpty {

                    print("No matching users found.")

                } else {

                    print("\nSearch Results:")
                    directory.displayUsers(results)
                }

            case "3":

                print("\nRefreshing directory...")

                do {

                    let refreshedUsers = try await service.fetchUsers()

                    users = refreshedUsers

                    print("Directory refreshed successfully.")

                    directory.displayUsers(users)

                } catch {

                    print("Refresh failed: \(error.localizedDescription)")
                    print("Previous data is still available.")
                }

            case "4":

                print("\nThank you for using User Directory.")
                return

            default:

                print("Invalid option. Please try again.")
            }
        }
    }
}
