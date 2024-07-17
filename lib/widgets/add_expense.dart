import 'dart:io';

import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.onSave});

  final void Function(Expense expense) onSave;

  @override
  State<AddExpense> createState() {
    return _AddExpense();
  }
}

class _AddExpense extends State<AddExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final now = DateTime.now();
  final formatter = DateFormat.yMd();
  DateTime? selectedDate;
  Category selectedCategory = Category.food;

  void cancelExpense() {
    Navigator.pop(context);
  }

  void showDate() async {
    final pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(now.year - 1), lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void closeWarning() {
    Navigator.pop(context);
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Warning'),
                content: const Text('Please add valid input'),
                actions: [
                  TextButton(
                    onPressed: closeWarning,
                    child: const Text('close'),
                  ),
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Warning'),
                content: const Text('Please add valid input'),
                actions: [
                  TextButton(
                    onPressed: closeWarning,
                    child: const Text('close'),
                  ),
                ],
              ));
    }
  }

  void submitExpense() {
    var amount = double.tryParse(amountController.text);
    final invalidAmount = amount == null || amount <= 0;
    if (titleController.text.trim().isEmpty ||
        invalidAmount ||
        selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onSave(
      Expense(
          amount: amount,
          date: selectedDate!,
          title: titleController.text,
          category: selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                        prefix: Icon(Icons.currency_rupee_rounded),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          selectedDate == null
                              ? 'no date selected'
                              : formatter.format(selectedDate!),
                        ),
                        IconButton(
                          onPressed: showDate,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value == null) {
                          return;
                        }
                        selectedCategory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: submitExpense,
                    child: const Text('Save'),
                  ),
                  TextButton(
                    onPressed: cancelExpense,
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
