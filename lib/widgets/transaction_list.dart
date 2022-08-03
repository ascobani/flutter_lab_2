import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 554,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
           getColor() {
              if (transactions[index].amount >= 1000) {
                return Colors.redAccent;
              } else if (transactions[index].amount >= 750) {
                return Colors.redAccent;
              } else if (transactions[index].amount >= 500) {
                return Colors.yellow;
              } else if (transactions[index].amount >= 250) {
                return Colors.greenAccent;
              } else if (transactions[index].amount >= 0) {
                return Colors.green;
              }else{
                return Colors.black;
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
                      color: getColor(), //can't figure it out
                      //color: Colors.black(),
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '₺${transactions[index].amount}',
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
                      transactions[index].title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.yMd().format(transactions[index].date),
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
