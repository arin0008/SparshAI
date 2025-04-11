import 'package:SparshAI/Data/Const.dart';
import 'package:SparshAI/Screens/BookAppointment.dart';
import 'package:SparshAI/Widgets/Widgets.dart';
import 'package:flutter/material.dart';

import '../Data/Doctor.dart';
import '../Widgets/Drawer.dart';

class DoctorSearch extends StatefulWidget {
  const DoctorSearch({super.key});

  @override
  State<DoctorSearch> createState() => _DoctorSearchState();
}

class _DoctorSearchState extends State<DoctorSearch> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(child: DrawerWidget()),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 80,
            leading: Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 40,
                  ),
                );
              },
            ),
            centerTitle: true,
            title: Text(
              "Hello ${UserProfileData.name}!",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                  UserProfileData.imgUrl.toString(),
                )),
              )
            ],
            expandedHeight: 300,
            pinned: true,
            backgroundColor: const Color.fromRGBO(19, 35, 70, 1),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Search(hint: "Search Docotor"),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    color: const Color.fromRGBO(19, 35, 70, 1),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: const EdgeInsets.only(left: 24),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Let's find",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "your top doctor!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(19, 35, 70, 1)),
              height: size.height * 0.2 * Doctor.DocNameList.length,
              width: double.infinity,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white),
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  itemCount: Doctor.DocList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: DoctorCard(
                          index: index,
                          size: size,
                          data: Doctor.DocList[index]),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (
                              context,
                            ) =>
                                    BookAppointment(
                                      doc: Doctor.DocList[index],
                                    )));
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
