import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/src/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moneybit/controllers/transaction.controller.dart';
import 'package:moneybit/screens/home/home.screen.dart';
import 'package:moneybit/theme/app.colors.dart';
import 'package:moneybit/theme/app.textstyles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 4),
        () => context.read<TransactionController>().initLoading(),
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return const SplashScreenBody();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const SplashScreenErrorBody();
            }

            return const HomeScreen();
        }
      },
    );
  }
}

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.indigoBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/splash-loading.json',
            fit: BoxFit.cover,
            width: 350,
            height: 350,
            repeat: true,
            animate: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Carregando...',
              style: AppTextStyles.commonTitleWhiteStrong,
            ),
          )
        ],
      ),
    );
  }
}

class SplashScreenErrorBody extends StatelessWidget {
  const SplashScreenErrorBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.indigoBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35),
            child: Column(
              children: <Widget>[
                const Icon(
                  FontAwesomeIcons.exclamationCircle,
                  color: AppColors.darkGray,
                  size: 32.0,
                ),
                const SizedBox(height: 25),
                Text(
                  'Houve um erro ao realizar a operação.',
                  style: AppTextStyles.commonTitleDarkGrayStrong,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
