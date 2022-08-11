import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextField extends StatelessWidget {

  final String text;
  final controller;
  VoidCallback handler;

  AdaptiveTextField(
    this.text,
    this.controller,
    this.handler,
  );

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            placeholder: text,
            controller: controller,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => handler(),
          )
        : TextField(
            decoration: InputDecoration(labelText: text),
            controller: controller,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => handler(),
          );
  }
}
