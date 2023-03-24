import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  static void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
      locale: 'en_US',
    );
    return formatter.format(amount);
  }
}
