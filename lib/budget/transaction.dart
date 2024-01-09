import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final int amount;

  Transaction(this.title, this.amount);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      json['title'] as String,
      json['amount'] as int,
    );
  }
}

class TransactionWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String amount;

  TransactionWidget({
    required this.icon,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Color(0xFF8E72FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
              child: Image.asset(
                icon,
                color: Colors.white,
                width: 24,
                height: 24,
              ),
            ),
          ),
          Positioned(
            left: 63,
            top: 6,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'SrbijaSans',
                  fontWeight: FontWeight.w400),
            ),
          ),
          Positioned(
            left: 279,
            top: 6,
            child: Text(
              int.parse(amount) >= 0
                  ? '+$amount'
                  : '-${(-int.parse(amount)).toString()}',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'SrbijaSans',
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}