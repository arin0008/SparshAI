import 'package:SparshAI/Data/Const.dart';
import 'package:SparshAI/Data/ReminderData.dart';
import 'package:SparshAI/Widgets/ReminderWidget.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:table_calendar/table_calendar.dart';

class Reminders extends StatefulWidget {
  const Reminders({super.key});

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  TimeOfDay reminderTime = TimeOfDay.now();
  DateTime _focusedDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  late ScrollController scrollController;
  String medName = "", medPower = "", medQuantity = "";
  var _isExpanded = false;
  var visible = 0;
  Map<String, List> dateEvents = {};
  List<Map> reminderList = [];

  @override
  void initState() {
    // TODO: implement initState
    final now = DateTime.now();
    _selectedDate = now;
    _focusedDate = now;
    _isExpanded = false;
    super.initState();
  }

  var size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(19, 35, 70, 1),
        leadingWidth: 80,
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
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
                backgroundImage: NetworkImage(
              UserProfileData.imgUrl,
            )),
          )
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: const Color.fromRGBO(19, 35, 70, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (!_isExpanded)
                      ? TableCalendar(
                          rowHeight: 60,
                          calendarFormat: CalendarFormat.week,
                          daysOfWeekHeight: 20,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          firstDay: DateTime(2022),
                          lastDay: DateTime(2030),
                          focusedDay: _focusedDate,
                          onDaySelected: (selectedDate, focusedDay) {
                            if (!isSameDay(_selectedDate, selectedDate)) {
                              setState(() {
                                _selectedDate = selectedDate;
                                _focusedDate =
                                    focusedDay.isAfter(DateTime(2025))
                                        ? DateTime(2025)
                                        : focusedDay;
                              });
                            }
                          },
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDate, day);
                          },
                          headerStyle: HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible: false,
                            titleTextStyle: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            leftChevronIcon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                            rightChevronIcon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                            leftChevronMargin: const EdgeInsets.only(left: 70),
                            rightChevronMargin:
                                const EdgeInsets.only(right: 70),
                          ),
                          calendarStyle: CalendarStyle(
                            selectedTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                            weekendTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                            defaultTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                            todayTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                            todayDecoration: const BoxDecoration(
                              color: Color.fromRGBO(42, 207, 198, 0.5),
                              shape: BoxShape.rectangle,
                            ),
                            selectedDecoration: const BoxDecoration(
                                color: Color.fromRGBO(42, 207, 198, 1),
                                shape: BoxShape.rectangle),
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                              weekendStyle: const TextStyle(
                                  color: Colors.white, fontSize: 15)),
                        )
                      : TableCalendar(
                          rowHeight: 50,
                          calendarFormat: CalendarFormat.month,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          firstDay: DateTime(2022),
                          lastDay: DateTime(2025),
                          focusedDay: _focusedDate,
                          onDaySelected: (selectedDate, focusedDay) {
                            if (!isSameDay(_selectedDate, selectedDate)) {
                              setState(() {
                                _selectedDate = selectedDate;
                                _focusedDate =
                                    focusedDay.isAfter(DateTime(2025))
                                        ? DateTime(2025)
                                        : focusedDay;
                              });
                            }
                          },
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDate, day);
                          },
                          headerStyle: HeaderStyle(
                            titleCentered: true,
                            formatButtonVisible: false,
                            titleTextStyle: const TextStyle(
                                color: Colors.white, fontSize: 18),
                            leftChevronIcon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                            rightChevronIcon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18,
                            ),
                            leftChevronMargin: const EdgeInsets.only(left: 70),
                            rightChevronMargin:
                                const EdgeInsets.only(right: 70),
                          ),
                          calendarStyle: CalendarStyle(
                            selectedTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                            weekendTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                            defaultTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                            todayTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                            todayDecoration: const BoxDecoration(
                              color: Color.fromRGBO(42, 207, 198, 0.5),
                              shape: BoxShape.rectangle,
                            ),
                            selectedDecoration: const BoxDecoration(
                                color: Color.fromRGBO(42, 207, 198, 1),
                                shape: BoxShape.rectangle),
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                              weekendStyle: const TextStyle(
                                  color: Colors.white, fontSize: 15)),
                        ),
                  GestureDetector(
                    onVerticalDragUpdate: (DragUpdateDetails details) {
                      setState(() {
                        if (_isExpanded) {
                          _isExpanded = false;
                        } else {
                          _isExpanded = true;
                        }
                      });
                    },
                    child: SizedBox(
                      width: size.width,
                      child: Icon(
                        (_isExpanded)
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  child: ListView.builder(
                    itemCount: ReminderData.reminderList.length,
                    itemBuilder: (context, index) {
                      return ReminderWidget(
                        index: index,
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                  child: Container(
                    width: size.width,
                    height: size.height * 0.08,
                    color: const Color.fromRGBO(42, 207, 198, 1),
                    child: const Center(
                      child: Text(
                        'Add Reminder',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                            context: context,
                            builder: (context) => buildSheet(context))
                        .then((value) {
                      setState(() {});
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSheet(context) {
    return const AddReminder();
  }
}
