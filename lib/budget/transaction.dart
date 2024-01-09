import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final int amount;
  final bool isPlus;

  Transaction(this.title, this.amount, this.isPlus);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'isPlus': isPlus,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      json['title'] as String,
      json['amount'] as int,
      json['isPlus'] as bool,
    );
  }
}

class TransactionWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String amount;
  final bool isPlus;

  TransactionWidget({
    required this.icon,
    required this.title,
    required this.amount,
    required this.isPlus,
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
              isPlus == true ? '+$amount' : '${(-int.parse(amount)).toString()}',
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
