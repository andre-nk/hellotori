part of "model.dart";

class ShopItemModel{
  String uid;
  String title;
  String description;
  String imageURL;
  int price;

  ShopItemModel({
    required this.uid,
    required this.title,
    required this.description,
    required this.imageURL,
    required this.price
  }){
    this.uid = uid;
    this.title = title;
    this.price = price;
    this.description = description;
    this.imageURL = imageURL; 
  }
}