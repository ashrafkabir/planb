import 'dart:convert';
import '../services/webservice.dart';

class NewsArticle {
  final String Post_Id;
  final String Class_Id;
  final String Post_Audience;
  final String Post_Category;
  final String Post_Type;
  final String Post_Time;
  final String Post_Title;
  final String Post_Pic;
  final String Post_Author;
  final String Post_Body;
  final List<dynamic> Comments;
  final String Emotions;
  final String Poll_Id;
  final String Homework_Id;
  final String Event_Id;
  final String Action_Id;

  NewsArticle(
      {this.Post_Id,
      this.Class_Id,
      this.Post_Audience,
      this.Post_Category,
      this.Post_Type,
      this.Post_Time,
      this.Post_Title,
      this.Post_Pic,
      this.Post_Author,
      this.Post_Body,
      this.Comments,
      this.Emotions,
      this.Poll_Id,
      this.Homework_Id,
      this.Event_Id,
      this.Action_Id});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
        Post_Id: json['Post_Id'],
        Class_Id: json['Class_Id'],
        Post_Audience: json['Post_Audience'],
        Post_Category: json['Post_Category'],
        Post_Type: json['Post_Type'],
        Post_Time: json['Post_Time'],
        Post_Title: json['Post_Title'],
        Post_Pic: json['Post_Pic'],
        Post_Author: json['Post_Author'],
        Post_Body: json['Post_Body'],
        Comments: json['Comments'],
        Emotions: json['Emotions'],
        Poll_Id: json['Poll_Id'],
        Homework_Id: json['Homework_Id'],
        Event_Id: json['Event_Id'],
        Action_Id: json['Action_Id']);
  }

  static Resource<List<NewsArticle>> get all {
    return Resource(
        url:
            'https://xwt1cxb4o3.execute-api.us-east-2.amazonaws.com/EdlightenR1/timeline-posts-v2',
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => NewsArticle.fromJson(model)).toList();
        });
  }
}
