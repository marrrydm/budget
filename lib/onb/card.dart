import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String image;

  CustomCardWidget({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 178,
      height: 300,
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: 7,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          color: Colors.black,
          width: 7,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'SrbijaSans',
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
