import 'package:flutter/foundation.dart';

class Expense {
  final int id;
  final String title;
  final double amount;
  final Category category;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
  });

}