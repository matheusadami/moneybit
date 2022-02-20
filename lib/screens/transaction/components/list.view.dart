import 'package:flutter/material.dart';
import 'package:moneybit/models/transaction.dart';
import 'package:moneybit/screens/transaction/components/list.tile.dart';

class TransactionsListView extends StatelessWidget {
  final List<TransactionModel> transactions;
  final void Function(int index) onEditTransaction;
  final void Function(int index) onRemoveTransaction;

  const TransactionsListView({
    Key? key,
    required this.transactions,
    required this.onEditTransaction,
    required this.onRemoveTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, i) {
        return TransactionListTile(
          index: i,
          onEditTransaction: onEditTransaction,
          onRemoveTransaction: onRemoveTransaction,
          transaction: TransactionModel(
            name: transactions[i].name,
            type: transactions[i].type,
            value: transactions[i].value,
            createdAt: transactions[i].createdAt,
          ),
        );
      },
    );
  }
}
