import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:moneybit/components/button.dart';
import 'package:moneybit/models/transaction.dart';
import 'package:moneybit/theme/app.textstyles.dart';
import 'package:moneybit/components/input.text.dart';
import 'package:moneybit/controllers/transaction.controller.dart';

class TransactionCreateScreen extends StatefulWidget {
  final TransactionType transactionType;
  final void Function(bool isSuccessfully) onFinished;

  const TransactionCreateScreen({
    Key? key,
    required this.onFinished,
    required this.transactionType,
  }) : super(key: key);

  @override
  _TransactionCreateScreenState createState() =>
      _TransactionCreateScreenState();
}

class _TransactionCreateScreenState extends State<TransactionCreateScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final MoneyMaskedTextController valueController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    initialValue: 0.00,
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  void saveTransaction() async {
    try {
      if (formKey.currentState!.validate()) {
        final transactionController = context.read<TransactionController>();
        if (!await transactionController.saveTransaction()) {
          throw Exception();
        }
        widget.onFinished(true);
      }
    } catch (e) {
      widget.onFinished(false);
    }
  }

  @override
  void didChangeDependencies() {
    final transactionController = context.read<TransactionController>();

    final transactionModel = transactionController.transactionModel.copyWith(
      type: widget.transactionType,
    );
    transactionController.transactionModel = transactionModel;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 16),
                  child: Text(
                    widget.transactionType == TransactionType.revenue
                        ? 'Adicione uma Entrada'
                        : 'Adicione uma Saída',
                    style: AppTextStyles.commonTitleDarkGrayStrong,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: InputText(
                    icon: FontAwesomeIcons.font,
                    controller: titleController,
                    labelText: 'Informe o Título',
                    functionValidator:
                        context.read<TransactionController>().nameValidator,
                    onChanged: (value) {
                      context.read<TransactionController>().onChangeFormData(
                            name: value,
                          );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: InputText(
                    icon: FontAwesomeIcons.dollarSign,
                    controller: valueController,
                    labelText: 'Informe o Valor',
                    keyboardType: TextInputType.number,
                    functionValidator: (value) {
                      return context
                          .read<TransactionController>()
                          .valueValidator(
                            valueController.numberValue,
                          );
                    },
                    onChanged: (value) {
                      context.read<TransactionController>().onChangeFormData(
                            value: valueController.numberValue,
                          );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 24),
                  child: Button(
                    label: 'Salvar',
                    onPressed: saveTransaction,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
