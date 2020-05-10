import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image.asset('assets/cat-relax-about.png'),
                ),
              ),
              Text(
                'Pomodoro Cat!',
                style: TextStyle(fontSize: 30.0, fontFamily: 'Pacifico'),
              ),
              Text(
                'A pomodoro app by Juna Salviati',
                style: TextStyle(fontSize: 18.0, fontFamily: 'Arimo'),
              ),
              Text(
                'Made with <3 with Flutter',
                style: TextStyle(fontSize: 18.0, fontFamily: 'Arimo'),
              ),
              Text(
                'Ginger Cat by https://icons8.com',
                style: TextStyle(fontSize: 18.0, fontFamily: 'Arimo'),
              ),
            ],
          ),
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
