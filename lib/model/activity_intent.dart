part of "model.dart";

class ActivityIntent{
  String uid;
  String title;
  String? description;
  String imageURL; //OR QUESTION FOR INSTANCE
  List<dynamic> multipleChoices; //OR ESSAY ANSWER FOR INSTANCE
  String answer;
  bool isActive;

  ActivityIntent({
    required this.uid, 
    required this.title,
    required this.isActive,
    required this.description,
    required this.multipleChoices,
    required this.answer,
    required this.imageURL
  }){
    this.uid = uid;
    this.title = title;
    this.isActive = isActive;
    this.description = description;
    this.multipleChoices = multipleChoices;
    this.answer = answer;
    this.imageURL = imageURL;
  }

  Map<String, dynamic> toJson() => {
    "uid" : uid,
    "title": title,
    "isActive": isActive,
    "description": description,
    "multipleChoices": multipleChoices,
    "answer": answer
  };
}