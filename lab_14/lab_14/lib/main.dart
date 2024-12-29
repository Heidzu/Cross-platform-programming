import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Функція для розрахунку y = 5x / 4x^2
  double calculate(int x) {
    return 5 * x / (4 * x * x); // f(x) = 5x / 4x^2
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AV-34: Yaroslav\'s last Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Function result: ${calculate(_counter).toStringAsFixed(2)}', // Передаємо без .toDouble()
              style: Theme.of(context).textTheme.bodyLarge, // Замінили на bodyLarge
            ),
            Text(
              'Counter value: $_counter',
              style: Theme.of(context).textTheme.bodyLarge, // Замінили на bodyLarge
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.pets), // Іконка для FloatingActionButton
      ),
    );
  }
}
