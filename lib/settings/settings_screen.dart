import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
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

              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 65),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 88,
                              height: 88,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/per2.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: screenWidth * 0.4,
                              child: TextField(
                                controller: _nameController,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'SrbijaSans',
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 20,
                                    fontFamily: 'SrbijaSans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: screenWidth * 0.04,
                    top: 65,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Text(
                        'Edit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'SrbijaSans',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                    top: 210,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRow('Privacy Policy', 'i1.png', screenWidth),
                          const SizedBox(height: 10),
                          _buildDivider(screenWidth),
                          const SizedBox(height: 10),
                          _buildRow('Terms of Use', 'i2.png', screenWidth),
                          const SizedBox(height: 10),
                          _buildDivider(screenWidth),
                          const SizedBox(height: 10),
                          _buildRow('Notification', 'i3.png', screenWidth),
                          const SizedBox(height: 10),
                          _buildDivider(screenWidth),
                          const SizedBox(height: 10),
                          _buildRow('Share App', 'i4.png', screenWidth),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String text, String imageName, double screenWidth) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.05,
                  height: screenWidth * 0.05,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/$imageName'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'SrbijaSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Container(
                width: 24,
                height: 24,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/ArrowRight.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.7,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFF474747),
          ),
        ),
      ),
    );
  }
}
