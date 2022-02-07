import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sklv/blocs/characters/characters.dart';
import 'package:sklv/calendar/calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:sklv/rickanmorty/list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime? selected;
  DateTimeRange? range;
  final CharactersBloc _characters = CharactersBloc();
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(
              selected: selected,
              range: range,
            ),
        '/calendar': (context) => Calendar(
              onPress: (val) {
                setState(() {
                  selected = val;
                });
              },
              type: CalendarType.day,
              unavailableDates: <DateTime>[DateTime(2022, 2, 8)],
              availableDates: <DateTime>[
                DateTime(2022, 2, 9),
                DateTime(2022, 2, 10)
              ],
            ),
        '/rangecalendar': (context) => Calendar(
              onRange: (val) {
                setState(() {
                  range = val;
                });
              },
              type: CalendarType.range,
              unavailableDates: <DateTime>[DateTime(2022, 2, 8)],
              availableDates: <DateTime>[
                DateTime(2022, 2, 9),
                DateTime(2022, 2, 10)
              ],
            ),
        '/riackandmorty': (context) => BlocProvider<CharactersBloc>(
              create: (context) => CharactersBloc(),
              child: RickAndMortyScreen(),
            )
      },
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     DateTime f = DateTime(2022, 2, 8);
//     return CupertinoApp(
//       title: 'Flutter Demo',
//       initialRoute: '/',
//       routes: {
//         // When navigating to the "/" route, build the FirstScreen widget.
//         '/': (context) => const MyHomePage(),
//         '/calendar': (context) => Calendar(
//               type: CalendarType.day,
//               unavailableDates: <DateTime>[DateTime(2022, 2, 8)],
//               availableDates: <DateTime>[
//                 DateTime(2022, 2, 9),
//                 DateTime(2022, 2, 10)
//               ],
//             )
//       },
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  final DateTime? selected;
  final DateTimeRange? range;
  const MyHomePage({
    this.selected,
    this.range,
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: const Text('Календарь'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.selected.toString()),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/calendar');
                },
                child: const Text('К календарю')),
            Text(widget.range.toString()),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/rangecalendar');
                },
                child: const Text('К календарю')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/riackandmorty');
                },
                child: const Text('Рик и Морти'))
          ],
        ),
      ),
    );
  }
}
