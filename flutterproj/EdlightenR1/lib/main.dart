import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'widgets/newsList.dart';
import 'utils/HexColor.dart';
import 'widgets/Home.dart';
import 'widgets/Inbox.dart';
import 'widgets/Notifications.dart';
import 'widgets/CalendarTab.dart';
import 'Constants/MyConstants.dart';
import 'package:flutter/services.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'widgets/Actions.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edlighten',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Edlighten App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    CalenderTab(),
    InboxTab(),
    NotificationTab(),
  ];

  PageController _pageController;
  Animation<double>
      _animation; //create animation controller for the Plus button animation
  AnimationController _animationController;
  bool isPlaying = false;
  double height = MyConstants.height;
  double width = MyConstants.width;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    MyConstants.width = MediaQuery.of(context).size.width;
    MyConstants.height = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: _children[_currentIndex],
      /*Scaffold(
          appBar: AppBar(
            title: Text('Timeline'),
            leading: GestureDetector(
              onTap: () {/* Write listener code here */},
              child: Icon(
                Icons.menu, // add custom icons also
              ),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.more_vert),
                  )),
            ],
          ),
          body: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: TopActionsBar(),
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 5,
              endIndent: 0,
            ),
            NewsList(),
          ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      //Init Floating Action Bubble
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "Post",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.add_a_photo,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title: "Action",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.people,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
          //Floating action menu item
          Bubble(
            title: "Home",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.home,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: () {
          isPlaying = !isPlaying;
          isPlaying
              ? _animationController.forward()
              : _animationController.reverse();
        },

        // Floating Action button Icon color
        iconColor: Colors.blue,

        // Flaoting Action button Icon
        icon: AnimatedIcons.menu_close,
      ),*/

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            //activeIcon: new Icon(Icons.home_outlined),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            //activeIcon: new Icon(Icons.calendar_view_day_outlined),
            title: Text('Events'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            //activeIcon: new Icon(Icons.inbox_outlined),
            title: Text('Inbox'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            //activeIcon: new Icon(Icons.notifications_active_outlined),
            title: Text('Notifications'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
