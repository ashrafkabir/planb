
import 'dart:convert';
import '../services/webservice.dart';


class NewsArticle {
  
final String Class_ID;
final List<dynamic> Comments;
final String Fees_ID;
final String Homework_ID;
final String Likes;
final String Post_Author;
final String Post_Body;
final String Post_ID;
final String Post_Time;
final String Post_Title;
final String Post_Type;
final String Survey_ID;




  NewsArticle({this.Class_ID, 
this.Comments, 
this.Fees_ID, 
this.Homework_ID, 
this.Likes, 
this.Post_Author, 
this.Post_Body, 
this.Post_ID, 
this.Post_Time, 
this.Post_Title, 
this.Post_Type, 
this.Survey_ID});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    return NewsArticle(
      Class_ID: json['Class_ID'],
Comments: json['Comments'],
Fees_ID: json['Fees_ID'],
Homework_ID: json['Homework_ID'],
Likes: json['Likes'],
Post_Author: json['Post_Author'],
Post_Body: json['Post_Body'],
Post_ID: json['Post_ID'],
Post_Time: json['Post_Time'],
Post_Title: json['Post_Title'],
Post_Type: json['Post_Type'],
Survey_ID: json['Survey_ID']
    );
  
}

  static Resource<List<NewsArticle>> get all {
    
    return Resource(
     url: 'https://sud9zxmd8c.execute-api.us-east-2.amazonaws.com/Test/timelineposts',
      parse: (response) {
        final result = json.decode(response.body); 
        Iterable list = result;
        return list.map((model) => NewsArticle.fromJson(model)).toList();
      }
    );

  }

}