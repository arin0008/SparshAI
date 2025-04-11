import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dots_indicator/dots_indicator.dart';
// import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Data/Doctor.dart';
import '../Screens/CameraScan.dart';
import '../Screens/DoctorSearch.dart';
import '../Screens/Profile.dart';
import '../Screens/Reminders.dart';

class Search extends StatelessWidget {
  final String hint;

  const Search({super.key, required this.hint});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 15, top: 15),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: TextField(
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(128, 119, 137, 1)),
                decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(128, 119, 137, 1),
                    )),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(74, 213, 205, 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Center(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final int index;
  final size;
  final data;
  const DoctorCard(
      {super.key, required this.index, this.size, required this.data});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: size.height * 0.15,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(249, 249, 249, 1),
          border: Border.all(
              color: const Color.fromRGBO(247, 247, 247, 1),
              width: 1,
              strokeAlign: BorderSide.strokeAlignInside),
          boxShadow: const [
            BoxShadow(blurRadius: 4, color: Color.fromRGBO(0, 0, 0, 0.25))
          ]),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(
                  left: 20, top: 15, bottom: 15, right: 7),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        Doctor.img[data['name'].toString()].toString()),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromRGBO(247, 247, 247, 1),
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignInside)),
            ),
          ),
          Expanded(
              flex: 7,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 20, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Dr.${data['name']}",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    const Text(
                      "Dermatologist",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(119, 128, 137, 1)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Rating(
                                  rating:
                                      double.parse(data['rating'].toString()),
                                  size: 14.0),
                              Text(
                                " ${data['rating']}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(119, 128, 137, 1)),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            "${int.parse(data['reviews'].toString())} reviews",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(119, 128, 137, 1)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class Rating extends StatelessWidget {
  final double rating;
  final size;

  const Rating({super.key, required this.rating, required this.size});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemCount: 5,
      rating: rating,
      itemSize: size,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Color.fromRGBO(255, 177, 0, 1),
      ),
    );
  }
}

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: 3,
            options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                }),
            itemBuilder: (context, int index, int a) {
              return Container(
                width: 500,
                height: 200,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq7O2KSYHMedN0AYqrYvjnpDtnVCWZpbNVYA&usqp=CAU",
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.86),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                        color: const Color.fromRGBO(175, 175, 175, 1),
                        strokeAlign: BorderSide.strokeAlignOutside,
                        width: 1),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      )
                    ]),
              );
            }),
        DotsIndicator(
          dotsCount: 3,
          position: currentIndex.toDouble(),
          decorator: DotsDecorator(
            color: const Color.fromRGBO(175, 175, 175, 1),
            activeColor: const Color.fromRGBO(74, 213, 205, 1),
          ),
        )
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String text;
  final icon;
  final size;

  const FeatureCard(
      {super.key, required this.text, required this.icon, this.size});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: (text == "Scan")
                ? () async {
                    await availableCameras().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CameraScan(cameras: value))));
                  }
                : () {
                    if (text == "Reports") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()));
                    } else if (text == "Reminder")
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Reminders()));
                    else
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DoctorSearch()));
                  },
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              height: size.height * 0.21,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromRGBO(249, 249, 249, 1),
                  border: Border.all(
                      color: const Color.fromRGBO(236, 236, 236, 1),
                      strokeAlign: BorderSide.strokeAlignInside,
                      width: 1),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(190, 190, 190, 0.25),
                        offset: Offset(0, 3),
                        blurRadius: 4)
                  ]),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (text == "Scan")
              ? () async {
                  await availableCameras().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CameraScan(cameras: value))));
                }
              : () {
                  if (text == "Reports") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()));
                  } else if (text == "Reminder")
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Reminders()));
                  else
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DoctorSearch()));
                },
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(74, 213, 205, 1),
                borderRadius: BorderRadius.circular(35),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(190, 190, 190, 0.25),
                      offset: Offset(0, 3),
                      blurRadius: 4)
                ],
                border: Border.all(
                    color: const Color.fromRGBO(241, 241, 241, 1),
                    strokeAlign: BorderSide.strokeAlignInside,
                    width: 1)),
            child: Center(
              child: Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DateSelect extends StatefulWidget {
  const DateSelect({super.key});

  @override
  State<DateSelect> createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Adjust height as needed
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: _selectedDate,
        selectionColor:
            const Color.fromRGBO(74, 213, 205, 1), // Active day color
        selectedTextColor: Colors.white,
        dayTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 26,
          fontWeight: FontWeight.w600,
        ),
        monthTextStyle: const TextStyle(
          color: Color.fromRGBO(119, 128, 137, 1),
          fontSize: 18,
        ),
        dateTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }
}

class TimeSelect extends StatefulWidget {
  const TimeSelect({super.key});

  @override
  State<TimeSelect> createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  var selected = 0;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      spacing: 15,
      runSpacing: 15,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selected = 0;
            });
          },
          child: Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: (selected == 0)
                    ? const Color.fromRGBO(74, 213, 205, 1)
                    : Colors.white,
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4)
                ]),
            child: Center(
              child: Text(
                "10:00 AM",
                style: TextStyle(
                    color: (selected == 0)
                        ? Colors.white
                        : const Color.fromRGBO(119, 128, 137, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selected = 1;
            });
          },
          child: Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: (selected == 1)
                    ? const Color.fromRGBO(74, 213, 205, 1)
                    : Colors.white,
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4)
                ]),
            child: Center(
              child: Text(
                "11:00 AM",
                style: TextStyle(
                    color: (selected == 1)
                        ? Colors.white
                        : const Color.fromRGBO(119, 128, 137, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selected = 2;
            });
          },
          child: Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: (selected == 2)
                    ? const Color.fromRGBO(74, 213, 205, 1)
                    : Colors.white,
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4)
                ]),
            child: Center(
              child: Text(
                "12:00 PM",
                style: TextStyle(
                    color: (selected == 2)
                        ? Colors.white
                        : const Color.fromRGBO(119, 128, 137, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selected = 3;
            });
          },
          child: Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: (selected == 3)
                    ? const Color.fromRGBO(74, 213, 205, 1)
                    : Colors.white,
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4)
                ]),
            child: Center(
              child: Text(
                "01:00 PM",
                style: TextStyle(
                    color: (selected == 3)
                        ? Colors.white
                        : const Color.fromRGBO(119, 128, 137, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selected = 4;
            });
          },
          child: Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: (selected == 4)
                    ? const Color.fromRGBO(74, 213, 205, 1)
                    : Colors.white,
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4)
                ]),
            child: Center(
              child: Text(
                "02:00 PM",
                style: TextStyle(
                    color: (selected == 4)
                        ? Colors.white
                        : const Color.fromRGBO(119, 128, 137, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
