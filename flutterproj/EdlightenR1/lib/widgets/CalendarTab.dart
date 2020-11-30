import '../Constants/MyConstants.dart';
import '../utils/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/drawer.dart';

class CalenderTab extends StatefulWidget {
  @override
  _CalenderState createState() {
    return _CalenderState();
  }
}

final Map<DateTime, List> _holidays = {
  DateTime(2020, 01, 01): ['New Year\'s Day'],
  DateTime(2020, 08, 13): ['Epiphany'],
  DateTime(2020, 08, 13): ['Valentine\'s Day'],
  DateTime(2020, 08, 14): ['Easter Sunday'],
  DateTime(2020, 08, 14): ['Easter Monday'],
  DateTime(2020, 08, 17): ['Easter Monday'],
  DateTime(2020, 08, 21): ['Easter Monday'],
};

class _CalenderState extends State<CalenderTab> with TickerProviderStateMixin {
//  AnimationController controller;

//
  double width = MyConstants.width;
  double height = MyConstants.height;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['Parent Teacher Meeting'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Sports Day',
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Science Exhibition',
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: HexToColor(MyConstants.blueClr),
        leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
            child: Icon(Icons.menu, color: Colors.white)),
        title: Text(
          'Calender',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: OwnDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // Switch out 2 lines below to play with TableCalendar's settings
            //-----------------------
            _buildTableCalendar(),
            // _buildTableCalendarWithBuilders(),
            const SizedBox(height: 8.0),
//          _buildButtons(),
            const SizedBox(height: 8.0),
            _buildEventList(),
          ],
        ),
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableCalendarFormats: {
        CalendarFormat.month: '',
      },
      calendarStyle: CalendarStyle(
        selectedColor: HexToColor(MyConstants.yellowClr),
        todayColor: HexToColor(MyConstants.blueClr),
        markersColor: HexToColor(MyConstants.greyClr),
        highlightToday: true,
        outsideDaysVisible: true,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return Column(
      children: _selectedEvents
          .map((event) => Container(
              decoration: BoxDecoration(
//          border: Border.all(width: 0.8),
//          borderRadius: BorderRadius.circular(12.0),
                  ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: HexToColor(MyConstants.fadeClr),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 20, vertical: height / 40),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/img.png',
                        height: height / 15,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            event.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width / 32),
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Text(
                            'From class teacher 4F/B',
                            style: TextStyle(
                                color: Colors.grey, fontSize: width / 35),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '2-2:30 pm',
                            style: TextStyle(
                                color: Colors.grey, fontSize: width / 35),
                          ),
                          SizedBox(
                            height: height / 20,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: width / 30,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    foregroundColor: Colors.white,
                    caption: 'Delete from events',
                    color: Colors.red,
                    icon: Icons.delete_outline,
//              onTap: () => _showSnackBar('Archive'),
                  ),
                ],
              )))
          .toList(),
    );
  }
}
