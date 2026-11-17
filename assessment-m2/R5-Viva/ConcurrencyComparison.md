# R5 – Viva: GCD vs async/await vs Task vs TaskGroup

## GCD
Grand Central Dispatch is Apple's queue-based concurrency API. It schedules work on dispatch queues. It is useful in legacy code and when queue-level control is needed. Example: `DispatchQueue.global().async { ... }`.

## async/await
`async` marks a function that can suspend. `await` marks a call where execution may suspend until the asynchronous result is available. It makes asynchronous code easier to read and reason about.

## Task
A `Task` is an independently scheduled unit of asynchronous work. It can have priority and can be cancelled. Example: `Task { await loadData() }`.

## TaskGroup
A task group runs multiple child tasks within a structured scope. The parent waits for the children, and child task lifetimes are bounded by that scope. Use it for a variable number of concurrent operations.

## Short viva answers
- **Are async functions automatically concurrent?** No. `async` means a function may suspend; concurrency occurs when independent work is started without waiting for the previous operation to finish.
- **What is cancellation?** Cooperative. A task should check cancellation or call cancellation-aware APIs; cancellation is not forced termination.
- **Why use MainActor?** To isolate UI-facing mutable state to the main actor and avoid unsynchronised UI-state mutation.
- **async let vs TaskGroup?** `async let` is convenient for a known, fixed number of child operations. Task groups are better for a dynamic number of child tasks.
- **GCD vs Swift concurrency?** GCD is queue-based; Swift concurrency adds language-level async/await, task lifetimes, cancellation, actors, and structured concurrency.
