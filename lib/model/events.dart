part of "model.dart";

class Event{
  String uid;
  String title;
  String videoLink;
  String description;
  String type;
  String schedule;
  bool isChatEnabled;
  String activityIntent;
  int likes;

  Event({
    required this.uid,
    required this.title,
    required this.videoLink,
    required this.description, 
    required this.type, 
    required this.schedule, 
    required this.isChatEnabled, 
    required this.activityIntent,
    required this.likes
  }){
    this.uid = uid; 
    this.title = title;
    this.videoLink = videoLink;
    this.description = description;
    this.type = type;
    this.schedule = schedule;
    this.isChatEnabled = isChatEnabled;
    this.activityIntent = activityIntent;
    this.likes = likes;
  }
}

