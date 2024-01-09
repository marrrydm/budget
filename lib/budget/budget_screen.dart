import 'package:flutter/material.dart';
import 'budget_widget.dart';

class BudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BudgetSummaryWidget(),
    );
  }
}