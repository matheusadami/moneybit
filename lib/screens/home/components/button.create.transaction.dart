import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moneybit/controllers/transaction.controller.dart';
import 'package:moneybit/models/transaction.dart';
import 'package:moneybit/screens/home/components/bottom.sheet.type.transaction.dart';
import 'package:moneybit/screens/transaction/create.screen.dart';
import 'package:moneybit/theme/app.colors.dart';
import 'package:provider/provider.dart';

class ButtonCreateTransaction extends StatelessWidget {
  final BuildContext context;
  final Function(bool isSuccessfully) onFinished;

  const ButtonCreateTransaction({
    Key? key,
    required this.context,
    required this.onFinished,
  }) : super(key: key);

  void openBottomSheetTypeCreateTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetTypeTransaction(
          onTapRevenueTransaction: () {
            Navigator.pop(context);
            openBottomSheetCreateTransaction(TransactionType.revenue);
          },
          onTapExpenseTransaction: () {
            Navigator.pop(context);
            openBottomSheetCreateTransaction(TransactionType.expense);
          },
        );
      },
    );
  }

  void openBottomSheetCreateTransaction(TransactionType type) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => TransactionCreateScreen(
        transactionType: type,
        onFinished: (isSuccessfully) {
          context.read<TransactionController>().initLoading();
          onFinished(isSuccessfully);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: openBottomSheetTypeCreateTransaction,
      backgroundColor: AppColors.indigoBlue,
      child: const Icon(
        FontAwesomeIcons.plus,
        color: AppColors.white,
      ),
    );
  }
}
