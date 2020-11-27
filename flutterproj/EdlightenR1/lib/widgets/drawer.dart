import '../Constants/MyConstants.dart';
import '../utils/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OwnDrawer extends StatefulWidget {
  @override
  _DrawerState createState() {
    // TODO: implement createState
    return _DrawerState();
  }
}

class _DrawerState extends State<OwnDrawer> {
  double width = MyConstants.width;
  double height = MyConstants.height;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: width * 0.7,
      child: Drawer(
        child: SafeArea(
          child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/left_logo.png',
                      width: width / 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      height: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      children: <Widget>[
                        new RichText(
                          text: new TextSpan(
                            text: 'Welcome ',
                            style: TextStyle(
                                fontFamily: 'neue Medium',
                                fontSize: width / 30,
                                color: Colors.grey),
                            children: <TextSpan>[
                              new TextSpan(
                                  text: 'Mr User',
                                  style: TextStyle(
                                      fontFamily: 'neue Medium',
                                      fontSize: width / 30,
                                      color: HexToColor(MyConstants.greyClr))),
                              new TextSpan(
                                  text: ' to Edlighten App.',
                                  style: TextStyle(
                                      fontFamily: 'neue Medium',
                                      fontSize: width / 30,
                                      color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: width * 0.7,
                  color: HexToColor(MyConstants.yellowClr),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width / 30, vertical: height / 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.white,
                                size: width / 12,
                              ),
                              SizedBox(
                                width: width / 30,
                              ),
                              Text('Home',
                                  style: TextStyle(
                                      fontFamily: 'neue',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: width / 22))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/homework');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: height / 50),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  color: Colors.white,
                                  size: width / 12,
                                ),
                                SizedBox(
                                  width: width / 30,
                                ),
                                Text('Homework',
                                    style: TextStyle(
                                        fontFamily: 'neue',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: width / 22))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.white,
                                size: width / 12,
                              ),
                              SizedBox(
                                width: width / 30,
                              ),
                              Text('Attendance',
                                  style: TextStyle(
                                      fontFamily: 'neue',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: width / 22))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/parentHomework');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: height / 50),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  color: Colors.white,
                                  size: width / 12,
                                ),
                                SizedBox(
                                  width: width / 30,
                                ),
                                Text('Fee / Accounts',
                                    style: TextStyle(
                                        fontFamily: 'neue',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: width / 22))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                //MyConstants.showAlertDialog(context);
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.symmetric(vertical: height / 50),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.exit_to_app,
                                      color: Colors.white,
                                      size: width / 12,
                                    ),
                                    SizedBox(
                                      width: width / 30,
                                    ),
                                    Text('Logout',
                                        style: TextStyle(
                                            fontFamily: 'neue',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: width / 22))
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/selectProfile');
                                },
                                child: Icon(
                                  Icons.person_outline,
                                  size: width / 8,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
