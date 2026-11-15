# Lab 4B: App, Scene, and View Lifecycles

## Overview

This project demonstrates the lifecycle events of an iOS application using SwiftUI.

The objective is to understand App, Scene, and View lifecycle callbacks, observe their execution during navigation, and avoid placing unrelated operations inside lifecycle methods.

## Objectives

- Understand application and scene lifecycle events.
- Implement view appearance and disappearance logging.
- Navigate between two screens.
- Observe repeated view lifecycle callbacks.
- Perform lightweight data refresh at an appropriate lifecycle point.

## Application Features

- Home Screen with navigation.
- Detail Screen with back navigation.
- App and Scene lifecycle logging.
- View appearance and disappearance logging.
- Lightweight Home screen refresh.
- Optional draft persistence using @AppStorage.

## Project Structure

```text
Lab-4B/
├── App/
│   └── LifecycleDemoApp.swift
├── Views/
│   ├── HomeView.swift
│   └── DetailView.swift
├── Services/
│   └── RefreshService.swift
├── Screenshots/
│   ├── home-screen.png
│   └── detail-screen.png
└── README.md
```

## Lifecycle Implementation

### 1. App Lifecycle

The application initialization event is recorded using the SwiftUI App initializer.

### 2. Scene Lifecycle

The scenePhase environment property tracks the following states:

- Active
- Inactive
- Background

### 3. View Lifecycle

The following callbacks are used:

- onAppear: Logs when a screen becomes visible.
- onDisappear: Logs when a screen disappears.

### 4. Navigation Testing

The application contains two screens:

- Home Screen
- Detail Screen

Navigation between these screens is used to observe lifecycle events.

## Sample Event Log

### Application Launch

APP: Application Initialized

SCENE: Application became ACTIVE

VIEW: HomeView appeared

REFRESH: Home data refreshed

### Navigate to Detail Screen

VIEW: HomeView disappeared

VIEW: DetailView appeared

### Return to Home Screen

VIEW: DetailView disappeared

VIEW: HomeView appeared

REFRESH: Home data refreshed

### Background Application

SCENE: Application became INACTIVE

SCENE: Application entered BACKGROUND

## Lifecycle Observations

1. App initialization generally happens once per application process.
2. Scene lifecycle changes depend on the application's foreground and background state.
3. View appearance and disappearance callbacks can execute multiple times.
4. Returning to the Home Screen triggers its onAppear callback again.
5. Lightweight refresh operations are appropriate when a screen appears.

## Refresh Strategy

A lightweight refresh operation is implemented inside the Home Screen's onAppear callback.

This ensures that Home screen information is refreshed whenever the user returns to the screen.

Heavy operations and unrelated business logic should not be placed directly inside lifecycle callbacks.

## Screenshots

### Home Screen

Add the actual Home screen screenshot here.

### Detail Screen

Add the actual Detail screen screenshot here.

## Conclusion

This lab demonstrates the differences between App, Scene, and View lifecycle events in SwiftUI.

It also demonstrates that views can appear and disappear repeatedly during navigation.

Using appropriate lifecycle callbacks helps maintain clean application architecture and prevents unnecessary operations.

## Technologies Used

- Swift
- SwiftUI
- Foundation
- UserDefaults
- Xcode

**Lab:** 4B – App, Scene, and View Lifecycles

**Objective:** Lifecycle Management and Navigation