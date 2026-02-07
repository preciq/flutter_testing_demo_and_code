# Execute tests using: 

```bash
flutter test
```

Above runs unit and widget tests only. To run integration tests, use:

```bash
flutter test integration_test/
```

To see detailed test results while executing tests, use:

```bash
flutter test --verbose
```

For mockito tests, must first generate mock classes using:

```bash
dart run build_runner build
```