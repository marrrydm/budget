import 'package:flutter/material.dart';
import 'package:flutter_task/onb/photo_Info.dart';
import 'package:flutter_task/onb/provider.dart';
import 'package:flutter_task/onb/second_screen.dart';
import 'package:provider/provider.dart';

class ThreePhotosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PhotoInfoProvider(),
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
                Positioned(
                  left: 0,
                  top: 105,
                  child: GestureDetector(
                    onTap: () {
                      _onPhotoTap(context, "assets/img1.png", "Assign a mentor",
                          'It is better if the mentor is a teammate rather than a direct supervisor. This way, both the beginner and the mentor will be more comfortable - they will be on equal terms with each other. A newcomer can ask the mentor questions about the office, culture, and team. A mentor can introduce the new hire to all team members and give them a tour of the office.');
                    },
                    child: Container(
                      height: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: screenWidth * 0.5 - 9,
                            height: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/img1.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 105,
                  child: GestureDetector(
                    onTap: () {
                      _onPhotoTap(context, "assets/img2.png", "Company culture",
                          'You shared information about the company even before your first day of work. Now explain how things work in practice. Let influential people in the company, or at least the team, share their views on the values. Have them talk about how these values ​​influence their work. \n \nOnly 32% of companies communicate their values ​​to job applicants and new employees, so in many companies new employees quickly leave and managers have to find new ones.');
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              width: screenWidth * 0.5 - 9,
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/img2.png"),
                                  fit: BoxFit.fill,
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
                  left: screenWidth * 0.25,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      _onPhotoTap(context, "assets/img3.png", "Meet the team", 'Think about what makes your team unique, what sets it apart from others. Tell your new employee about this.\n \nDecide who will give the tour and introduce everyone - an HR manager, a team leader, or a newbie mentor.\n \nThe employee needs to be shown all the important places in the office: where the kitchen, coffee maker and cookies are located, where they can wash their hands and print documents.\n \nIf the employee has his own workplace, highlight it with something. For example, you can leave stickers with useful tips. If the company operates in a hot desking format, where employees can occupy any available seat and change it, prepare a fun “travel kit” for the employee. The set may include a laptop, notepad, pen and cup or sweets.');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.5, 
                            height: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/img3.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onPhotoTap(BuildContext context, String imagePath, String title,
      String description) {
    final provider = Provider.of<PhotoInfoProvider>(context, listen: false);
    provider.setPhotoInfo(PhotoInfo(
        imagePath: imagePath, title: title, description: description));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SecondScreen(description: description, title: title),
      ),
    );
  }
}
