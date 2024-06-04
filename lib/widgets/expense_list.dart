import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenselist,required this.onDelte});

  final List<Expense> expenselist;
  final void Function(Expense) onDelte;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenselist.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(expenselist[index]),
          onDismissed: (direction){
            onDelte(expenselist[index]);
          },
          child: ExpenseItem(item: expenselist[index]),
        );
      },
    );
  }
}
