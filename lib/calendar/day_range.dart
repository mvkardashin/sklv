import 'package:flutter/material.dart';

class DayRange extends StatelessWidget {
  final List<DateTime>? availableDates;
  final List<DateTime>? unavailableDates;
  final int day;
  final bool isSelected;
  final Function(DateTime) onPress;
  final DateTime? selectedDay;
  final DateTimeRange? selectedRange;
  final DateTime monthStartDay;
  const DayRange(
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
      if (selectedRange != null) {
        if (currentday == selectedRange!.start ||
            currentday == selectedRange!.end) {
          return Colors.white;
        } else
          return Colors.black;
      }
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
      if (selectedRange != null) {
        if (currentday.isAfter(selectedRange!.start) &&
            currentday.isBefore(selectedRange!.end)) {
          return Colors.grey[400]!;
        } else {
          if (currentday == selectedRange!.start ||
              currentday == selectedRange!.end) {
            return Colors.black;
          } else {
            return Colors.transparent;
          }
        }
      } else {
        return Colors.transparent;
      }
    }

    BorderRadius boxBorderRadius() {
      BorderRadius borderRadius = BorderRadius.all(Radius.circular(0));
      Radius defaultRadius = Radius.circular(8);
      if (selectedRange != null) {
        if (currentday == selectedRange!.start ||
            currentday == selectedRange!.end) {
          borderRadius = borderRadius.copyWith(
              topLeft: defaultRadius,
              topRight: defaultRadius,
              bottomLeft: defaultRadius,
              bottomRight: defaultRadius);
        }
        if (currentday.weekday == 1) {
          borderRadius = borderRadius.copyWith(
            topLeft: defaultRadius,
            bottomLeft: defaultRadius,
          );
        }
        if (currentday.weekday == 7) {
          borderRadius = borderRadius.copyWith(
            topRight: defaultRadius,
            bottomRight: defaultRadius,
          );
        }
        if (currentday == DateTime(currentday.year, currentday.month, 1)) {
          borderRadius = borderRadius.copyWith(
            topLeft: defaultRadius,
            bottomLeft: defaultRadius,
          );
        }
        if (currentday == DateTime(currentday.year, currentday.month + 1, 0)) {
          borderRadius = borderRadius.copyWith(
            topRight: defaultRadius,
            bottomRight: defaultRadius,
          );
        }
      }
      return borderRadius;
    }

    Border? boxborder() {
      if (selectedRange != null) {
        if (currentday == selectedRange!.start ||
            currentday == selectedRange!.end) {
          return Border.all(color: Colors.black, width: 2);
        }
      }
    }

    EdgeInsets boxMargin() {
      if (selectedRange != null) {
        if (currentday == selectedRange!.start ||
            currentday == selectedRange!.end) {
          return EdgeInsets.all(0);
        }
      }
      return const EdgeInsets.fromLTRB(0, 2, 0, 2);
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
                      border: boxborder(),
                      borderRadius: boxBorderRadius()),
                  margin: boxMargin()),
              Center(
                  child: Text(
                '${day + 1}',
                style: TextStyle(
                    color: textColor(), fontSize: 14, fontFamily: 'Montserrat'),
              )),
            ],
          )),
    );
  }
}
