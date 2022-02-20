import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:moneybit/components/button.dart';
import 'package:moneybit/models/transaction.dart';
import 'package:moneybit/theme/app.textstyles.dart';
import 'package:moneybit/components/input.text.dart';
import 'package:moneybit/controllers/transaction.controller.dart';

class TransactionEditScreen extends StatefulWidget {
  final int index;
  final TransactionModel transaction;
  final void Function(bool isSuccessfully) onFinished;

  const TransactionEditScreen({
    Key? key,
    required this.index,
    required this.onFinished,
    required this.transaction,
  }) : super(key: key);

  @override
  _TransactionEditScreenState createState() => _TransactionEditScreenState();
}

class _TransactionEditScreenState extends State<TransactionEditScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final MoneyMaskedTextController valueController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    initialValue: 0.00,
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  @override
  void initState() {
    context.read<TransactionController>().transactionModel = widget.transaction;

    titleController.text = widget.transaction.name;
    valueController.updateValue(widget.transaction.value);

    super.initState();
  }

  void editTransaction() async {
    try {
      if (formKey.currentState!.validate()) {
        final transactionController = context.read<TransactionController>();
        if (!await transactionController.editTransaction(widget.index)) {
          throw Exception();
        }
        widget.onFinished(true);
      }
    } catch (e) {
      widget.onFinished(false);
    }
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
                    widget.transaction.type == TransactionType.revenue
                        ? 'Altere a Entrada'
                        : 'Altere a Saída',
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
                    onPressed: editTransaction,
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
