import 'package:flutter/material.dart';
import './widgets/user_trasnaction.dart';



void main() => runApp(const MyApp());

Color color = Colors.amberAccent;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: const MyHomePage(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.amber,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? get kDebugMode => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Card(
                color: color,
                elevation: 5,
                child: const Text('CHART!'),
              ),
            ),
            UserTransactions()
          ],
        ),
      );
  }
}
