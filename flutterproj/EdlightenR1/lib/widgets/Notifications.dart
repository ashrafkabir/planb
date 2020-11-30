import '../Constants/MyConstants.dart';
import '../utils/HexColor.dart';
import 'drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationTab extends StatefulWidget {
  @override
  _NotificationState createState() {
    return _NotificationState();
  }
}

class _NotificationState extends State<NotificationTab> {
//  AnimationController controller;

//
  double width = MyConstants.width;
  double height = MyConstants.height;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: HexToColor(MyConstants.blueClr),
        leading: GestureDetector(
            onTap: () => _scaffoldKey.currentState.openDrawer(),
            child: Icon(Icons.menu, color: Colors.white)),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
//            SvgPicture.asset('assets/profile.svg',width: width/20,fit: BoxFit.fill,),
        ],
      ),
      drawer: OwnDrawer(),
      body: ListView.builder(
        itemCount: 7,
//        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width / 15, vertical: height / 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person_outline,
                      size: width / 12,
                      color: HexToColor(MyConstants.greyClr),
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'here is the notification text - ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'another text',
                                        style: TextStyle(
                                            color:
                                                HexToColor(MyConstants.blueClr),
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Just Now',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              )
            ],
          );
        },
      ),
    );
  }
}
