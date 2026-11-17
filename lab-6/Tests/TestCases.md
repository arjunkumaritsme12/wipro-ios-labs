
# Lab 6 - Test Cases

API: https://jsonplaceholder.typicode.com/users

## TC01 - Successful API Request

Endpoint:
https://jsonplaceholder.typicode.com/users

Expected:
- HTTP status 200
- JSON decoded successfully
- 10 users displayed

Result: PASS (after successful execution)

## TC02 - Empty Results

Endpoint:
https://jsonplaceholder.typicode.com/users?username=no-such-user-12345

Expected:
- HTTP status 200
- Empty array received
- "No users found" error displayed

Result: To be tested

## TC03 - HTTP Error

Endpoint:
https://jsonplaceholder.typicode.com/invalid-endpoint

Expected:
- HTTP status 404
- HTTP Error: 404 displayed

Result: To be tested

## TC04 - JSON Decoding Failure

Endpoint:
https://jsonplaceholder.typicode.com/users/1

Expected:
- API returns a single JSON object
- Application expects an array
- Decoding failure displayed

Result: To be tested

## TC05 - Network Failure

Endpoint:
https://this-domain-does-not-exist.invalid/users

Expected:
- Network request fails
- Network error displayed
- Retry option available

Result: To be tested

## TC06 - Invalid URL

Endpoint:
not-a-valid-url

Expected:
- URL validation fails
- Invalid API URL displayed

Result: To be tested
