import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../Constants/MyConstants.dart';
import '../widgets/Chat.dart';
import '../utils/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InboxTab extends StatefulWidget {
  final String currentUserId;

  InboxTab({Key key, @required this.currentUserId}) : super(key: key);

  @override
  State createState() => _InboxState(currentUserId: currentUserId);
}

class _InboxState extends State<InboxTab> {
  _InboxState({Key key, @required this.currentUserId});

  final String currentUserId;
//  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//  final GoogleSignIn googleSignIn = GoogleSignIn();

//  bool isLoading = false;
//  List<Choice> choices = const <Choice>[
//    const Choice(title: 'Settings', icon: Icons.settings),
//    const Choice(title: 'Log out', icon: Icons.exit_to_app),
//  ];

  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }

  Future<Null> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding:
                EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: HexToColor(MyConstants.blueClr),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Exit app',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Are you sure to exit app?',
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 0);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: HexToColor(MyConstants.blueClr),
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'CANCEL',
                      style: TextStyle(
                          color: HexToColor(MyConstants.blueClr),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: HexToColor(MyConstants.blueClr),
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'YES',
                      style: TextStyle(
                          color: HexToColor(MyConstants.blueClr),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexToColor(MyConstants.blueClr),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Inbox',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: MyConstants.width / 20),
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          // List
          Container(
            child: StreamBuilder(
//                stream: Firestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
//                if (!snapshot.hasData) {
//                  return Center(
//                    child: CircularProgressIndicator(
////                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                    ),
//                  );
//                } else
//                  {
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) => buildItem(context
//                          , snapshot.data.documents[index]
                      ),
                  itemCount: 3,
                );
//                }
              },
            ),
          ),

          // Loading
//            Positioned(
//              child: isLoading ? const Loading() : Container(),
//            )
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context
//      , DocumentSnapshot document
      ) {
    if (0 != 0) {
      return Container();
    } else {
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
//              Material(
//                child: document['photoUrl'] != null
//                    ? CachedNetworkImage(
//                  placeholder: (context, url) => Container(
//                    child: CircularProgressIndicator(
//                      strokeWidth: 1.0,
//                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                    ),
//                    width: 50.0,
//                    height: 50.0,
//                    padding: EdgeInsets.all(15.0),
//                  ),
//                  imageUrl: document['photoUrl'],
//                  width: 50.0,
//                  height: 50.0,
//                  fit: BoxFit.cover,
//                )
//                    :
              Icon(
                Icons.account_circle,
                size: 50.0,
                color: HexToColor(MyConstants.greyClr),
              ),
//                borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                clipBehavior: Clip.hardEdge,
//              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Nickname',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'last message text checking for the user that how much space will it take',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: HexToColor(MyConstants.greyClr),
                              fontSize: 10),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
              Container(
                width: 0.5,
                color: Colors.grey,
                height: 30,
                margin:
                    EdgeInsets.symmetric(horizontal: MyConstants.width / 50),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '12 DEC',
                    style: TextStyle(
                      fontSize: 12,
                      color: HexToColor(MyConstants.greyClr),
                    ),
                  ),
                  Text(
                    '11:10 PM',
                    style: TextStyle(
                      fontSize: 12,
                      color: HexToColor(MyConstants.greyClr),
                    ),
                  ),
                ],
              )
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chat(
                          peerId: '0',
                          peerAvatar: '',
                        )));
          },
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 5.0),
      );
    }
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
