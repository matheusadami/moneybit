import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moneybit/controllers/transaction.controller.dart';
import 'package:moneybit/screens/home/components/card.info.dart';
import 'package:moneybit/theme/app.colors.dart';
import 'package:moneybit/theme/app.textstyles.dart';
import 'package:provider/provider.dart';

class BalanceInfo extends StatelessWidget {
  const BalanceInfo({Key? key}) : super(key: key);

  String formatValueToBR(double value) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 35),
          child: Column(
            children: <Widget>[
              Selector<TransactionController, double>(
                builder: (context, totalBalance, _) {
                  return Text(
                    formatValueToBR(totalBalance),
                    style: AppTextStyles.homeTitleDarkGray,
                    textAlign: TextAlign.center,
                  );
                },
                selector: (context, controller) => controller.totalBalance,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Selector<TransactionController, double>(
                builder: (context, totalRevenue, _) {
                  return CardInfo(
                    icon: FontAwesomeIcons.longArrowAltUp,
                    value: formatValueToBR(totalRevenue),
                    label: 'Entradas',
                  );
                },
                selector: (context, controller) => controller.totalRevenue,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Selector<TransactionController, double>(
                builder: (context, totalExpense, _) {
                  return CardInfo(
                    iconColor: AppColors.delete,
                    icon: FontAwesomeIcons.longArrowAltDown,
                    value: formatValueToBR(totalExpense),
                    label: 'Saídas',
                  );
                },
                selector: (context, controller) => controller.totalExpense,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
