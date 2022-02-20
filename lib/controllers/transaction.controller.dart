import 'dart:math';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:moneybit/models/transaction.dart';
import 'package:moneybit/models/transaction.graphic.model.dart';
import 'package:moneybit/services/local.storage.service.dart';

class TransactionController extends ChangeNotifier {
  final String _storageKey = 'transactions';

  double totalBalance = 0;
  double totalRevenue = 0;
  double totalExpense = 0;
  late TransactionModel transactionModel;
  List<TransactionModel> transactions = [];
  TransactionGraphicModel graphicModel = TransactionGraphicModel();
  final LocalStorageService localStorageService = LocalStorageService();

  TransactionController() {
    transactionModel = TransactionModel.initInstance();
  }

  String? nameValidator(String? value) {
    return value?.isEmpty ?? true ? 'Por favor informe o título' : null;
  }

  String? valueValidator([double value = 0]) {
    return value <= 0 ? 'Por favor informe o valor' : null;
  }

  void onChangeFormData({String? name, TransactionType? type, double? value}) {
    transactionModel = transactionModel.copyWith(
      name: name,
      type: type,
      value: value,
    );
  }

  Future<void> initLoading() async {
    await getTransactions();
    totalRevenue = calculateTotalRevenue();
    totalExpense = calculateTotalExpense();
    totalBalance = calculateTotalBalance();

    loadGraphicData();

    notifyListeners();
  }

  Future<void> getTransactions() async {
    var response =
        await localStorageService.getStringList(_storageKey) ?? <String>[];

    transactions = response.map((e) => TransactionModel.fromJson(e)).toList();
  }

  Future<bool> saveTransaction() async {
    transactionModel = transactionModel.copyWith(createdAt: DateTime.now());

    var transactions =
        await localStorageService.getStringList(_storageKey) ?? <String>[];

    transactions.add(transactionModel.toJson());

    return await localStorageService.setStringList(_storageKey, transactions);
  }

  Future<bool> removeTransaction(int index) async {
    var transactions =
        await localStorageService.getStringList(_storageKey) ?? <String>[];

    transactions.removeAt(index);

    return await localStorageService.setStringList(_storageKey, transactions);
  }

  Future<bool> editTransaction(int index) async {
    var transactions =
        await localStorageService.getStringList(_storageKey) ?? <String>[];

    transactions.replaceRange(index, index + 1, [transactionModel.toJson()]);

    return await localStorageService.setStringList(_storageKey, transactions);
  }

  double calculateTotalBalance() {
    return calculateTotalRevenue() - calculateTotalExpense();
  }

  double calculateTotalRevenue() {
    final revenueValues = transactions
        .where((e) => e.type == TransactionType.revenue)
        .map<double>((e) => e.value);

    return revenueValues.isNotEmpty
        ? revenueValues.reduce((previous, current) => previous + current)
        : 0;
  }

  double calculateTotalExpense() {
    final expenseValues = transactions
        .where((e) => e.type == TransactionType.expense)
        .map<double>((e) => e.value);

    return expenseValues.isNotEmpty
        ? expenseValues.reduce((previous, current) => previous + current)
        : 0;
  }

  void loadGraphicData() {
    graphicModel.resetProps();

    if (transactions.isNotEmpty) {
      final months = transactions.groupListsBy((e) => e.createdAt!.month);

      graphicModel.month = months.keys.reduce(max);
      final monthTransactions = months[graphicModel.month];

      if (monthTransactions!.isNotEmpty) {
        graphicModel.revenueTotalValue = graphicModel.sumValuesFromTransactions(
          transactions: monthTransactions,
          transactionType: TransactionType.revenue,
        );

        graphicModel.expenseTotalValue = graphicModel.sumValuesFromTransactions(
          transactions: monthTransactions,
          transactionType: TransactionType.expense,
        );

        final totalBalance =
            graphicModel.revenueTotalValue + graphicModel.expenseTotalValue;

        graphicModel.expenseSectionValue =
            (graphicModel.expenseTotalValue * 100) / totalBalance;

        graphicModel.revenueSectionValue =
            (graphicModel.revenueTotalValue * 100) / totalBalance;
      }

      graphicModel.isShowGraphic = true;
    }

    graphicModel.isDone = true;
  }

  void changeTouchedSection(int section) {
    graphicModel.touchedSection = section;
    notifyListeners();
  }
}
