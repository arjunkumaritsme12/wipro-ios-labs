
# Lab 6: Build a Network-Driven Directory

## Objective

Build a Swift application that fetches real JSON
data from a public API, decodes it into Swift
models, and displays a searchable user directory.

## API Information

API Name: JSONPlaceholder

Endpoint:
https://jsonplaceholder.typicode.com/users

HTTP Method: GET

Authentication: Not required

## Technologies Used

- Swift
- Foundation
- FoundationNetworking
- URLSession
- URLComponents
- URLRequest
- Codable
- JSONDecoder
- Async/Await

## Project Structure

lab-6/
├── main.swift
├── Models/
│   ├── User.swift
│   └── Address.swift
├── Services/
│   └── UserService.swift
├── Views/
│   └── UserDirectory.swift
├── Tests/
│   └── TestCases.md
└── README.md

## Features

1. Fetch real users from public API.
2. Decode JSON using Codable models.
3. Display user directory.
4. View individual user details.
5. Search by name and email.
6. Refresh directory.
7. Loading and retry handling.
8. Handle invalid URL.
9. Handle HTTP errors.
10. Handle JSON decoding errors.
11. Handle network failures.
12. Handle empty results.

## Architecture

main.swift
    |
    v
UserService.swift
    |
    v
URLSession
    |
    v
JSONDecoder
    |
    v
User.swift / Address.swift
    |
    v
UserDirectory.swift

## Error Handling

The application handles:
- Invalid URL
- HTTP errors
- Invalid server response
- JSON decoding failure
- Empty API results
- Network connectivity failure

## Testing

Refer to Tests/TestCases.md.

## Platform

Windows 10/11
Visual Studio Code
Swift

## Execution

Compile:

swiftc -parse-as-library Models/Address.swift Models/User.swift Services/UserService.swift Views/UserDirectory.swift main.swift -o Lab6.exe

Run:

.\Lab6.exe
