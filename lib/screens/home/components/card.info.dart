import 'package:flutter/material.dart';
import 'package:moneybit/theme/app.colors.dart';
import 'package:moneybit/theme/app.textstyles.dart';

class CardInfo extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final String label;
  final String value;

  const CardInfo({
    Key? key,
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor = AppColors.green,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 95,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20.0,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: AppTextStyles.smallTitleSilver,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                value,
                style: AppTextStyles.smallTitleDarkGrayStrong,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
