//import 'dart:html';

import '../Constants/MyConstants.dart';

import 'package:http/http.dart' as http;

import '../utils/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/drawer.dart';
import '../models/Event.dart';
import '../services/webservice.dart';

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
  List<Event> devents = new List<Event>(); // for events from dynamodb

  Map<DateTime, List> _events = {};
  List<Event> _selectedEvents = List<Event>();
  AnimationController _animationController;
  CalendarController _calendarController;
  var _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    _populateEvents();

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _populateEvents() async {
    devents = await Webservice().load(Event.all);
    print('CALLBACK: _onpopulateEvents');

    devents.forEach((element) {
      _events[DateTime.parse(element.Event_From_Date)] = [element];
    });
    _selectedEvents = devents;

    setState(() {});
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedDay = day;

      _selectedEvents = devents
          .where((element) =>
              DateTime.parse(element.Event_From_Date).year ==
                  _selectedDay.year &&
              DateTime.parse(element.Event_From_Date).month ==
                  _selectedDay.month &&
              DateTime.parse(element.Event_From_Date).day == _selectedDay.day)
          .toList();
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
    _selectedDay = last.subtract(new Duration(days: 14));

    setState(() {
      _selectedEvents = devents
          .where((element) =>
              DateTime.parse(element.Event_From_Date).year ==
                  _selectedDay.year &&
              DateTime.parse(element.Event_From_Date).month ==
                  _selectedDay.month)
          .toList();
    });
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
          'Calendar',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: OwnDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
      mainAxisSize: MainAxisSize.min,
      children: _selectedEvents
          .map(
            (event) => Container(
              decoration: BoxDecoration(
//          border: Border.all(width: 0.8),
//          borderRadius: BorderRadius.circular(12.0),
                  ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: HexToColor(MyConstants.fadeClr),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: width / 40, vertical: height / 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /*Image.asset(
                        'assets/img.png',
                        width: width / 30,
                        fit: BoxFit.scaleDown,
                      ),*/
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: width / 100,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              event.Event_Name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width / 40),
                            ),
                            SizedBox(
                              height: height / 200,
                              width: width / 100,
                            ),
                            Text(
                              event.Event_Desc,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: width / 35),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              width: width / 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: width / 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    foregroundColor: Colors.white,
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete_outline,
//              onTap: () => _showSnackBar('Archive'),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
