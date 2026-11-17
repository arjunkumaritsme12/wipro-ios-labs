
import Foundation
import Dispatch

let group = DispatchGroup()

let backgroundQueue = DispatchQueue(
    label: "com.lab5a.background",
    qos: .userInitiated,
    attributes: .concurrent
)

let mainQueue = DispatchQueue.main

func log(_ message: String) {
    let thread = Thread.isMainThread ? "Main Thread" : "Background Thread"
    print("[\(thread)] \(message)")
}

print("===== LAB 5A: GCD DEMO =====")

log("Application started")

var isLoading = false

func startOperation() {

    guard !isLoading else {
        print("Duplicate submission prevented")
        return
    }

    isLoading = true

    log("Loading started")
    print("Button disabled")

    group.enter()

    backgroundQueue.async {

        log("Background operation started")

        // R1: Simulate slow operation
        Thread.sleep(forTimeInterval: 3)

        let result = "Operation completed successfully!"

        log("Background operation completed")

        // R3: Delayed response
        mainQueue.asyncAfter(deadline: .now() + 1) {

            log("UI update on main queue")

            print("Result: \(result)")
            print("Loading stopped")
            print("Button enabled")

            isLoading = false

            group.leave()
        }
    }
}

startOperation()

// Keep the command-line application alive until work finishes
group.wait()

log("Application finished")
