import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String title;
  final String description;

  SecondScreen({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Stack(
            children: [
              Positioned(
                left: screenWidth * 0.04,
                top: screenHeight * 0.13,
                child: SizedBox(
                  width: screenWidth * 0.92,
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'SrbijaSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Positioned(
                left: screenWidth * 0.04,
                right: screenWidth * 0.04,
                top: screenHeight * 0.19,
                child: SizedBox(
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'SrbijaSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.04,
                top: screenHeight * 0.07,
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/back.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'SrbijaSans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
