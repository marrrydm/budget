import 'package:flutter/material.dart';
import 'package:flutter_task/onb/card.dart';
import 'package:flutter_task/onb/photo_Info.dart';
import 'package:flutter_task/onb/provider.dart';
import 'package:flutter_task/onb/second_screen.dart';
import 'package:provider/provider.dart';

class ThreePhotosScreen extends StatelessWidget {
  final List<PhotoInfo> photoDataList = [
    PhotoInfo(
      imagePath: "assets/img1.png",
      title: "Assign a mentor",
      description:
          'It is better if the mentor is a teammate rather than a direct supervisor. This way, both the beginner and the mentor will be more comfortable - they will be on equal terms with each other. A newcomer can ask the mentor questions about the office, culture, and team. A mentor can introduce the new hire to all team members and give them a tour of the office.',
    ),
    PhotoInfo(
      imagePath: "assets/img2.png",
      title: "Company culture",
      description:
          'You shared information about the company even before your first day of work. Now explain how things work in practice. Let influential people in the company, or at least the team, share their views on the values. Have them talk about how these values ​​influence their work. \n \nOnly 32% of companies communicate their values ​​to job applicants and new employees, so in many companies new employees quickly leave and managers have to find new ones.',
    ),
    PhotoInfo(
      imagePath: "assets/img3.png",
      title: "Meet the team",
      description:
          'Think about what makes your team unique, what sets it apart from others. Tell your new employee about this.\n \nDecide who will give the tour and introduce everyone - an HR manager, a team leader, or a newbie mentor.\n \nThe employee needs to be shown all the important places in the office: where the kitchen, coffee maker and cookies are located, where they can wash their hands and print documents.\n \nIf the employee has his own workplace, highlight it with something. For example, you can leave stickers with useful tips. If the company operates in a hot desking format, where employees can occupy any available seat and change it, prepare a fun “travel kit” for the employee. The set may include a laptop, notepad, pen and cup or sweets.',
    ),
    PhotoInfo(
      imagePath: "assets/img4.png",
      title: "Onboarding Process",
      description:
          'Joining our team is just the beginning. Learn about our seamless onboarding process that ensures you hit the ground running.\n\n'
          'Our onboarding process is designed to make you feel right at home from day one. You\'ll be introduced to our company culture, meet your mentor, and get to know the incredible individuals that make up our dynamic team. We believe that a smooth onboarding experience sets the foundation for a successful journey with us.',
    ),
    PhotoInfo(
      imagePath: "assets/img5.png",
      title: "Innovation Hub",
      description:
          'Explore the epicenter of creativity within our workplace. Uncover how our company culture fosters innovation and collaboration.\n\n'
          'Step into our innovation hub, where ideas come to life. Our company culture thrives on creativity, and you\'ll discover how our team collaborates to push boundaries and create groundbreaking solutions. Meet the minds behind the innovation and see how we\'re shaping the future together.',
    ),
    PhotoInfo(
      imagePath: "assets/img6.png",
      title: "Employee Growth Initiatives",
      description:
          'Discover the various avenues we offer for personal and professional development. From mentorship programs to continuous learning opportunities, we invest in your growth.\n\n'
          'We believe in nurturing talent. Our mentorship programs provide guidance and support, while our commitment to continuous learning ensures that every team member has the tools to succeed. Explore the avenues for personal and professional development that await you here.',
    ),
    PhotoInfo(
      imagePath: "assets/img7.png",
      title: "Wellness and Work-Life Balance",
      description:
          'Balancing work and life is key to our success. Learn about our initiatives promoting employee wellness and maintaining a healthy work-life balance.\n\n'
          'At our company, we prioritize your well-being. Explore the initiatives we have in place to support your mental and physical health, ensuring that you can bring your best self to work every day. Discover a workplace where balance is not just encouraged but embraced.',
    ),
    PhotoInfo(
      imagePath: "assets/img8.png",
      title: "Team-building Adventures",
      description:
          'Building strong connections is at the heart of our success. Dive into the exciting team-building adventures that strengthen our bonds and foster a collaborative environment.\n\n'
          'Teamwork makes the dream work. Join us on thrilling team-building adventures that go beyond the office walls. From outdoor excursions to interactive workshops, you\'ll experience the camaraderie that fuels our success.',
    ),
    PhotoInfo(
      imagePath: "assets/img9.png",
      title: "Diversity and Inclusion Initiatives",
      description:
          'Embracing diversity is our strength. Learn about the initiatives we\'ve implemented to foster an inclusive workplace where every voice is heard and valued.\n\n'
          'We celebrate diversity in all its forms. Explore the initiatives that make our workplace a welcoming and inclusive environment. Discover how we\'re committed to creating a space where every team member feels respected, represented, and empowered.',
    ),
    PhotoInfo(
      imagePath: "assets/img10.png",
      title: "Client Success Stories",
      description:
          'Behind every project is a story of success. Dive into our client success stories and see how our team\'s dedication and expertise make a lasting impact.\n\n'
          'Our projects aren\'t just tasks; they\'re success stories waiting to be told. Explore the achievements of our team as we partner with clients to overcome challenges and achieve their goals. Learn how your contributions can be part of the next chapter in our success story.',
    )
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PhotoInfoProvider(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 180,
                  child: ListView.builder(
                    itemCount: photoDataList.length - 1,
                    itemBuilder: (context, index) {
                      int photoIndex = index ~/ 2 * 3;
                      bool isTwoCardsRow = index.isEven;
                      if (photoIndex + 1 < photoDataList.length) {
                        if (isTwoCardsRow) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _onPhotoTap(
                                      context, photoDataList[photoIndex]);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 9, top: 20),
                                  height: 300,
                                  width:
                                      MediaQuery.of(context).size.width / 2 - 9,
                                  child: CustomCardWidget(
                                    title: photoDataList[photoIndex].title,
                                    image: photoDataList[photoIndex].imagePath,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _onPhotoTap(
                                    context,
                                    photoDataList[photoIndex + 1],
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 9, top: 20),
                                  height: 300,
                                  width:
                                      MediaQuery.of(context).size.width / 2 - 9,
                                  child: CustomCardWidget(
                                    title: photoDataList[photoIndex + 1].title,
                                    image:
                                        photoDataList[photoIndex + 1].imagePath,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              _onPhotoTap(
                                  context, photoDataList[photoIndex + 2]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 300,
                              child: FractionallySizedBox(
                                widthFactor: 0.5,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CustomCardWidget(
                                    title: photoDataList[photoIndex + 2].title,
                                    image:
                                        photoDataList[photoIndex + 2].imagePath,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPhotoTap(BuildContext context, PhotoInfo photoData) {
    final provider = Provider.of<PhotoInfoProvider>(context, listen: false);
    provider.setPhotoInfo(PhotoInfo(
      imagePath: photoData.imagePath,
      title: photoData.title,
      description: photoData.description,
    ));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(
          description: photoData.description,
          title: photoData.title,
        ),
      ),
    );
  }
}
