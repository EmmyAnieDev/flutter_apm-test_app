import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? nullString;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    // Delayed error to simulate async initialization error
    Future.delayed(Duration(seconds: 2), () {
      throw Exception('Async initialization failed');
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;

      // Different errors based on counter value
      switch (_counter) {
        case 2:
          dynamic notANumber = "123";
          int number = notANumber as int; // This will throw a TypeError
          break;

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => SecondScreen()),
        // );
        // break;

        case 3:
          // Null safety error
          print(nullString!.length); // Will throw null error
          break;

        case 4:
          // HTTP error
          fetchData(); // Will throw network error
          break;

        case 5:

          // JSON parsing error
          final invalidJson = "{name: 'John'"; // Invalid JSON
          json.decode(invalidJson); // Will throw FormatException
          break;

        case 6:
          // Division by zero
          print(42 ~/
              (_counter - 6)); // Will throw IntegerDivisionByZeroException
          break;
      }
    });
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://invalid.url.com'));

      // Check for error status codes and throw if needed
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpException(
          'HTTP Error ${response.statusCode}: ${response.body}',
          uri: Uri.parse('https://invalid.url.com'),
        );
      }

      // Update state only on success
      setState(() {
        userData = json.decode(response.body);
      });
    } catch (error, stackTrace) {
      // Report the error to Flutter’s error handler.
      // This will trigger your FlutterErrorChecker to send the error to your API.
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'fetchData',
          context: ErrorDescription('while fetching data from HTTP'),
        ),
      );

      // Optionally, rethrow the error if you want it to be treated as unhandled
      // (so that it is also caught by runZonedGuarded, if applicable).
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    //  Layout/Rendering errors in build method
    if (_counter == 7) {
      return Container(
        width: double.infinity,
        child: Row(
          children: List.generate(1000,
              (index) => Container(width: 100, height: 100, color: Colors.red)),
        ),
      );
    }

    // if (_counter == 8) {
    //   // Will cause stack overflow
    //   return build(context);
    // }

    // Regular UI
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter: $_counter\nTry different values to see different errors',
              textAlign: TextAlign.center,
            ),
            if (_counter == 9)
              Builder(
                builder: (context) {
                  // Creating assertion error using assert
                  assert(
                      false, 'This is a forced assertion error at counter 9');
                  // This line won't be reached due to assertion
                  return Container();
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
