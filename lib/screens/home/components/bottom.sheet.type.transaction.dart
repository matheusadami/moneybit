import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moneybit/theme/app.colors.dart';
import 'package:moneybit/theme/app.textstyles.dart';

class BottomSheetTypeTransaction extends StatelessWidget {
  final void Function()? onTapRevenueTransaction;
  final void Function()? onTapExpenseTransaction;

  const BottomSheetTypeTransaction({
    Key? key,
    this.onTapRevenueTransaction,
    this.onTapExpenseTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            ListTile(
              onTap: onTapRevenueTransaction,
              leading: const Icon(
                FontAwesomeIcons.longArrowAltUp,
                color: AppColors.green,
                size: 24.0,
              ),
              title: Text(
                'Entrada',
                style: AppTextStyles.middleTitleDarkGray,
              ),
            ),
            ListTile(
              onTap: onTapExpenseTransaction,
              leading: const Icon(
                FontAwesomeIcons.longArrowAltDown,
                color: AppColors.delete,
                size: 24.0,
              ),
              title: Text(
                'Saída',
                style: AppTextStyles.middleTitleDarkGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
