import 'dart:convert';
import '../services/webservice.dart';

class Event {
  final String Event_Id;
  final String Event_Name;
  final String Event_Desc;
  final String Event_From_Date;
  final String Event_To_Date;
  final String Event_Type;
  final String Class_Id;
  final String User_Profile_Id;
  final String Event_Status;

  Event({
    this.Event_Id,
    this.Event_Name,
    this.Event_Desc,
    this.Event_From_Date,
    this.Event_To_Date,
    this.Event_Type,
    this.Class_Id,
    this.User_Profile_Id,
    this.Event_Status,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        Event_Id: json['Event_Id'],
        Event_Name: json['Event_Name'],
        Event_Desc: json['Event_Desc'],
        Event_From_Date: json['Event_From_Date'],
        Event_To_Date: json['Event_To_Date'],
        Event_Type: json['Event_Type'],
        Class_Id: json['Class_Id'],
        User_Profile_Id: json['User_Profile_Id'],
        Event_Status: json['Event_Status']);
  }

  static Resource<List<Event>> get all {
    return Resource(
        url:
            'https://4fvu66j7i2.execute-api.us-east-2.amazonaws.com/Test/events',
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          //print(list.length);
          return list.map((model) => Event.fromJson(model)).toList();
        });
  }
}
