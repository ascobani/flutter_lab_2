import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: const MyHomePage(),
      theme: ThemeData(
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontFamily: 'Opensans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              titleMedium: const TextStyle(
                  fontFamily: 'Opensans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              titleSmall: const TextStyle(
                  fontFamily: 'Opensans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
        primarySwatch: Colors.purple,
        // ignore: deprecated_member_use
        accentColor: Colors.amber,
        errorColor: Colors.red,
        appBarTheme: const AppBarTheme(
          toolbarTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 30,
          ),
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
  final List<Transaction> _userTransactions = [
    /* 
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
    */
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (transaction) {
        return transaction.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _addNewTransaction(
      String transactionTitle, double transactionAmount, DateTime datePicker) {
    final newTransaction = Transaction(
      id: DateTime.now.toString(),
      title: transactionTitle,
      amount: transactionAmount,
      date: datePicker,
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
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // ignore: no_leading_underscores_for_local_identifiers
    void _deleteTransaction(String id) {
      setState(() {
        _userTransactions.removeWhere((transaction) => transaction.id == id);
      });
    }

    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: const Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                onPressed: () => startAddNewTransaction(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ) as PreferredSizeWidget;

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: Chart(
                _recentTransactions,
              ),
            ),
            SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: TransactionList(
                _userTransactions,
                _deleteTransaction,
              ),
            )
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Platform.isIOS
                      ? const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.abc),
                          iconSize: 1,
                        )
                      : IconButton(
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
            body: pageBody);
  }
}
