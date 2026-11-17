Navigation explanation:
- Navigation Controller manages the screen stack.
- Course List is the root view controller.
- Selecting a course creates a new detail controller.
- The selected Course object is passed through init(course:).
- pushViewController() opens the detail screen.
- Back button automatically pops the detail screen.