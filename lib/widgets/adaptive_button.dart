import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  var cupertinoIcons;
  var materialIcons;
  VoidCallback handler;

  AdaptiveButton(
    this.cupertinoIcons,
    this.materialIcons,
    this.handler,
  );

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton.filled(
            onPressed: handler,
            child: Icon(cupertinoIcons),
          )
        : IconButton(
            icon: Icon(materialIcons),
            onPressed: handler,
          );
  }
}
