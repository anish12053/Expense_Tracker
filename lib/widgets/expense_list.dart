import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenselist});

  final List<Expense> expenselist;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenselist.length,
      itemBuilder: (context, index) {
        return ExpenseItem(item: expenselist[index]);
      },
    );
  }
}
