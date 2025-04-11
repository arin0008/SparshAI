import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Widgets/Profile_Widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(19, 35, 70, 1),
          leadingWidth: 80,
          centerTitle: true,
          title: const Text(
            "Reports",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              color: const Color.fromRGBO(19, 35, 70, 1),
              child: Column(
                children: [
                  const UserInfo(),
                  const BioData(),
                  const DiseaseReview(),
                  Medicine(
                    size: size,
                  ),
                ],
              )),
        ));
  }
}
