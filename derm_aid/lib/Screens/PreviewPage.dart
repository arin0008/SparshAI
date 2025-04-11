import 'dart:io';

import 'package:camera/camera.dart';
import 'package:SparshAI/Screens/Result.dart';
import 'package:SparshAI/Services/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/NumStepper.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.picture});
  final XFile picture;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Color.fromRGBO(188, 188, 188, 1),
            )),
        backgroundColor: const Color.fromRGBO(39, 39, 39, 1),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Analysis",
          style: TextStyle(
            color: Color.fromRGBO(188, 188, 188, 1),
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.question_mark_rounded,
                color: Color.fromRGBO(188, 188, 188, 1),
                size: 30,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.12,
            color: const Color.fromRGBO(39, 39, 39, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumStepper(
                  totalSteps: 4,
                  width: MediaQuery.of(context).size.width,
                  curStep: 3,
                  stepCompColor: const Color.fromRGBO(76, 239, 19, 1),
                  currentStepColor: const Color.fromRGBO(74, 213, 205, 1),
                  inactiveColor: const Color.fromRGBO(188, 188, 188, 1),
                  lineWidth: 1,
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: size.height * 0.66,
            child: Image.file(
              File(picture.path),
              fit: BoxFit.cover,
              width: 250,
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Result(
                              picture: picture,
                            )));
              },
              child: Container(
                width: double.infinity,
                color: const Color.fromRGBO(74, 213, 205, 1),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
