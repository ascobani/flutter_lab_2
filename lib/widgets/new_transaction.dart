import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction, {super.key});

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
    Platform.isIOS
        ? CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {},
            initialDateTime: DateTime.now(),
          )
        : showDatePicker(
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
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Title',
                      controller: _titleController,
                      onSubmitted: (_) => _submitData(),
                    )
                  : TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                      onSubmitted: (_) => _submitData(),
                    ),
              const SizedBox(
                height: 10,
              ),
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Amount',
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(),
                    )
                  : TextField(
                      decoration: const InputDecoration(labelText: 'Amount'),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0688,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _sellectedDate == null
                            ? 'No Date Choosen!'
                            : 'Picked Date:${DateFormat.yMMMd().format(_sellectedDate!)}',
                      ),
                    ),
                    Platform.isIOS
                        ? CupertinoButton.filled(
                            child: Icon(CupertinoIcons.calendar_today),
                            onPressed: _presentDatePicker,
                          )
                        : IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                          ),
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton.filled(
                      child: Icon(CupertinoIcons.floppy_disk),
                      onPressed: _submitData,
                    )
                  : IconButton(
                      onPressed: _submitData,
                      icon: const Icon(Icons.save_alt),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
