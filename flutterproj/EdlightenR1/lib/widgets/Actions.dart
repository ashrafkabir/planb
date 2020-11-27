import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Constants/MyConstants.dart';
import '../utils/HexColor.dart';
import 'package:flutter/cupertino.dart';

class ActionsState extends State {
  double width = MyConstants.width;
  double height = MyConstants.height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.14,
      child: Padding(
        // this allows a padding around the text.
        padding: EdgeInsets.symmetric(horizontal: width / 20),
        child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int position) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  width: width * 0.7,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height * 0.1,
                        width: 4,
                        color: HexToColor(MyConstants.lightGreenClr),
                      ),
                      SizedBox(
                        width: width / 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.grey,
                                size: width / 12,
                              ),
                              SizedBox(
                                width: width / 70,
                              ),
                              Text(
                                '2-2:30 pm',
                                style: TextStyle(
                                    // style: TextStyle(fontFamily: 'neue'),
                                    color: Colors.grey,
                                    fontSize: width / 30),
                              ),
                              SizedBox(
                                width: width / 9,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: HexToColor(MyConstants.greyClr),
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  'Maths',
                                  style: TextStyle(
                                      fontFamily: 'neue', color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Text(
                            'Maths - Chapter 3 - Pg 21',
                            style: TextStyle(
                                color: Colors.grey, fontSize: width / 27),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: width / 100,
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color:
                                        HexToColor(MyConstants.lightGreenClr),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              SizedBox(
                                width: width / 100,
                              ),
                              Text(
                                'ONLINE CLASS LIVE',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: width / 27),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class TopActionsBar extends StatefulWidget {
  @override
  createState() => ActionsState();
}
