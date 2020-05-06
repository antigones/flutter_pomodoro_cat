import 'package:flutter/material.dart';
import 'package:flutterpomodorocat/pomodoro_widget.dart';

class LongPausePage extends StatefulWidget {
  LongPausePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LongPausePageState createState() => _LongPausePageState();
}

class _LongPausePageState extends State<LongPausePage> {
  Duration _timeout = new Duration(minutes: 10);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 25),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset('assets/cat-relax-long.png'),
              ),
            ),
            PomodoroWidget(duration: _timeout),
            SizedBox(height: 25)
          ],
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
