import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/widgets/add_expense.dart';
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
  void openModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: ((context) => AddExpense(
            onSave: addExpense,
          )),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      addedExpense.add(expense);
    });
  }

  void deleteExpense(Expense expense) {
    final expenseIndex = addedExpense.indexOf(expense);
    setState(() {
      addedExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(label: 'Undo', onPressed: (){
          setState(() {
            addedExpense.insert(expenseIndex, expense);
          });
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const Center(
      child: Text(
        '          No expense Yet!!\nAdd you expenses Manisha',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );

    if (addedExpense.isNotEmpty) {
      setState(() {
        activeScreen = ExpenseList(
          expenselist: addedExpense,
          onDelte: deleteExpense,
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: openModal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: activeScreen),
        ],
      ),
    );
  }
}
