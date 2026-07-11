---
name: sky-network
description: Guidelines on HTTP network calls and ApiCallHandler
---

# sky_network Guidelines

Defines standard network clients and handlers for REST operations.

## Guidelines & Checklists

### 1. Dio Setup and DI Registration
* All dependency injection modules registering `Dio` instances must utilize `DioFactory` and `DioFactoryImpl`:
  ```dart
  @lazySingleton
  DioFactory get dioFactory => const DioFactoryImpl();
  ```
* Base request rules, logging settings, and global headers must be configured using `NetworkOptions`.
* Register `Dio` with necessary interceptors (e.g. auth interceptor) using `dioFactory.create(...)`.

### 2. Retrofit Api Clients
* Retrofit api client files must use the `@RestApi` annotation and be registered as `@lazySingleton`.
* Pass the `Dio` instance to the generated constructor.
* Example:
  ```dart
  @lazySingleton
  @RestApi(baseUrl: '/v1/users')
  abstract class AuthApiClient {
    @factoryMethod
    factory AuthApiClient(Dio dio) = _AuthApiClient;

    @POST('/')
    Future<UserModel> createUser(@Body() CreateUserRequestModel request);

    @GET('/me')
    Future<UserModel> getMe();
  }
  ```

### 3. ApiCallHandler Exception Mapping
* Always wrap remote data source endpoint calls with `ApiCallHandler.handle()` to map raw network exceptions (e.g., `DioException`) to `Failure` instances automatically.
* In repositories:
  ```dart
  @override
  FutureEitherFailure<UserModel> loginWithEmail(...) {
    return _apiCallHandler.handle(
      () => _remoteDataSource.login(...),
    );
  }
  ```

### 4. Interceptors
* Use `AuthInterceptor` to handle bearer authentication tokens, session enrichments, and dynamic token refreshing.
* Use `RetryInterceptor` with the dedicated `retryDio` instance (registered as `@Named('retryDio')`) for refresh-token flows.
