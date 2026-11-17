# Lab 7B - Storyboards, View Hierarchy and Navigation

## Objective
Build a two-screen UIKit application demonstrating
view hierarchy and screen navigation.

## Features

- Course List Screen
- Course Detail Screen
- UITableView implementation
- Custom reusable UITableViewCell
- Navigation Controller
- Push and Pop navigation
- Selected model object passing
- Empty state handling
- Auto Layout constraints
- Dynamic Type support
- Dark Mode support

## Technologies

- Swift
- UIKit
- UIViewController
- UITableView
- UINavigationController
- Auto Layout

## Navigation Flow

App Launch
    |
Navigation Controller
    |
Course List Screen
    |
Select Course
    |
Course Detail Screen
    |
Back Button
    |
Course List Screen

## View Hierarchy

UIWindow
    |
UINavigationController
    |
CourseListViewController
    |
UIView
    |
UITableView

Second Screen:

UINavigationController
    |
CourseDetailViewController
    |
UIView
    |
UIStackView
    |
UILabels

## Model Passing

The selected Course object is passed through
the CourseDetailViewController initializer.

No global variables are used.

## Testing

1. Launch application.
2. Verify all four courses appear.
3. Select Swift Programming.
4. Verify correct course details.
5. Press Back.
6. Select another course.
7. Verify the correct details again.
8. Test portrait orientation.
9. Verify empty state implementation.