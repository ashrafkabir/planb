import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/newsArticle.dart';
import '../services/webservice.dart';
import 'package:flutter_complete_guide/Constants/MyConstants.dart';
import 'package:flutter_complete_guide/utils/HexColor.dart';
import 'package:flutter/cupertino.dart';

class NewsListState extends State<NewsList> {
  double width = MyConstants.width;
  double height = MyConstants.height;
  List<NewsArticle> timelinePosts = List<NewsArticle>();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() {
    Webservice().load(NewsArticle.all).then((newsArticles) => {
          setState(() => {timelinePosts = newsArticles})
        });
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      leading: Container(
          child: CircleAvatar(
        backgroundImage: NetworkImage("https://i.imgur.com/5kxRZZ4.png"),
      )),
      title: Container(
          child: Text(timelinePosts[index].Post_Title,
              style: TextStyle(fontSize: 18))),
      subtitle: Container(
          child: Text(timelinePosts[index].Post_Body,
              style: TextStyle(fontSize: 12))),
      isThreeLine: true,
      dense: true,
      trailing: Container(child: Icon(Icons.keyboard_arrow_right)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Timeline'),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: timelinePosts.length,
              itemBuilder: (BuildContext context, int position) {
                return Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/img.png',
                          width: width / 8,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: width / 30,
                        ), // this creates space between image and the text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // this aligns the children vertically i.e. the Author and the two texts.
                          children: <Widget>[
                            Text(
                              timelinePosts[position].Post_Author,
                              style: TextStyle(
                                  color: HexToColor(MyConstants.greyClr),
                                  fontWeight: FontWeight.bold,
                                  fontSize: width / 22),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Class Incharge - ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: width / 30),
                                ),
                                Text(
                                  timelinePosts[position].Post_Type,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.underline,
                                      fontSize: width / 35),
                                ),
                              ],
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ), // this is used to fill up the space between date and the leading text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .end, // this aligns the children towards the end
                          children: <Widget>[
                            Icon(
                              Icons.more_horiz,
                              color: Colors.grey,
                            ),
                            Text(
                              DateTime.parse(timelinePosts[position].Post_Time)
                                      .hour
                                      .toString() +
                                  ' : ' +
                                  DateTime.parse(
                                          timelinePosts[position].Post_Time)
                                      .minute
                                      .toString() +
                                  ' ' +
                                  DateTime.parse(
                                          timelinePosts[position].Post_Time)
                                      .day
                                      .toString() +
                                  '/' +
                                  DateTime.parse(
                                          timelinePosts[position].Post_Time)
                                      .month
                                      .toString() +
                                  '/' +
                                  DateTime.parse(
                                          timelinePosts[position].Post_Time)
                                      .year
                                      .toString(),
                              style: TextStyle(
                                  color: Colors.grey, fontSize: width / 30),
                            ),
                          ],
                        )
                      ],
                    ),
                    //SizedBox(height: height/100,), //no need for extra space here.

                    Padding(
                      // this allows a padding around the post image.
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 100),
                      child: Image.asset(
                        'assets/classroom.jpg',
                        width: width,
                        fit: BoxFit.fill,
                      ),
                    ),

                    Padding(
                      // this allows a padding around the text.
                      padding: EdgeInsets.symmetric(
                          horizontal: width / 20, vertical: height / 100),
                      child: Text(
                        timelinePosts[position].Post_Body,
                        style:
                            TextStyle(color: Colors.grey, fontSize: width / 30),
                      ),
                    ),
                    Container(
                      height:
                          height / 45, //this button should appear in proportion
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: HexToColor(MyConstants.fadeClr),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/thumbsup.png',
                                      height: height / 35,
                                    ),
                                    SizedBox(
                                      width: width / 30,
                                    ),
                                    Text(
                                      'Like',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: width / 30),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.grey,
                            width: 1,
                          ),
                          Expanded(
                            child: Container(
                              color: HexToColor(MyConstants.fadeClr),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/comment.png',
                                      height: height / 35,
                                    ),
                                    SizedBox(
                                      width: width / 30,
                                    ),
                                    Text(
                                      'Comment',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: width / 30),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                  ],
                );
              }),
        ));
  }
}

class NewsList extends StatefulWidget {
  @override
  createState() => NewsListState();
}
