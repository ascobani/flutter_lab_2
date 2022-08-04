import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/user_trasnaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(const MyApp());

Color color = const Color.fromARGB(255, 34, 34, 34);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: color,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 82, 82, 82),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Socks',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoes',
      amount: 1127.67,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String transactionTitle, double transactionAmount) {
    final newTransaction = Transaction(
      id: DateTime.now.toString(),
      title: transactionTitle,
      amount: transactionAmount,
      date: DateTime.now(),
    );
    setState(
      () {
        _userTransactions.add(newTransaction);
      },
    );
  }


  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              alignment: Alignment.center,
              onPressed: (() => startAddNewTransaction(context)),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Card(
                color: color,
                elevation: 5,
                child: const Text(
                  'CHART!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TransactionList(_userTransactions)
          ],
        ),
      ),
    );
  }
}
