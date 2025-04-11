import 'package:SparshAI/Data/Const.dart';
import 'package:SparshAI/Widgets/Widgets.dart';
import 'package:flutter/material.dart';

import '../Data/Doctor.dart';

class BookAppointment extends StatefulWidget {
  final Map<String, dynamic> doc;

  const BookAppointment({super.key, required this.doc});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: double.infinity,
            height: size.height * 1.2,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                Container(
                  height: size.height * 0.1,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        color: const Color.fromRGBO(119, 128, 137, 1),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 27,
                          weight: 2,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          height: size.height * 0.18,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(Doctor
                                      .img[widget.doc['name'].toString()]
                                      .toString()),
                                  fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 8)
                              ]),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dr." + widget.doc['name'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Text(
                                "Dermatologist",
                                style: TextStyle(
                                    color: Color.fromRGBO(119, 128, 137, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Rating(
                                    rating: double.parse(
                                        widget.doc['rating'].toString()),
                                    size: 28.0,
                                  ),
                                  Text(
                                    "(${widget.doc['reviews']})",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                DoctorExtraData(size: size, doc: widget.doc),
                Container(
                  height: size.height * 0.25,
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Select Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      DateSelect(),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Select Time",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TimeSelect(),
                      ))
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Biography",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.doc['bio'],
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(119, 128, 137, 1)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: InkWell(
          onTap: () {
            _showConfirmationDialog(context);
          },
          child: Container(
            color: const Color.fromRGBO(74, 213, 205, 1),
            height: 60,
            child: const Center(
              child: Text(
                "Book Appointment",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ));
  }
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Doctor: '),
            const SizedBox(height: 8),
            Text(
                'Date: ${DateTime.now().toIso8601String().substring(0, 10)}'), // Example date
            const SizedBox(height: 8),
            Text('Time: ${TimeOfDay.now().format(context)}'), // Example time
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add logic to confirm appointment
              Navigator.of(context).pop();
              // You can add additional logic here, such as saving the appointment
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}

class DoctorExtraData extends StatelessWidget {
  final size;
  final doc;
  const DoctorExtraData({super.key, required this.size, required this.doc});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.12,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Patients",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(119, 128, 137, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "${doc['patients']}+",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            color: Color.fromRGBO(119, 128, 137, 0.3),
            thickness: 2,
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Experience",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(119, 128, 137, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  doc['exp'].toString() + " years+",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            color: Color.fromRGBO(119, 128, 137, 0.3),
            thickness: 2,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Rating",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(119, 128, 137, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  doc['rating'].toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
