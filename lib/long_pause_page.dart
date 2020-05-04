import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

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
  CountdownTimer _longPauseTimer;
  StreamSubscription<CountdownTimer> _subLongPause;
  bool _longPauseStarted;
  Duration _timeout = new Duration(minutes: 10);
  Duration _step = new Duration(seconds: 1);
  String _countdownStr;
  Duration _countdown;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    // TODO: implement initState
    print('initState');
    _countdownStr = _formatDuration(_timeout);
    _countdown = _timeout;
    _longPauseStarted = false;

    super.initState();
  }

  _checkSessionCompleted() {
    if (_countdown.inSeconds == 0) return true;
    return false;
  }

  void _updateCountdown(CountdownTimer duration) {
    setState(() {
      // Make it start from the timeout value
      _countdownStr = _formatDuration(duration.remaining);
      _countdown = duration.remaining;
    });
  }

  void _resetCountdown() {
    setState(() {
      // Make it start from the timeout value
      _countdownStr = _formatDuration(_timeout);
    });
  }

  void _startPomodoro(Duration timeout) {
    if (timeout.inMilliseconds <= 0) {
      print('time to start again!');
      _resetPomodoro();
      timeout = _timeout;
    }

    if (!_longPauseStarted) {
      _longPauseStarted = true;
      print('pomocat long start!');
      _longPauseTimer = new CountdownTimer(timeout, _step);
      _subLongPause = _longPauseTimer.listen(null);
      _subLongPause.onData((duration) {
        _updateCountdown(duration);
      });

      _subLongPause.onDone(() {
        _endPomodoro();
      });
    } else {
      print('already started');
      //_endPomodoro();
    }
  }

  void _endPomodoro() {
    print("pomocat long end!");
    _subLongPause?.cancel();
    _longPauseTimer?.cancel();
    _longPauseStarted = false;
  }

  void _stopPomodoro() {
    _endPomodoro();
  }

  void _resetPomodoro() {
    _endPomodoro();
    _countdown = _timeout;
    _resetCountdown();
  }

  @protected
  @mustCallSuper
  void dispose() {
    print('dispose pomodoro long page');
    _endPomodoro();
    super.dispose();
  }

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
            Text('$_countdownStr',
                style: TextStyle(fontSize: 40.0, fontFamily: 'Pacifico')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  color: Colors.deepOrange[500],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.deepOrangeAccent,
                  onPressed: () {
                    _startPomodoro(_countdown);
                  },
                  child: Text(
                    'Start',
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Pacifico'),
                  ),
                ),
                FlatButton(
                  color: Colors.deepOrange[500],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.deepOrangeAccent,
                  onPressed: () {
                    _stopPomodoro();
                  },
                  child: Text(
                    'Stop',
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Pacifico'),
                  ),
                ),
                FlatButton(
                  color: Colors.deepOrange[500],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.deepOrangeAccent,
                  onPressed: () {
                    _resetPomodoro();
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Pacifico'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25)
          ],
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
