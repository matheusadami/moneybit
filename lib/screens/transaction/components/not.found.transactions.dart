import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneybit/theme/app.textstyles.dart';

class NotFoundTransactions extends StatelessWidget {
  const NotFoundTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          Lottie.asset(
            'assets/animations/empty-results.json',
            fit: BoxFit.fill,
            width: 142,
            height: 96,
            repeat: true,
            animate: true,
          ),
          const SizedBox(height: 10),
          Text(
            'Você não possui movimentações.',
            style: AppTextStyles.subTitleSilverStrong,
          ),
        ],
      ),
    );
  }
}
