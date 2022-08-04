import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enterdTitle = titleController.text;
    final enterdAmount = double.parse(amountController.text);

    if (enterdTitle.isEmpty || enterdAmount <= 0) {
      return;
    }

    addTransaction(
      enterdTitle,
      enterdAmount,
    );
  }

  NewTransaction(this.addTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            IconButton(
              onPressed: submitData,
              icon: const Icon(Icons.save_alt),
            ),
          ],
        ),
      ),
    );
  }
}
