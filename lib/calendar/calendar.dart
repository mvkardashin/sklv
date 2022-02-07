import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sklv/calendar/day.dart';
import 'package:sklv/calendar/day_range.dart';
import 'package:sklv/calendar/utils/month_converter.dart';

enum CalendarType { range, day }

class Calendar extends StatefulWidget {
  final CalendarType type;
  final List<DateTime>? availableDates;
  final List<DateTime>? unavailableDates;
  final Function(DateTime?)? onPress;
  final Function(DateTimeRange?)? onRange;
  const Calendar(
      {Key? key,
      required this.type,
      this.availableDates,
      this.unavailableDates,
      this.onRange,
      this.onPress})
      : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selected;
  DateTimeRange? range;
  DateTime? startDay;
  DateTime? stopDay;
  final int months = 6;
  final DateTime now = DateTime.now();
  final DateTime start = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.grey[100],
        navigationBar: const CupertinoNavigationBar(
          middle: Text(
            'Выберите дату',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
        child: SafeArea(
            child: Column(
          children: [
            Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(20, 6, 20, 6),
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Пн',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            height: 1.25,
                            color: Colors.grey[300])),
                    Text('Вт',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            height: 1.25,
                            color: Colors.grey[300])),
                    Text('Ср',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            height: 1.25,
                            color: Colors.grey[300])),
                    Text('Чт',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            height: 1.25,
                            color: Colors.grey[300])),
                    Text('Пт',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            height: 1.25,
                            color: Colors.grey[300])),
                    Text('Сб',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            height: 1.25,
                            color: Colors.grey[300])),
                    Text('Вс',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            height: 1.25,
                            color: Colors.grey[300])),
                  ],
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: months,
                    itemBuilder: (context, month) {
                      DateTime newDate = MonthService.plusMonths(month);

                      int remainingDaysOfTheMonth() {
                        DateTime lastDayOfMonth =
                            DateTime(newDate.year, newDate.month + 1, 0);
                        Duration difference =
                            lastDayOfMonth.difference(newDate);
                        return difference.inDays + 1;
                      }

                      int daysinMonths = remainingDaysOfTheMonth();
                      List arrayofDays =
                          List.generate(daysinMonths, (index) => index);
                      int weekday = newDate.weekday;

                      List emptyDays =
                          List.filled(weekday - 1, -1, growable: true);
                      emptyDays.addAll(arrayofDays);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                MonthService.converter(newDate.month) + ' ',
                                style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 14),
                              ),
                              Text(newDate.year.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700))
                            ],
                          ),
                          GridView.count(
                            padding: EdgeInsets.all(20),
                            childAspectRatio: 1.5,
                            crossAxisCount: 7,
                            physics:
                                const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                            shrinkWrap: true,
                            children: emptyDays
                                .map((e) => widget.type == CalendarType.day
                                    ? Day(
                                        unavailableDates:
                                            widget.unavailableDates,
                                        availableDates: widget.availableDates,
                                        isSelected: selected ==
                                            newDate.add(Duration(days: e)),
                                        day: e,
                                        onPress: (val) {
                                          setState(() {
                                            selected = val;
                                          });
                                          if (widget.availableDates != null) {
                                            if (widget.availableDates!
                                                .contains(selected)) {
                                              widget.onPress!(selected!);
                                            } else {
                                              widget.onPress!(null);
                                            }
                                          }
                                        },
                                        monthStartDay: newDate)
                                    : DayRange(
                                        selectedRange: range,
                                        unavailableDates:
                                            widget.unavailableDates,
                                        availableDates: widget.availableDates,
                                        isSelected: selected ==
                                            newDate.add(Duration(days: e)),
                                        day: e,
                                        onPress: (val) {
                                          if (startDay == null &&
                                              stopDay == null) {
                                            setState(() {
                                              startDay = val;
                                              stopDay = val;
                                            });
                                          } else {
                                            if (val.isBefore(startDay!)) {
                                              setState(() {
                                                startDay = val;
                                              });
                                            }
                                            if (val.isAfter(stopDay!)) {
                                              setState(() {
                                                stopDay = val;
                                              });
                                            }
                                            if (val.isAfter(startDay!) &&
                                                val.isBefore(stopDay!)) {
                                              setState(() {
                                                startDay = val;
                                              });
                                            }
                                          }
                                          range = DateTimeRange(
                                              start: startDay!, end: stopDay!);
                                          widget.onRange!(range);
                                        },
                                        monthStartDay: newDate))
                                .toList(),
                          )
                        ],
                      );
                    }))
          ],
        )));
  }
}
