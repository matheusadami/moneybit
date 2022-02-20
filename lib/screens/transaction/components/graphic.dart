import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:moneybit/controllers/transaction.controller.dart';
import 'package:moneybit/models/transaction.graphic.model.dart';
import 'package:moneybit/theme/app.colors.dart';
import 'package:moneybit/theme/app.textstyles.dart';
import 'package:provider/provider.dart';

class TransactionGraphic extends StatefulWidget {
  const TransactionGraphic({Key? key}) : super(key: key);

  @override
  State<TransactionGraphic> createState() => _TransactionGraphicState();
}

class _TransactionGraphicState extends State<TransactionGraphic> {
  late final TransactionGraphicModel transactionGraphicModel;

  @override
  void didChangeDependencies() {
    final transactionController = context.read<TransactionController>();
    transactionGraphicModel = transactionController.graphicModel;

    super.didChangeDependencies();
  }

  bool isTouched(FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
    return !event.isInterestedForInteractions ||
        pieTouchResponse == null ||
        pieTouchResponse.touchedSection == null;
  }

  PieChartData mainData() {
    return PieChartData(
      borderData: FlBorderData(show: false),
      sectionsSpace: 5,
      centerSpaceRadius: 0,
      sections: transactionGraphicModel.makeSections(),
      pieTouchData: PieTouchData(
        touchCallback: (FlTouchEvent event, pieTouchResponse) {
          if (isTouched(event, pieTouchResponse)) {
            context.read<TransactionController>().changeTouchedSection(-1);
            return;
          }

          final index = pieTouchResponse?.touchedSection!.touchedSectionIndex;
          context.read<TransactionController>().changeTouchedSection(index!);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<TransactionController, TransactionGraphicModel>(
      builder: (context, model, _) {
        return model.isShowGraphic
            ? SizedBox(
                height: 200,
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: Selector<TransactionController, int>(
                        builder: (context, value, child) {
                          return PieChart(
                            mainData(),
                          );
                        },
                        selector: (context, controller) =>
                            controller.graphicModel.touchedSection,
                      ),
                    ),
                    CaptionContent(
                      transactionGraphicModel: transactionGraphicModel,
                    ),
                  ],
                ),
              )
            : Container();
      },
      selector: (context, controller) => controller.graphicModel,
      shouldRebuild: (p, c) => c.isDone,
    );
  }
}

class CaptionContent extends StatelessWidget {
  final TransactionGraphicModel transactionGraphicModel;

  const CaptionContent({
    Key? key,
    required this.transactionGraphicModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 35),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mês: ${transactionGraphicModel.getMonthName()}',
            style: AppTextStyles.smallTitleDarkGray,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              CaptionItem(
                color: AppColors.green,
                label: 'Entrada',
              ),
              SizedBox(height: 4),
              CaptionItem(
                color: AppColors.delete,
                label: 'Saída',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CaptionItem extends StatelessWidget {
  final Color color;
  final String label;

  const CaptionItem({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: AppTextStyles.smallTitleDarkGray,
        )
      ],
    );
  }
}
