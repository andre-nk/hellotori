part of "model.dart";

class ActivityIntent{
  String id;
  String title;
  String? description; //OR QUESTION FOR INSTANCE
  List<dynamic> multipleChoices; //OR ESSAY ANSWER FOR INSTANCE
  String answer;
  bool isActive;

  ActivityIntent({
    required this.id, 
    required this.title,
    required this.isActive,
    required this.description,
    required this.multipleChoices,
    required this.answer,
  }){
    this.id = id;
    this.title = title;
    this.isActive = isActive;
    this.description = description;
    this.multipleChoices = multipleChoices;
    this.answer = answer;
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "title": title,
    "isActive": isActive,
    "description": description,
    "multipleChoices": multipleChoices,
    "answer": answer
  };
}