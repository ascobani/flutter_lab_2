import 'package:flutter/material.dart';

import './transaction.dart';

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

final List<Transaction> transaction = [
  Transaction(
    id: 't1',
    title: 'New Shoes',
    amount: 69.99,
    date: DateTime.now(),
  ),
  Transaction(
    id: 't2',
    title: 'New Phone',
    amount: 1099,
    date: DateTime.now(),
  ),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            color: color,
            elevation: 5,
            child: const Text('CHART!'),
          ),
          Column(
            children: transaction.map((transaction) {
              getColor() {
                if (transaction.amount >= 1000) {
                  return Colors.green;
                } else if (transaction.amount >= 750) {
                  return Colors.yellow;
                } else if (transaction.amount >= 500) {
                  return Colors.yellow;
                } else if (transaction.amount >= 250) {
                  return Colors.yellow;
                } else if (transaction.amount >= 0) {
                  return Colors.yellow;
                }
              }

              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: getColor(),
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        transaction.amount.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(transaction.title),
                        Text(
                          transaction.date.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
