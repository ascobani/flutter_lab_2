import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class AdaptiveTextField extends StatelessWidget {

  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback handler;

  AdaptiveTextField(
    this.text,
    this.controller,
    this.handler, {super.key}
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
