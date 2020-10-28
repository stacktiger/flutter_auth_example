# flutter_auth_example

Example Flutter App to demonstrate [`flutter_auth`](https://stacktiger.github.io/flutter_auth/#/) plugins:
- [`twitter_auth`](https://pub.dev/packages/twitter_auth)
- [`github_auth`](https://pub.dev/packages/github_auth)

## Getting Started

1. Download project to your local machine
```bash
git clone https://github.com/stacktiger/flutter_auth_example.git
```
2. Replace auth credentials with your own crdentials in `lib/main.dart`:
 ```dart
final twitterAuth = TwitterAuth(
    clientId: '<your-client-id>',
    clientSecret: '<your-client-secret>',
    callbackUrl: '<your-client-url>',
  );

  final githubAuth = GithubAuth(
    clientId: '<your-client-id>',
    clientSecret: '<your-client-secret>',
    callbackUrl: '<your-client-url>',
  );
```

3. Install project dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```
