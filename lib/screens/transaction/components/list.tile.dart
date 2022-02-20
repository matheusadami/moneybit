import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moneybit/models/transaction.dart';
import 'package:moneybit/theme/app.colors.dart';
import 'package:moneybit/theme/app.textstyles.dart';

class TransactionListTile extends StatefulWidget {
  final int index;
  final TransactionModel transaction;
  final void Function(int index) onEditTransaction;
  final void Function(int index) onRemoveTransaction;

  const TransactionListTile({
    Key? key,
    required this.transaction,
    required this.index,
    required this.onEditTransaction,
    required this.onRemoveTransaction,
  }) : super(key: key);

  @override
  State<TransactionListTile> createState() => _TransactionListTileState();
}

class _TransactionListTileState extends State<TransactionListTile> {
  String formatDateTimeToBR(DateTime dateTime) {
    return DateFormat.yMEd('pt_BR').format(dateTime);
  }

  String formatValueToBR(double value) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  }

  Widget getWidgetTrasactionValue() {
    return widget.transaction.type == TransactionType.revenue
        ? Text(
            formatValueToBR(widget.transaction.value),
            style: AppTextStyles.smallTitleDarkGreenStrong,
          )
        : Text(
            formatValueToBR(widget.transaction.value * -1),
            style: AppTextStyles.smallTitleDarkDeleteStrong,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      closeOnScroll: false,
      startActionPane: ActionPane(
        dragDismissible: false,
        motion: const DrawerMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: <SlidableAction>[
          SlidableAction(
            onPressed: (context) {
              widget.onRemoveTransaction(widget.index);
            },
            backgroundColor: AppColors.delete,
            foregroundColor: AppColors.white,
            icon: FontAwesomeIcons.trash,
            label: 'Remover',
          ),
          SlidableAction(
            onPressed: (context) {
              widget.onEditTransaction(widget.index);
            },
            backgroundColor: AppColors.neonBlue,
            foregroundColor: AppColors.white,
            icon: FontAwesomeIcons.edit,
            label: 'Editar',
          ),
        ],
      ),
      child: ListTile(
        dense: true,
        title: Text(
          widget.transaction.name,
          style: AppTextStyles.commonTitleDarkGray,
        ),
        subtitle: Text(
          formatDateTimeToBR(widget.transaction.createdAt!),
          style: AppTextStyles.smallTitleSilver,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            getWidgetTrasactionValue(),
          ],
        ),
      ),
    );
  }
}
