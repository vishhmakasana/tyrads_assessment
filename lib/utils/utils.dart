import 'package:flutter/material.dart';

class Utils {
  static void showInfoDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(14),
              child: const Text("Okay"),
            ),
          ),
        ],
      ),
    );
  }
}
