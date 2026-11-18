
# Lab 10A: XCTest Unit Tests

## Objective
Write automated tests for application logic independently from the UI.

## Requirements Completed

### R1: XCTest Target
Created CourseExplorerTests as a separate Unit Testing Bundle.

### R2: Logic Testing
- Tested grade calculation.
- Tested registration form validation.
- Tested CourseViewModel.loadCourses().

### R3: Test Coverage
Included:
- Normal inputs.
- Boundary values.
- Empty inputs.
- Invalid email and phone numbers.
- Failed service response.
- Empty service response.

### R4: Test Quality
Used descriptive test method names and meaningful XCTest assertions.

### R5: Mock Service
Created MockCourseService implementing CourseService.
Tests use predetermined success and failure responses.
No live API or network connection is required.

## Test Summary
Total test methods: 15

- Grade calculation: 4
- Registration validation: 8
- ViewModel: 3

## Technologies
- Swift
- XCTest
- Foundation
- Async/Await

## Test Execution
Open the project in Xcode and press Command + U.

## Security
No certificates, private keys or credentials are included.
