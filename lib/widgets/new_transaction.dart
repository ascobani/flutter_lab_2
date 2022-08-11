import 'dart:io';

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


  void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onPressed,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: onPressed,
            child: const Text('Done'),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    Widget buildCupertinoDatePicker() => SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            initialDateTime: _sellectedDate,
            mode: CupertinoDatePickerMode.date,
            // maximumDate: DateTime.now(), //idk why it dosent works it works witout the limits.
            onDateTimeChanged: (dateTime) {
              setState(
                () {
                  _sellectedDate = dateTime;
                },
              );

              // ignore: avoid_print
              print(_sellectedDate);
            },
          ),
        );

    // ignore: no_leading_underscores_for_local_identifiers
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
                TextInputType.text
              ),
              const SizedBox(
                height: 10,
              ),
              AdaptiveTextField(
                'Amount',
                _amountController,
                _submitData,
                TextInputType.number
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Platform.isIOS
                    ? Row(
                        children: <Widget>[
                          Expanded(
                      child:  Text(
                            _sellectedDate == null
                                ? 'No Date Sellected'
                                : 'Picked Date:${DateFormat.yMMMd().format(_sellectedDate!)}',
                          ),
                    ),
                          CupertinoButton.filled(
                              onPressed: () => showSheet(context,
                                  child: buildCupertinoDatePicker(),
                                  onPressed: () => Navigator.pop(context)),
                              child: const Icon(Icons.calendar_month)),
                          
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          Expanded(
                      child:  Text(
                            _sellectedDate == null
                                ? 'No Date Sellected'
                                : 'Picked Date:${DateFormat.yMMMd().format(_sellectedDate!)}',
                          ),
                    ),
                          IconButton(
                            onPressed: _presentDatePicker,
                           icon: const Icon(Icons.calendar_month),
                          )
                        ],
                      ),
              ),
              const SizedBox(height: 10,),
              /*
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
              */
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
