import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:moneybit/screens/home/components/balance.info.dart';
import 'package:moneybit/screens/transaction/components/graphic.dart';
import 'package:moneybit/screens/home/components/button.create.transaction.dart';
import 'package:moneybit/screens/transaction/list.screen.dart';
import 'package:moneybit/theme/app.textstyles.dart';
import 'package:moneybit/theme/app.colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  void onFinishedCreateTransaction(isSuccessfully) {
    Navigator.pop(context); // Hide the transaction bottom sheet

    if (isSuccessfully) {
      showMaterialBanner(
        text: 'Dados salvos com sucesso.',
        backgroundColor: AppColors.green,
      );
    } else {
      showMaterialBanner(
        text: 'Não foi possível salvar os dados. Tente novamente.',
        backgroundColor: AppColors.delete,
      );
    }
  }

  void onFinishedRemoveTransaction() {
    Navigator.pop(context);

    showMaterialBanner(
      text: 'Registro removido com sucesso.',
      backgroundColor: AppColors.green,
    );
  }

  void onFinishedEditTransaction(bool isSuccessfully) {
    Navigator.pop(context);

    if (isSuccessfully) {
      showMaterialBanner(
        text: 'Registro alterado com sucesso.',
        backgroundColor: AppColors.green,
      );
    } else {
      showMaterialBanner(
        text: 'Não foi possível alterar o registro. Tente novamente.',
        backgroundColor: AppColors.delete,
      );
    }
  }

  void showMaterialBanner({
    required String text,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: AppTextStyles.smallTitleWhite,
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 85,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Seja Bem Vindo, Matheus!',
                          style: AppTextStyles.commonTitleDarkGrayStrong,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const BalanceInfo(),
              const SizedBox(height: 10),
              const TransactionGraphic(),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Movimentações',
                      style: AppTextStyles.commonTitleDarkGrayStrong,
                    ),
                  ],
                ),
              ),
              TransactionListScreen(
                onFinishedEditTransaction: onFinishedEditTransaction,
                onFinishedRemoveTransaction: onFinishedRemoveTransaction,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ButtonCreateTransaction(
        context: context,
        onFinished: onFinishedCreateTransaction,
      ),
    );
  }
}
