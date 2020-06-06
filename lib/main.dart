import 'package:flutter/material.dart';
import 'package:flutterpomodorocat/about_page.dart';
import 'package:flutterpomodorocat/long_pause_page.dart';
import 'package:flutterpomodorocat/pomodoro_page.dart';
import 'package:flutterpomodorocat/short_pause_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Cat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pomodoro Cat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  ValueNotifier tabIndexNotifier;
  List<Widget> tabs;

  final initialIndex = 0;

  @override
  void initState() {
    tabIndexNotifier = ValueNotifier(initialIndex);

    tabs = <Widget>[
      PomodoroPage(),
      ShortPausePage(),
      LongPausePage(),
      AboutPage()
    ];

    tabController = TabController(
      initialIndex: initialIndex,
      vsync: this,
      length: tabs.length,
    )..addListener(
          () {
        tabIndexNotifier.value = tabController.index;
      },
    );
    tabIndexNotifier = ValueNotifier(initialIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange[500],
      ),
      body: TabBarView(
        controller: tabController,
        children: tabs,
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: tabIndexNotifier,
          builder: (context, index, _) {
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.access_time),
                  title: Text('Pomodoro'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pause_circle_outline),
                  title: Text('Short pause'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pause_circle_filled),
                  title: Text('Long pause'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info),
                  title: Text('About'),
                ),
              ],
              currentIndex: index,
              selectedItemColor: Colors.deepOrange[500],
              unselectedItemColor: Colors.grey,
              //backgroundColor: Colors.grey[200]
              showUnselectedLabels: true,
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              onTap: (index) {
                tabController.index = index;
              },
            );
          }),
    );
  }
}