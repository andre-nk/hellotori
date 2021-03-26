part of "model.dart";

class MainUser{
  String uid;
  String name;
  String profilePicture;
  String role;

  MainUser({required this.uid, required this.name, required this.profilePicture, required this.role}){
    this.uid = uid;
    this.name = name;
    this.profilePicture = profilePicture;
    this.role = role;
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
