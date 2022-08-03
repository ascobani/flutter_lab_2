import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction>transactions;

  TransactionList(this.transactions)

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map(
        (transaction) {
          /* 
              getColor() {
                if (transaction.amount >= 1000) {
                  return Colors.redAccent;
                } else if (transaction.amount >= 750) {
                  return Colors.redAccent;
                } else if (transaction.amount >= 500) {
                  return Colors.yellow;
                } else if (transaction.amount >= 250) {
                  return Colors.greenAccent;
                } else if (transaction.amount >= 0) {
                  return Colors.green;
                }
              }
              */
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
                      //color: getColor(), //can't figure it out
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '₺${transaction.amount}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 20,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.yMd().format(transaction.date),
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
