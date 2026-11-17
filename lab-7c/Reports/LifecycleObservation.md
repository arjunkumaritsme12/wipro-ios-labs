# Lab 7C - Lifecycle Observation Report

## Objective

To understand UIKit view controller lifecycle methods
and connect UI controls with application state.

## 1. Lifecycle Methods

### viewDidLoad()
Called once when the view controller's view is loaded.

Used for:
- Initial UI setup
- Adding controls
- Setting Auto Layout constraints
- Registering event handlers

### viewWillAppear()
Called before the view becomes visible.

Used for:
- Refreshing summary information
- Updating information when returning from another screen
- Checking current application state

### viewDidAppear()
Called after the view becomes visible.

Used for:
- Starting animations
- Starting visible-screen activities
- Displaying user-facing content

### viewWillDisappear()
Called before the view disappears.

Used for:
- Preparing to leave the screen
- Dismissing temporary UI
- Pausing screen-specific activities

### viewDidDisappear()
Called after the view disappears.

Used for:
- Stopping screen-specific activities
- Cleaning up temporary resources

## 2. Lifecycle Observation

When the application launches:

Lifecycle: viewDidLoad
Lifecycle: viewWillAppear
Lifecycle: viewDidAppear

When opening the second screen:

Lifecycle: viewWillDisappear
Demo Screen: viewDidLoad
Demo Screen: viewWillAppear
Demo Screen: viewDidAppear
Lifecycle: viewDidDisappear

When returning to the first screen:

Demo Screen: viewWillDisappear
Lifecycle: viewWillAppear
Demo Screen: viewDidDisappear
Lifecycle: viewDidAppear

Note: Exact console ordering can vary slightly
with UIKit transition timing.

## 3. viewDidLoad vs viewWillAppear

viewDidLoad is suitable for one-time setup.

viewWillAppear is suitable for refreshing information
whenever the screen becomes visible again.

For example, the application creates its controls
in viewDidLoad and refreshes the summary in
viewWillAppear.

## 4. Keyboard Observation

When the user taps the name input field:

- Keyboard appears.
- ScrollView bottom inset increases.
- The form remains scrollable.
- User can dismiss the keyboard by tapping outside.

When the keyboard disappears:

- Bottom inset resets to zero.
- Original layout is restored.

## 5. Conclusion

The application successfully demonstrates UIKit
controls, state updates, navigation and view
controller lifecycle methods.