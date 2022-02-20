import 'package:flutter/material.dart';
import 'package:moneybit/components/confirm.dialog.dart';
import 'package:moneybit/screens/transaction/edit.screen.dart';
import 'package:provider/provider.dart';
import 'package:moneybit/screens/transaction/components/not.found.transactions.dart';
import 'package:moneybit/screens/transaction/components/list.view.dart';
import 'package:moneybit/controllers/transaction.controller.dart';
import 'package:moneybit/models/transaction.dart';

class TransactionListScreen extends StatefulWidget {
  final void Function(bool isSuccessfully) onFinishedEditTransaction;
  final void Function() onFinishedRemoveTransaction;

  const TransactionListScreen({
    Key? key,
    required this.onFinishedEditTransaction,
    required this.onFinishedRemoveTransaction,
  }) : super(key: key);

  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  void onEditTransaction(int index) {
    final transactionController = context.read<TransactionController>();
    final transaction = transactionController.transactions[index];

    showModalBottomSheet(
      context: context,
      builder: (context) => TransactionEditScreen(
        index: index,
        onFinished: (isSuccessfully) {
          context.read<TransactionController>().initLoading();
          widget.onFinishedEditTransaction(isSuccessfully);
        },
        transaction: transaction,
      ),
    );
  }

  void onRemoveTransaction(int index) {
    ConfirmDialog.show(
      context,
      title: 'Confirmação',
      contentText: 'Deseja remover este registro?',
      cancelAction: () => Navigator.pop(context),
      acceptAction: () {
        removeTransaction(index);
      },
    );
  }

  void removeTransaction(int index) async {
    final transactionController = context.read<TransactionController>();

    await transactionController.removeTransaction(index);

    transactionController.initLoading();
    widget.onFinishedRemoveTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<TransactionController, List<TransactionModel>>(
      builder: (context, transactions, _) {
        return transactions.isNotEmpty
            ? TransactionsListView(
                transactions: transactions,
                onEditTransaction: onEditTransaction,
                onRemoveTransaction: onRemoveTransaction,
              )
            : const NotFoundTransactions();
      },
      selector: (context, controller) => controller.transactions,
    );
  }
}
