import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class AdaptiveButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final _cupertinoIcons;
  // ignore: prefer_typing_uninitialized_variables
  final _materialIcons;
  VoidCallback handler;

  AdaptiveButton(
    this._cupertinoIcons,
    this._materialIcons,
    this.handler, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton.filled(
            onPressed: handler,
            child: Icon(_cupertinoIcons),
          )
        : IconButton(
            icon: Icon(_materialIcons),
            onPressed: handler,
          );
  }
}
