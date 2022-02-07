import 'package:flutter/material.dart';

class Day extends StatelessWidget {
  final List<DateTime>? availableDates;
  final List<DateTime>? unavailableDates;
  final int day;
  final bool isSelected;
  final Function(DateTime) onPress;
  final DateTime? selectedDay;
  final DateTimeRange? selectedRange;
  final DateTime monthStartDay;
  const Day(
      {Key? key,
      required this.isSelected,
      this.availableDates,
      this.unavailableDates,
      required this.day,
      this.selectedDay,
      required this.onPress,
      this.selectedRange,
      required this.monthStartDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentday = monthStartDay.add(Duration(days: day));

    Color textColor() {
      if (currentday.isBefore(DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
        return Colors.grey;
      } else {
        if (unavailableDates != null) {
          if (unavailableDates!.contains(currentday)) {
            return Colors.grey[700]!;
          }
        }
        if (availableDates != null) {
          if (availableDates!.contains(currentday) && !isSelected) {
            return Colors.black;
          }
          if (availableDates!.contains(currentday) && isSelected) {
            return Colors.white;
          }
        }
        return Colors.black;
      }
    }

    Color boxDecorationColor() {
      if (currentday.isBefore(DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
        return Colors.transparent;
      } else {
        if (unavailableDates != null) {
          if (unavailableDates!.contains(currentday)) {
            return Colors.grey[400]!;
          }
        }
        if (availableDates != null) {
          if (availableDates!.contains(currentday) && !isSelected) {
            return Colors.white;
          }
          if (availableDates!.contains(currentday) && isSelected) {
            return Colors.black;
          }
        }
        return Colors.transparent;
      }
    }

    return Visibility(
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      visible: day != -1,
      child: GestureDetector(
          onTap: () {
            onPress(currentday);
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: boxDecorationColor(),
                    border: currentday ==
                            DateTime(DateTime.now().year, DateTime.now().month,
                                DateTime.now().day)
                        ? Border.all(color: Colors.black, width: 2)
                        : null,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                // padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                margin: const EdgeInsets.fromLTRB(4, 2, 4, 2),
              ),
              Center(
                child: Text(
                  '${day + 1}',
                  style: TextStyle(
                      color: textColor(),
                      fontSize: 14,
                      fontFamily: 'Montserrat'),
                ),
              )
            ],
          )),
    );
  }
}
