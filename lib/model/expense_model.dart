import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category {food,work,travel,leisure}

final formatter = DateFormat.yMd();

const categoryIcon = {
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.work : Icons.work,
  Category.leisure : Icons.movie,
};

class Expense {
  Expense({required this.amount, required this.date, required this.title,required this.category})
      : id = uuid.v4();

  final String title;
  final double amount;
  final DateTime date;
  final String id;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

}
