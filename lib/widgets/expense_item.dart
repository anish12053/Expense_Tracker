import 'package:expense_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.item});
  final Expense item;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.title.toUpperCase(),style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(Icons.currency_rupee_rounded),
                Text(
                  item.amount.toStringAsFixed(2),
                ),
                const Spacer(),
                Icon(categoryIcon[item.category]),
                const SizedBox(
                  width: 4,
                ),
                Text(item.formattedDate),
              ],
            )
          ],
        ),
      ),
    );
  }
}
