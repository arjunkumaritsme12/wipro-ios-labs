# Milestone 2 – Architecture and Concurrency (Windows Swift)

This Swift Package demonstrates the five requested assessment outcomes using Swift Package Manager. It is designed to compile and run with the Swift toolchain on Windows and does not require Xcode.

## Requirements covered

### R1 – MVVM and ViewModel tests
- `TaskItem` is the Model.
- `TaskViewModel` owns task-list state and exposes add, toggle, and delete operations.
- A UI can observe/read the ViewModel's state and call its methods. The ViewModel does not depend on a particular UI framework.
- XCTest tests cover adding, trimming, ignoring empty titles, toggling completion, and deleting.

**Architecture:** View → TaskViewModel → TaskItem. The View sends user actions to the ViewModel; the ViewModel updates Model state; the View renders the updated state.

### R2 – Concurrent independent data sources
`DashboardRepository.fetchDashboard()` uses `async let` to start user and task requests independently, then awaits and combines both results in `DashboardData`. Since both operations can progress at the same time, total waiting time is approximately the slower request rather than the sum of both request times (ignoring overhead).

### R3 – Loading, success, error, cancellation
`LoadState` represents `idle`, `loading`, `success`, `failure`, and `cancelled`. `DashboardViewModel.load()` publishes loading before starting work, then publishes success or failure. `cancel()` cancels the active Swift Task and updates the state to cancelled.

### R4 – Why UI updates belong on MainActor
UI frameworks generally require UI-facing state changes on the main thread/main actor. `@MainActor` provides actor isolation: access to the annotated object's mutable state is serialized through the main actor, avoiding unsynchronised concurrent mutation and keeping UI state changes on the UI executor. It is a compile-time concurrency guarantee, not merely a naming convention. Do not block the main actor with long-running work; perform asynchronous work away from UI updates and return to the main actor to publish results.

### R5 – Viva comparison
| Concept | Meaning | Typical use |
|---|---|---|
| GCD | Grand Central Dispatch; queue-based API (`DispatchQueue`, groups, semaphores) | Existing callback/queue-based code and lower-level scheduling |
| async/await | Language syntax for writing asynchronous functions in a sequential style | Awaiting network, file, or other asynchronous operations |
| Task | A unit of asynchronous work with a lifetime, priority, and cancellation | Starting an async operation from synchronous or UI code |
| Task group | Structured-concurrency scope that manages multiple child tasks | Dynamically creating and collecting several concurrent operations |

**Key distinction:** `async` marks a function that can suspend; `await` marks a suspension point; `Task {}` creates asynchronous work; `withTaskGroup` creates a scope for related child tasks; GCD schedules work on dispatch queues and is not itself Swift's structured-concurrency model.

## Run on Windows

Open PowerShell in this folder:

```powershell
swift --version
swift build
swift test
swift run Milestone2Demo
```

If `swift` is not recognised, install/configure the official Swift toolchain for Windows and reopen the terminal so PATH is refreshed.

## Assessment / platform note

This repository contains a testable MVVM ViewModel and a console demonstration of the architecture and concurrency concepts. It does **not** claim to be a compiled SwiftUI/iOS screen. SwiftUI, UIKit, Xcode, and the iOS Simulator require Apple's macOS development environment. If the assessor specifically requires a rendered iOS task-list screen, open the same architecture in an Xcode SwiftUI app on a Mac or an approved macOS CI environment.

## Suggested submission evidence
1. `swift build` successful output.
2. `swift test` successful output showing all tests passing.
3. `swift run Milestone2Demo` output.
4. Git commit containing the complete `Milestone2` folder.
