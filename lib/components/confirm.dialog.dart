import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moneybit/theme/app.colors.dart';
import 'package:moneybit/theme/app.textstyles.dart';

class ConfirmDialog {
  static void show(
    BuildContext context, {
    required String title,
    required String contentText,
    required void Function() cancelAction,
    required void Function() acceptAction,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              const Icon(
                FontAwesomeIcons.exclamationTriangle,
                color: AppColors.orange,
                size: 20.0,
              ),
              const SizedBox(width: 12),
              Text(title),
            ],
          ),
          content: Wrap(
            children: <Widget>[
              Text(
                contentText,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Sim',
                style: AppTextStyles.smallTitleNeonBlue,
              ),
              onPressed: acceptAction,
            ),
            TextButton(
              child: Text(
                'Não',
                style: AppTextStyles.smallTitleNeonBlue,
              ),
              onPressed: cancelAction,
            ),
          ],
        );
      },
    );
  }
}
