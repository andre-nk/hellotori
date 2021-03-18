part of "model.dart";

class Event{
  String? uid;
  String? title;
  String? videoLink;
  String? description;
  List<String>? tags;
  String? type;
  String? schedule;
  bool? isChatEnabled;

  Event({this.uid, this.title, this.videoLink, this.description, this.tags, this.type, this.schedule, this.isChatEnabled}){
    this.uid = uid ?? ""; 
    this.title = title ?? "";
    this.videoLink = videoLink ?? "";
    this.description = description ?? "";
    this.tags = tags ?? [];
    this.type = type ?? "";
    this.schedule = schedule ?? "";
    this.isChatEnabled = isChatEnabled ?? true;
  }
}

