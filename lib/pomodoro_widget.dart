import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class PomodoroWidget extends StatefulWidget {
  PomodoroWidget({Key key, this.duration}) : super(key: key);

  final Duration duration;

  @override
  _PomodoroWidgetState createState() => _PomodoroWidgetState();
}

class _PomodoroWidgetState extends State<PomodoroWidget> with SingleTickerProviderStateMixin {
  CountdownTimer _pomodoroTimer;
  StreamSubscription<CountdownTimer> _subPomodoro;
  bool _pomodoroStarted;
  Duration _timeout;
  Duration _step = Duration(seconds: 1);
  String _countdownStr;
  Duration _countdown;

  static AudioCache player = AudioCache();

  void _formatDuration(Duration duration) {
    String twoDigitMinutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    setState(() {
      _countdownStr = "$twoDigitMinutes:$twoDigitSeconds";
    });
  }

  @override
  void initState() {
    print('initState pomodoroPage');
    _timeout = widget.duration;
    _formatDuration(_timeout);
    _countdown = _timeout;
    _pomodoroStarted = false;

    super.initState();
  }

  void _updateCountdown(CountdownTimer countdownTimer) {
    _formatDuration(countdownTimer.remaining);
    _countdown = countdownTimer.remaining;
  }

  void _resetCountdown() {
    _formatDuration(_timeout);
  }

  void _playSound() {
    player.play('goes-without-saying.mp3');
  }

  void _startPomodoro(Duration timeout) {
    if (timeout.inMilliseconds <= 0) {
      print('time to start again!');
      _resetPomodoro();
      timeout = _timeout;
    }

    if (!_pomodoroStarted) {
      print('pomocat start!');
      _pomodoroStarted = true;
      _pomodoroTimer = CountdownTimer(timeout, _step);
      _updateCountdown(_pomodoroTimer);
      _subPomodoro = _pomodoroTimer.listen(null);
      _subPomodoro.onData((duration) {
        _updateCountdown(duration);
      });

      _subPomodoro.onDone(() {
        _endPomodoro(true);
      });
    } else {
      print('pomocat already started!');
    }
  }

  void _endPomodoro(bool withSound) {
    print("pomocat end!");
    if (withSound) {
      _playSound();
    }
    _subPomodoro?.cancel();
    _pomodoroTimer?.cancel();
    _pomodoroStarted = false;
  }

  void _stopPomodoro() {
    _endPomodoro(false);
  }

  void _resetPomodoro() {
    _endPomodoro(false);
    _countdown = _timeout;
    _resetCountdown();
  }

  @protected
  @mustCallSuper
  void dispose() {
    print('dispose pomodoro page');
    _endPomodoro(false);
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$_countdownStr',
            style: TextStyle(fontSize: 40.0, fontFamily: 'Pacifico')),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FlatButton(
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FlatButton(
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FlatButton(
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
            ),
          ],
        ),
      ],
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
