import 'dart:convert';
import 'package:flutter_task/budget/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetCache {
  static const String budgetKey = 'budget';
  static const String spendingKey = 'spending';
  static const String incomesKey = 'incomes';
  static const String transactionsKey = 'transactions';

  Future<void> saveData(double budget, double spending, double incomes, List<Transaction> transactions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(budgetKey, budget);
    prefs.setDouble(spendingKey, spending);
    prefs.setDouble(incomesKey, incomes);

    List<String> transactionsJson = transactions.map((t) => jsonEncode(t.toJson())).toList();
    prefs.setStringList(transactionsKey, transactionsJson);
  }

  Future<Map<String, dynamic>> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    double budget = prefs.getDouble(budgetKey) ?? 1200.0;
    double spending = prefs.getDouble(spendingKey) ?? 0.0;
    double incomes = prefs.getDouble(incomesKey) ?? 0.0;

    List<String> transactionsJson = prefs.getStringList(transactionsKey) ?? [];
    List<Transaction> transactions = transactionsJson
        .map((json) => Transaction.fromJson(jsonDecode(json)))
        .toList();

    return {
      'budget': budget,
      'spending': spending,
      'incomes': incomes,
      'transactions': transactions,
    };
  }
}
