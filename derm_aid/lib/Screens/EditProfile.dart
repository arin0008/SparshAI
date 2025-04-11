import 'package:SparshAI/Data/Const.dart';
import 'package:SparshAI/Services/Database.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mpdController = TextEditingController();
  final TextEditingController _dpwController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  DateTime birthDate = DateTime.utc(2019, 01, 01);
  TimeOfDay gib = const TimeOfDay(hour: 22, minute: 30);
  TimeOfDay wu = const TimeOfDay(hour: 06, minute: 30);

  final _formKey = GlobalKey<FormState>();
  var selectGen = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String dob = UserProfileData.aboutVal[1];
    List<String> date = dob.split('/');
    int day = int.parse(date[0]);
    int month = int.parse(date[1]);
    int year = int.parse(date[2]);
    birthDate = DateTime(year, month, day);

    _nameController.text = UserProfileData.name;
    _emailController.text = UserProfileData.email;
    _dpwController.text = UserProfileData.otherVal[1].toString();
    _mpdController.text = UserProfileData.otherVal[0].toString();
    _heightController.text = UserProfileData.aboutVal[2].toString();
    _weightController.text = UserProfileData.aboutVal[3].toString();
    if (UserProfileData.aboutVal[0] == "Male") {
      selectGen = 0;
    } else if (UserProfileData.aboutVal[0] == "Female")
      selectGen = 1;
    else if (UserProfileData.aboutVal[0] == "Other")
      selectGen = 2;
    else
      selectGen = 3;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Edit Profile"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            weight: 3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            height: size.height * 1.1,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "About Me",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                  const Text("Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(74, 213, 205, 0.1),
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(74, 213, 205, 0.1),
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                    child: TextFormField(
                      enabled: false,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Enter Email"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains("@"))
                          return 'Invalid email';
                        else
                          return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    "Gender",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  GenderSelect(),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    "Date of Birth",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(74, 213, 205, 0.1),
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 25),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${birthDate.day}/${birthDate.month}/${birthDate.year}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                                size: 24,
                              )
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Other",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                  OtherEdit(size),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      print("A");
                      await Database().update(
                          _nameController.text.trim(),
                          _emailController.text.trim(),
                          (selectGen == 0)
                              ? "Male"
                              : (selectGen == 1)
                                  ? "Female"
                                  : (selectGen == 2)
                                      ? "Other"
                                      : "none",
                          "${birthDate.day}/${birthDate.month}/${birthDate.year}",
                          int.parse(_heightController.text.trim()),
                          int.parse(_weightController.text.trim()),
                          int.parse(_mpdController.text.trim()),
                          int.parse(_dpwController.text.trim()));
                      print("B");
                      await Database().read(_emailController.text.trim());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(74, 213, 205, 1),
                          borderRadius: BorderRadius.circular(100)),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 25),
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 22),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: birthDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2020));
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
      });
    }
  }

  Future<void> _selectTimeG(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: gib,
    );
    if (pickedS != null && pickedS != gib) {
      setState(() {
        gib = pickedS;
      });
    }
  }

  Future<void> _selectTimeW(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: wu,
    );
    if (pickedS != null && pickedS != wu) {
      setState(() {
        wu = pickedS;
      });
    }
  }

  GenderSelect() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                selectGen = 0;
              });
            },
            child: Container(
              height: 60,
              margin: const EdgeInsets.all(5),
              color: (selectGen == 0)
                  ? const Color.fromRGBO(74, 213, 205, 1)
                  : const Color.fromRGBO(74, 213, 205, 0.1),
              child: const Center(
                child: Text(
                  "Male",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                selectGen = 1;
              });
            },
            child: Container(
              height: 60,
              margin: const EdgeInsets.all(5),
              color: (selectGen == 1)
                  ? const Color.fromRGBO(74, 213, 205, 1)
                  : const Color.fromRGBO(74, 213, 205, 0.1),
              child: const Center(
                child: Text(
                  "Female",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                selectGen = 2;
              });
            },
            child: Container(
              height: 60,
              margin: const EdgeInsets.all(5),
              color: (selectGen == 2)
                  ? const Color.fromRGBO(74, 213, 205, 1)
                  : const Color.fromRGBO(74, 213, 205, 0.1),
              child: const Center(
                child: Text(
                  "Other",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  OtherEdit(var size) {
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.24,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            mainAxisExtent: size.height * 0.12),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: size.height * 0.12,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(74, 213, 205, 0.1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Weight(kg)",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                TextField(
                  controller: _weightController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "00"),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: size.height * 0.12,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(74, 213, 205, 0.1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Height(cm)",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                TextField(
                  controller: _heightController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "00"),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: size.height * 0.12,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(74, 213, 205, 0.1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Medicine per day",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                TextField(
                  controller: _mpdController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "00"),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: size.height * 0.12,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(74, 213, 205, 0.1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Diagnosis per week",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                TextField(
                  controller: _dpwController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "00"),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => _selectTimeG(
              context,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: size.height * 0.12,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(74, 213, 205, 0.1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Get in bed",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${gib.hour}:${gib.minute}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => _selectTimeW(
              context,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: size.height * 0.12,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(74, 213, 205, 0.1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Wake up",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${wu.hour}:${wu.minute}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void edit() {
    UserProfileData.name = _nameController.text.trim();
    UserProfileData.email = _emailController.text.trim();
    UserProfileData.aboutVal[0] = (selectGen == 0)
        ? "Male"
        : (selectGen == 1)
            ? "Female"
            : (selectGen == 2)
                ? "Other"
                : "none";
    UserProfileData.aboutVal[1] =
        "${birthDate.day}/${birthDate.month}/${birthDate.year}";
  }
}
