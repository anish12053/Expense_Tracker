import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() {
    return _ExpensePage();
  }
}

class _ExpensePage extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpenseList(expenselist: addedExpense),
          ),
        ],
      ),
    );
  }
}
