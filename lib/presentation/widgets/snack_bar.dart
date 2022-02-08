import 'package:flutter/material.dart';

class SnackBarWidget {
  late BuildContext context;
  late String content;
  void showSnack() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(content),
          duration: Duration(milliseconds: 500),
        ),
      );
  }
}
