import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumStepper extends StatefulWidget {
  final double width;
  final totalSteps;
  final int curStep;
  final Color stepCompColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;

  const NumStepper(
      {super.key,
      required this.width,
      this.totalSteps,
      required this.curStep,
      required this.stepCompColor,
      required this.currentStepColor,
      required this.inactiveColor,
      required this.lineWidth})
      : assert(curStep > 0 == true && curStep <= totalSteps + 1);

  @override
  State<NumStepper> createState() => _NumStepperState();
}

class _NumStepperState extends State<NumStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: widget.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _steps(),
      ),
    );
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    int select = 0;
    for (int i = 0; i < widget.totalSteps; i++) {
      var circleColor = getCircleColor(i);
      var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      list.add(InkWell(
        onTap: () {
          setState(() {});
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: circleColor,
                  borderRadius: BorderRadius.all(const Radius.circular(25.0)),
                  border: Border.all(color: borderColor, width: 2.0)),
              child: getInnerElemetnOfStepper(i),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 55,
              child: Text(
                (select == 0)
                    ? "PATIENT INFO"
                    : (select == 1)
                        ? "IMAGE"
                        : (select == 2)
                            ? "ANALYSIS"
                            : "RESULT",
                style: TextStyle(
                  color: borderColor,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ));
      select++;
      if (i != widget.totalSteps - 1) {
        list.add(Expanded(
            child: Container(
          height: widget.lineWidth,
          color: lineColor,
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 25),
        )));
      }
    }
    return list;
  }

  Widget getInnerElemetnOfStepper(index) {
    if (index + 1 < widget.curStep) {
      return Icon(
        Icons.check,
        color: widget.stepCompColor,
        size: 20.0,
      );
    } else if (index + 1 == widget.curStep) {
      return Center(
        child: Text(
          '${widget.curStep}',
          style: const TextStyle(color: Colors.black, fontSize: 22),
        ),
      );
    } else
      return Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(color: widget.inactiveColor, fontSize: 22),
        ),
      );
  }

  getCircleColor(int i) {
    Color color;
    if (i + 1 < widget.curStep) {
      color = Colors.transparent;
    } else if (i + 1 == widget.curStep)
      color = widget.currentStepColor;
    else
      color = Colors.transparent;
    return color;
  }

  getBorderColor(int i) {
    Color color;
    if (i + 1 < widget.curStep) {
      color = widget.stepCompColor;
    } else if (i + 1 == widget.curStep)
      color = widget.currentStepColor;
    else
      color = widget.inactiveColor;

    return color;
  }

  getLineColor(int i) {
    var color = widget.curStep > i + 1
        ? const Color.fromRGBO(76, 239, 19, 1)
        : const Color.fromRGBO(188, 188, 188, 1);
    return color;
  }
}
