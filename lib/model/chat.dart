part of "model.dart";

class Chat{
  String uid;
  String senderUID;
  String message;
  String dateTime;

  Chat({required this.uid, required this.senderUID, required this.message, required this.dateTime}){
    this.uid = uid;
    this.senderUID = senderUID;
    this.message = message;
    this.dateTime = dateTime;
  }
}

class OtherUser{
  String uid;
  String name;
  String profilePicture;

  OtherUser({required this.uid, required this.name, required this.profilePicture}){
    this.uid = uid;
    this.name = name;
    this.profilePicture = profilePicture;
  }
}

