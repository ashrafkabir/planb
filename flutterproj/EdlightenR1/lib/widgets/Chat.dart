import 'dart:async';
import 'dart:io';

import '../Constants/MyConstants.dart';
import '../utils/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  final String peerId;
  final String peerAvatar;

  Chat({Key key, @required this.peerId, @required this.peerAvatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexToColor(MyConstants.blueClr),
        title: Text(
          'CHAT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: MyConstants.width / 30),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: ChatScreen(
        peerId: peerId,
        peerAvatar: peerAvatar,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerAvatar;

  ChatScreen({Key key, @required this.peerId, @required this.peerAvatar})
      : super(key: key);

  @override
  State createState() =>
      ChatScreenState(peerId: peerId, peerAvatar: peerAvatar);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.peerId, @required this.peerAvatar});

  String peerId;
  String peerAvatar;
  String id;

  var listMessage;
  String groupChatId;

  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);

    groupChatId = '';

//    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

//    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

//  readLocal() async {
//    prefs = await SharedPreferences.getInstance();
//    id = prefs.getString('id') ?? '';
//    if (id.hashCode <= peerId.hashCode) {
//      groupChatId = '$id-$peerId';
//    } else {
//      groupChatId = '$peerId-$id';
//    }
//
//    Firestore.instance.collection('users').document(id).updateData({'chattingWith': peerId});
//
//    setState(() {});
//  }

//  Future getImage() async {
//    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//    if (imageFile != null) {
//      setState(() {
//        isLoading = true;
//      });
//      uploadFile();
//    }
//  }

//  void getSticker() {
//    // Hide keyboard when sticker appear
//    focusNode.unfocus();
//    setState(() {
//      isShowSticker = !isShowSticker;
//    });
//  }

//  Future uploadFile() async {
//    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
//    StorageUploadTask uploadTask = reference.putFile(imageFile);
//    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
//    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
//      imageUrl = downloadUrl;
//      setState(() {
//        isLoading = false;
//        onSendMessage(imageUrl, 1);
//      });
//    }, onError: (err) {
//      setState(() {
//        isLoading = false;
//      });
//      Fluttertoast.showToast(msg: 'This file is not an image');
//    });
//  }

//  void onSendMessage(String content, int type) {
//    // type: 0 = text, 1 = image, 2 = sticker
//    if (content.trim() != '') {
//      textEditingController.clear();
//
//      var documentReference = Firestore.instance
//          .collection('messages')
//          .document(groupChatId)
//          .collection(groupChatId)
//          .document(DateTime.now().millisecondsSinceEpoch.toString());
//
//      Firestore.instance.runTransaction((transaction) async {
//        await transaction.set(
//          documentReference,
//          {
//            'idFrom': id,
//            'idTo': peerId,
//            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
//            'content': content,
//            'type': type
//          },
//        );
//      });
//      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//    } else {
//      Fluttertoast.showToast(msg: 'Nothing to send');
//    }
//  }

  Widget buildItem(int index
//      , DocumentSnapshot document
      ) {
    if (index == 1) {
      // Right (my message)
      return Row(
        children: <Widget>[
          // Text
          Container(
            child: Text(
              'Text',
              style: TextStyle(color: Colors.white),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//            width: 200.0,
            constraints: BoxConstraints(maxWidth: MyConstants.width * 0.7),
            decoration: BoxDecoration(
                color: HexToColor(MyConstants.greyClr),
                borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(
                bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
          ),
          index == 1
              ? Material(
                  child: Icon(
                    Icons.person_outline,
                    color: HexToColor(
                      MyConstants.greyClr,
                    ),
                    size: 30,
                  ),
//                  child: CachedNetworkImage(
//                    placeholder: (context, url) => Container(
//                      child: CircularProgressIndicator(
//                        strokeWidth: 1.0,
//                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                      ),
//                      width: 35.0,
//                      height: 35.0,
//                      padding: EdgeInsets.all(10.0),
//                    ),
//                    imageUrl: peerAvatar,
//                    width: 35.0,
//                    height: 35.0,
//                    fit: BoxFit.cover,
//                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                )
              : Container(width: 35.0),

          // Sticker
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
                        child: Icon(
                          Icons.person_outline,
                          color: HexToColor(
                            MyConstants.greyClr,
                          ),
                          size: 30,
                        ),
//                  child: CachedNetworkImage(
//                    placeholder: (context, url) => Container(
//                      child: CircularProgressIndicator(
//                        strokeWidth: 1.0,
//                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                      ),
//                      width: 35.0,
//                      height: 35.0,
//                      padding: EdgeInsets.all(10.0),
//                    ),
//                    imageUrl: peerAvatar,
//                    width: 35.0,
//                    height: 35.0,
//                    fit: BoxFit.cover,
//                  ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
                Container(
                  child: Text(
                    'New Text',
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  constraints: BoxConstraints(maxWidth: 200),
//                  width: 200.0,
                  decoration: BoxDecoration(
                      color: HexToColor(MyConstants.blueClr),
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(left: 10.0),
                )
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
//              child: Text(
//                DateFormat('dd MMM kk:mm')
//                    .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document['timestamp']))),
//                style: TextStyle(color: greyColor, fontSize: 12.0, fontStyle: FontStyle.italic),
//              ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
//      Firestore.instance.collection('users').document(id).updateData({'chattingWith': null});
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Sticker
              (isShowSticker ? buildSticker() : Container()),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
//          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildSticker() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                'images/mimi1.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/mimi2.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/mimi3.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              Image.asset(
                'images/mimi4.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/mimi5.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/mimi6.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              Image.asset(
                'images/mimi7.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/mimi8.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              Image.asset(
                'images/mimi9.gif',
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: HexToColor(MyConstants.greyClr), width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

//  Widget buildLoading() {
//    return Positioned(
//      child: isLoading ? const Loading() : Container(),
//    );
//  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: MyConstants.width / 50),
              child: Icon(
                Icons.attach_file,
                color: Colors.grey,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.only(right: MyConstants.width / 50),
              child: Icon(Icons.face, color: Colors.grey),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
//                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
//                  hintStyle: TextStyle(color: greyColor),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.send,
                color: HexToColor(MyConstants.blueClr),
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: HexToColor(MyConstants.greyClr), width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child:
//      groupChatId == ''
//          ? Center(child: CircularProgressIndicator())
//          :
          StreamBuilder(
//        stream: Firestore.instance
//            .collection('messages')
//            .document(groupChatId)
//            .collection(groupChatId)
//            .orderBy('timestamp', descending: true)
//            .limit(20)
//            .snapshots(),
        builder: (context, snapshot) {
//          if (!snapshot.hasData) {
//            return Center(
//                child: CircularProgressIndicator());
//          } else {
//            listMessage = snapshot.data.documents;
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemBuilder: (context, index) => buildItem(index
//                  , snapshot.data.documents[index]
                ),
            itemCount: 2,
            reverse: true,
            controller: listScrollController,
          );
//          }
        },
      ),
    );
  }
}
