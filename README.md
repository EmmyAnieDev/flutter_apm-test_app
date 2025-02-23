# Flutter Telex Error Monitor - Test App

This test application demonstrates various error scenarios to validate the Flutter Telex Error Monitor package. It provides a comprehensive way to test different types of runtime errors and how they are captured and reported.

## Getting Started

1. Clone this repository
2. Update the `main.dart` file with your configuration:
```
FlutterTelexErrorMonitor.init(
    appName: 'YOUR_APP_NAME',
    telexChannelWebhookUrl: 'YOUR_CHANNEL_WEBHOOK_URL'
);
```

## Features

This test app includes various error scenarios that you can trigger to test the error monitoring functionality:

### Built-in Error Scenarios

The app uses a counter to trigger different types of errors:

| Counter Value | Error Type | Description |
|--------------|------------|-------------|
| Counter = 2 | Type Error | Attempts to cast String to int |
| Counter = 3 | Null Safety | Tries to access length of null string |
| Counter = 4 | Network Error | Attempts to fetch from invalid URL |
| Counter = 5 | JSON Parse | Attempts to parse invalid JSON |
| Counter = 6 | Division Error | Attempts division by zero |
| Counter = 7 | Layout Error | Creates overflow with infinite width |
| Counter = 9 | Assertion Error | Triggers assertion failure |

### Testing Different Platforms

The error monitor has been designed to work across different platforms with consistent error reporting:

- Web
- Android
- iOS

Each platform may show slightly different stack traces, but the error monitor normalizes these differences.

## Usage

1. Launch the app
2. Use the floating action button to increment the counter
3. Different errors will be triggered at specific counter values
4. Check your Telex channel for error reports

## Error Types Covered

### Runtime Errors
- Type casting errors
- Null safety violations
- Arithmetic exceptions
- JSON parsing errors

### Network Errors
- Invalid URL access
- HTTP request failures
- Connection timeouts

### UI/Layout Errors
- Overflow errors
- Widget tree exceptions
- Layout constraints violations

### State Management Errors
- setState errors
- Async state updates
- Navigation state errors

## Development

To add new error scenarios:

1. Modify the `_incrementCounter` method in `home_page.dart`
2. Add new case statements for different counter values
3. Implement your error scenario

Example:
```
case 10:
  // Add your custom error scenario
  throw CustomException('Your custom error');
  break;
```