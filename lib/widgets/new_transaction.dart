import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import './adaptive_button.dart';
import './adaptive_text_field.dart';

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
              AdaptiveTextField(
                'Title',
                _titleController,
                _submitData,
              ),
              const SizedBox(
                height: 10,
              ),
              AdaptiveTextField(
                'Amount',
                _amountController,
                _submitData,
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
                    AdaptiveButton(
                      CupertinoIcons.calendar,
                      Icons.calendar_month,
                      _presentDatePicker,
                    ),
                  ],
                ),
              ),
              AdaptiveButton(
                CupertinoIcons.floppy_disk,
                Icons.save_alt,
                _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
