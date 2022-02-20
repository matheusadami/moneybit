import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moneybit/controllers/transaction.controller.dart';
import 'package:moneybit/screens/splash/splash.screen.dart';
import 'package:moneybit/theme/app.colors.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TransactionController>(
          create: (context) => TransactionController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Money Bit',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            brightness: Brightness.light,
            primary: AppColors.ligthGray,
            primaryVariant: AppColors.darkGray,
            secondary: AppColors.orange,
            secondaryVariant: AppColors.indigoBlue,
          ),
          backgroundColor: AppColors.ligthGray,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
