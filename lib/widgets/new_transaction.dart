import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(
    this.addTransaction, {super.key}
  );

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _sellectedDate;

  void _submitData() {
    final enterdTitle = _titleController.text;
    final enterdAmount = double.parse(_amountController.text);

    if (enterdTitle.isEmpty || enterdAmount <= 0 || _sellectedDate == null) {
      return;
    }

    widget.addTransaction(
      enterdTitle,
      enterdAmount,
      _sellectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _sellectedDate = pickedDate;
        });
      },
    );
  }

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
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 73,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _sellectedDate == null
                          ? 'No Date Choosen!'
                          : 'Picked Date:${DateFormat.yMMMd().format(_sellectedDate!)}',
                    ),
                  ),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(
                      Icons.calendar_month,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _submitData,
              icon: const Icon(Icons.save_alt),
            ),
          ],
        ),
      ),
    );
  }
}
