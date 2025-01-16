import 'package:flutter/material.dart';

class ToDoSnackBar extends SnackBar {
  ToDoSnackBar({super.key, required bool isSuccess, required String message})
      : super(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: isSuccess ? Colors.green : Colors.amber,
          duration: const Duration(seconds: 2),
        );
}
