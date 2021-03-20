part of "model.dart";

class ActivityIntent{
  String id;
  String title;
  String description;
  String type;
  List<String>? multipleChoices;
  List<String>? popQuiz;

  ActivityIntent({
    required this.id, 
    required this.title,
    required this.description,
    required this.type,
    this.multipleChoices,
    this.popQuiz
  }){
    this.title = title;
    this.id = id;
    this.description = description;
    this.type = type;
    this.multipleChoices = multipleChoices ?? [];
    this.popQuiz = popQuiz;
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "title": title,
    "description": description,
    "type": type,
    "multipleChoices": multipleChoices,
    "popQuiz": popQuiz
  };
}