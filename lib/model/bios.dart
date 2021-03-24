part of "model.dart";

class Bios{
  String uid;
  String? headline;
  List<dynamic> photoURL;
  String article;

  Bios({required this.uid, this.headline, required this.photoURL, required this.article}){
    this.uid = uid;
    this.headline = headline;
    this.photoURL = photoURL;
    this.article = article;
  }
}