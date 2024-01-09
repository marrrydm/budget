import 'package:flutter/material.dart';
import 'package:flutter_task/budget/budget_cache.dart';
import 'package:flutter_task/budget/transaction.dart';

class BudgetSummaryWidget extends StatefulWidget {
  @override
  _BudgetSummaryWidgetState createState() => _BudgetSummaryWidgetState();
}

class _BudgetSummaryWidgetState extends State<BudgetSummaryWidget> {
  bool spendingClicked = false;
  bool incomesClicked = false;
  double budget = 0;
  double spending = 0;
  double incomes = 0;
  List<Transaction> transactions = [];

  BudgetCache _budgetCache = BudgetCache();

  Future<void> _showTransactionInputDialog(String title, bool isPlus) async {
    String transactionTitle = '';
    double transactionAmount = 0.0;

  await showDialog(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: Text('Add $title'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  transactionTitle = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  transactionAmount = double.tryParse(value) ?? 0.0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (transactionTitle.isNotEmpty && transactionAmount != 0) {
                  handleTransaction(
                      transactionTitle, transactionAmount.toInt(), isPlus);
                  _updateButtonState(title, transactionAmount.toInt());

                  setState(() {
                    if (title == 'Spending') {
                      spending += isPlus ? -transactionAmount : transactionAmount;
                    } else if (title == 'Incomes') {
                      incomes += isPlus ? transactionAmount : -transactionAmount;
                    }
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        ),
      );
    },
  );
}

  @override
  void initState() {
    super.initState();
    _loadDataFromCache();
  }

  void _loadDataFromCache() async {
    Map<String, dynamic> data = await _budgetCache.loadData();
    setState(() {
      budget = data['budget'];
      spending = data['spending'];
      incomes = data['incomes'];
      transactions = data['transactions'];
    });
  }

  void _saveDataToCache() async {
    await _budgetCache.saveData(budget, spending, incomes, transactions);
  }

  @override
  void dispose() {
    _saveDataToCache();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildBudgetContainer(),
                  SizedBox(height: 15),
                  _buildSpendingIncomesContainer(),
                  SizedBox(height: 15),
                  _buildTransactionList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: 198,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 7),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            right: 10,
            top: 47,
            child: Text(
              '\$ ${budget.toStringAsFixed(0)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontFamily: 'SrbijaSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 137,
            top: 15,
            child: Text(
              'Budget',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'SrbijaSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 15,
            bottom: 15,
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'SrbijaSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 143),
                  Text(
                    '.... 6789',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'SrbijaSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingIncomesContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 75,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 188,
            top: 10,
            child: Container(
              width: 142,
              height: 50,
              child: InkWell(
                onTap: _toggleSpending,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 5,
                      child: Text(
                        'Spending',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontFamily: 'SrbijaSans',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 28,
                      child: Text(
                        '\$ -${spending.toInt()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'SrbijaSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 173,
            top: 0,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(1.57),
              child: Container(
                width: 75,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Color(0xFF474747),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 10,
            child: Container(
              width: 143,
              height: 50,
              child: InkWell(
                onTap: _toggleIncomes,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 5,
                      child: Text(
                        'Incomes',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          fontFamily: 'SrbijaSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 28,
                      child: Text(
                        '\$ ${incomes.toInt()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'SrbijaSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 0),
        width: double.infinity,
        height: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 14,
                fontFamily: 'SrbijaSans',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return TransactionWidget(
                    icon: 'assets/trans.png',
                    title: transactions[index].title,
                    amount: transactions[index].amount.toString(),
                    isPlus: transactions[index].isPlus,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleTransaction(String title, int amount, bool isPlus) {
    setState(() {
      transactions.add(Transaction(title, amount, isPlus));
      budget += isPlus ? amount : -amount;

      if (title == 'Spending') {
        spending += isPlus ? -amount : amount;
      } else if (title == 'Incomes') {
        incomes += isPlus ? amount : -amount;
      }
    });
  }

  void _updateButtonState(String title, int amount) {
    setState(() {
      if (title == 'Spending') {
        spendingClicked = !spendingClicked;
        incomesClicked = false;
      } else if (title == 'Incomes') {
        incomesClicked = !incomesClicked;
        spendingClicked = false;
      }
    });
  }

  void _toggleSpending() {
    _showTransactionInputDialog('Spending', false);
  }

  void _toggleIncomes() {
    _showTransactionInputDialog('Incomes', true);
  }
}
