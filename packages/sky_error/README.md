# sky_error

Standardized Result and Failure types for Sky Core applications.

## Usage

```dart
Result<User, Failure> getUser() {
  try {
    return Success(user);
  } catch (e) {
    return Failure(ServerFailure());
  }
}
```
