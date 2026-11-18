
# Lab 9: Project Configuration Audit

## Objective
Understand common Xcode target settings and configure application metadata safely.

## Requirements Completed

### R1: Project Configuration
Inspected project targets, bundle identifier, version, build number, deployment target, signing and supported orientations.

### R2: Info and Privacy
Reviewed Info properties and privacy usage descriptions. No sensitive permission is required by this application.

### R3: Application Feature
Implemented a Configuration Audit screen that displays application metadata using Bundle.main.

### R4: Permission Handling
The application does not request sensitive permissions, so no permission prompt is required.

### R5: Configuration Scope
Documented project-level, target-level and build-configuration settings.

## Debug and Release

Debug:
- Used for development and testing.
- Usually uses lower optimization.
- Supports debugging.

Release:
- Used for production builds.
- Uses optimized compilation.
- Configured for distribution.

## Security
- No certificates committed.
- No private keys committed.
- No passwords or API secrets committed.
- Signing credentials remain managed locally by Xcode.

## Screenshots
1. General target settings.
2. Signing configuration.
3. Info properties.
4. Running application.

## Technologies
- Swift
- SwiftUI
- Xcode
- Bundle metadata
