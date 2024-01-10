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
      title: "Cryptocurrency Basics",
      description:
          'Embark on a journey into the exciting world of cryptocurrency. Understand what a cryptocurrency exchange is, how it functions, and why it plays a pivotal role in the digital asset ecosystem. Delve into the dynamic landscape of blockchain technology and explore the limitless possibilities it offers.',
    ),
    PhotoInfo(
      imagePath: "assets/img5.png",
      title: "Trading Innovation Hub",
      description:
          'Discover our innovation hub dedicated to cryptocurrency trading. Immerse yourself in an environment that fosters creativity and collaboration, where groundbreaking solutions in the realm of digital assets come to life. Meet the minds behind the innovation and witness how we shape the future of crypto together.',
    ),
    PhotoInfo(
      imagePath: "assets/img6.png",
      title: "Crypto Growth Initiatives",
      description:
          'Embark on a journey of continuous growth and development in the realm of cryptocurrencies. Our commitment to your personal and professional advancement goes beyond boundaries. Explore a vast array of initiatives, from cutting-edge mentorship programs to immersive learning opportunities in blockchain technology. We invest in your potential, ensuring you thrive in the ever-evolving landscape of digital assets.',
    ),
    PhotoInfo(
      imagePath: "assets/img7.png",
      title: "Blockchain Wellness and Balance",
      description:
          'Achieving balance in the fast-paced world of blockchain is paramount to our collective success. Immerse yourself in understanding how our initiatives promote the well-being of cryptocurrency enthusiasts. Explore the strategies we employ to maintain a healthy work-life balance within the dynamic and exciting crypto space. Your holistic wellness is not just encouraged but central to our thriving crypto community.',
    ),
    PhotoInfo(
      imagePath: "assets/img8.png",
      title: "Crypto Team-building Adventures",
      description:
          'Building robust connections lies at the core of our success in the cryptocurrency realm. Dive into exhilarating team-building adventures that not only strengthen our bonds but also foster a collaborative environment for navigating the multifaceted landscape of digital assets. Join us on thrilling excursions and interactive workshops where camaraderie fuels our shared success in the exciting world of crypto innovation.',
    ),
    PhotoInfo(
      imagePath: "assets/img10.png",
      title: "Crypto Success Stories",
      description:
          'Discover the narratives behind the triumphs of every crypto project. Immerse yourself in our client success stories within the vast world of blockchain. Witness firsthand how our teams unwavering dedication and expertise make a lasting impact on the ever-evolving crypto landscape. Explore how your unique contributions can be an integral part of the next compelling chapter in our ongoing success story within the dynamic and transformative cryptocurrency space.',
    ),
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
                  height: MediaQuery.of(context).size.height - 170,
                  child: ListView.builder(
                    itemCount: photoDataList.length,
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
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                      -10.0, 0.0, 0.0),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 300,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            9,
                                    child: CustomCardWidget(
                                      title: photoDataList[photoIndex].title,
                                      image:
                                          photoDataList[photoIndex].imagePath,
                                    ),
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
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                      21.0, 0.0, 10.0),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 300,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            9,
                                    child: CustomCardWidget(
                                      title:
                                          photoDataList[photoIndex + 1].title,
                                      image: photoDataList[photoIndex + 1]
                                          .imagePath,
                                    ),
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
