import 'package:camera/camera.dart';
import 'dart:io';
import 'package:SparshAI/Screens/DoctorSearch.dart';
import 'package:SparshAI/Services/Database.dart';
import 'package:SparshAI/Services/tfliteservice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as developer;

class Result extends StatefulWidget {
  final XFile picture;
  const Result({super.key, required this.picture});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final TFLiteService _tfliteService = TFLiteService();
  File? _selectedImage;
  List<double>? _prediction;
  bool _loading = false;
  double? percentageValue;
  var data1;

  List<String> classLabels = [
    'Melanoma',
    'Hives',
    'Vitiligo',
    'Acne',
    'Psoriasis',
    'Eczema',
    'Rosacea',
  ];

  @override
  void initState() {
    super.initState();
    _tfliteService.loadModel().then((_) {
      _pickImageAndPredict();
    });
  }

  Future<void> _pickImageAndPredict() async {
    final picked = widget.picture;
    if (picked != null) {
      setState(() {
        _loading = true;
        _selectedImage = File(picked.path);
      });

      final result = await _tfliteService.runModelOnImage(_selectedImage!);

      developer.log(result.toString(), name: 'Result');

      setState(() {
        _prediction = result;
        _loading = false;
      });

      // 1. Find the index of highest prediction
      int topIndex =
          _prediction!.indexOf(_prediction!.reduce((a, b) => a > b ? a : b));
      percentageValue = _prediction!.reduce((a, b) => a > b ? a : b);
      developer.log(percentageValue.toString(), name: 'Percentage Value');
      developer.log(topIndex.toString(), name: 'Top Index');
      // 2. Get the label
      String topLabel = classLabels[topIndex];
      developer.log(topLabel, name: 'Top Label');
      // 3. Fetch from Disease class
      data1 = await Disease().read(topLabel);

      double percentage;
      _prediction!.forEach((element) {
        percentage = element * 100;
        developer.log('${percentage.toStringAsFixed(2)}%',
            name: 'Percentage of each prediction');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final symptoms = data1?['symp'] ?? []; // Fallback to empty list
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,
              size: 24, color: Color.fromRGBO(188, 188, 188, 1)),
        ),
        backgroundColor: const Color.fromRGBO(39, 39, 39, 1),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Result",
          style: TextStyle(
            color: Color.fromRGBO(188, 188, 188, 1),
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.question_mark_rounded,
                color: Color.fromRGBO(188, 188, 188, 1), size: 30),
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _prediction != null
              ? (percentageValue! * 100) < 70.0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Not Detected'),
                          Text(
                            'Percentage: ${(percentageValue! * 100).toStringAsFixed(2)}%',
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(top: 20),
                        height: size.height * 1.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                color: Colors.white,
                                width: double.infinity,
                                child: data1 == null
                                    ? const Center(child: Text('No data found'))
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              data1['name'].toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: size.height * 0.25,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        height:
                                                            size.height * 0.2,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.blue,
                                                        ),
                                                        child: Image.file(
                                                            File(widget
                                                                .picture.path),
                                                            fit: BoxFit.cover),
                                                      ),
                                                      const Text(
                                                          "Scanned Image",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: size.height * 0.25,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        height:
                                                            size.height * 0.2,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                data1['img']
                                                                    .toString()),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(
                                                          "Disease Image",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Matched Percentage: ${(percentageValue! * 100).toStringAsFixed(2)}%',
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            "Overview",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            data1['over'].toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                          const Text(
                                            "Symptoms",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: size.height *
                                                0.05 *
                                                symptoms.length,
                                            child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: data1['symp'].length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 10.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                        width: 10.0,
                                                        height: 10.0,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.black,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      Expanded(
                                                        child: Text(
                                                          data1['symp'][index],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      16.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const Text(
                                            "Other images",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.18,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: data1['images'].length,
                                              itemBuilder:
                                                  (context, int index) {
                                                return Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  height: size.height * 0.18,
                                                  width: size.width * 0.4,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        height:
                                                            size.height * 0.14,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                data1['images']
                                                                    [index]),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DoctorSearch())),
                              child: Container(
                                width: double.infinity,
                                height: size.height * 0.09,
                                color: const Color.fromRGBO(74, 213, 205, 1),
                                child: const Center(
                                  child: Text(
                                    "Consult Doctor",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
              : const Text("No prediction yet."),
    );
  }
}
