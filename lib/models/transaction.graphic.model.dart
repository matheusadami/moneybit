import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:moneybit/models/transaction.dart';
import 'package:moneybit/theme/app.colors.dart';
import 'package:moneybit/theme/app.textstyles.dart';

class TransactionGraphicMarker {
  final int day;
  final int month;
  final TransactionModel transactionModel;

  TransactionGraphicMarker({
    required this.day,
    required this.month,
    required this.transactionModel,
  });
}

class TransactionGraphicModel {
  bool isDone = false;
  bool isShowGraphic = false;
  int month = 0;
  int touchedSection = -1;
  double revenueTotalValue = 0;
  double expenseTotalValue = 0;
  double revenueSectionValue = 0;
  double expenseSectionValue = 0;

  void resetProps() {
    isDone = false;
    isShowGraphic = false;
    month = 0;
    touchedSection = -1;
    revenueTotalValue = 0;
    expenseTotalValue = 0;
    revenueSectionValue = 0;
    expenseSectionValue = 0;
  }

  double sumValuesFromTransactions({
    required List<TransactionModel> transactions,
    required TransactionType transactionType,
  }) {
    var values = transactions
        .where((t) => t.type == transactionType)
        .map<double>((e) => e.value);

    double sum = values.isNotEmpty ? values.reduce((p, c) => p + c) : 0;
    return double.parse(sum.toStringAsFixed(2));
  }

  List<PieChartSectionData> makeSections() {
    return List.generate(2, (index) {
      final isTouched = index == touchedSection;
      final radius = isTouched ? 95.0 : 80.0;

      switch (index) {
        case 0:
          return PieChartSectionData(
            titlePositionPercentageOffset: 0.58,
            color: AppColors.green,
            radius: radius,
            value: revenueSectionValue.round().toDouble(),
            title: getRevenueTitleByTouched(isTouched),
            titleStyle: getTitleStyleByTouched(isTouched),
          );
        case 1:
          return PieChartSectionData(
            titlePositionPercentageOffset: 0.58,
            color: AppColors.delete,
            radius: radius,
            value: expenseSectionValue.round().toDouble(),
            title: getExpenseTitleByTouched(isTouched),
            titleStyle: getTitleStyleByTouched(isTouched),
          );
      }

      throw Error();
    });
  }

  String getMonthName() {
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
    }

    return '';
  }

  String getRevenueTitleByTouched(bool isTouched) {
    if (isTouched) {
      final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
      return formatter.format(revenueTotalValue);
    }

    return "${revenueSectionValue.round().toString()}%";
  }

  String getExpenseTitleByTouched(bool isTouched) {
    if (isTouched) {
      final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
      return formatter.format(expenseTotalValue);
    }

    return "${expenseSectionValue.round().toString()}%";
  }

  TextStyle getTitleStyleByTouched(bool isTouched) {
    return isTouched
        ? AppTextStyles.subTitleWhiteStrong
        : AppTextStyles.smallTitleWhite;
  }
}
