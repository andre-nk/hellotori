part of 'services.dart';
class FirestoreDatabase{
  final _service = FirebaseFirestore.instance;

  //--USER--//
  Future<void> createUserData(User? user){
    return _service
      .collection("users")
      .doc(user!.uid)
      .set({
        "name": user.displayName,
        "profilePicture": user.photoURL,
        "role": "User"
      }
    );
  }

  //--EVENT--//
  List<Event> _eventListFromSnapshot(QuerySnapshot data) {
    final List<Event> eventList = [];
    data.docs.forEach((element) {
      eventList.add(
        Event(
          uid: element.id,
          title: element["title"] ?? "",
          description: element["description"] ?? "",
          videoLink: element["link"] ?? "",
          schedule: element["schedule"] ?? "",
          isChatEnabled: element["isChatEnabled"] ?? true,
          type: element["type"] ?? "",
          likes: element["likes"] ?? 0,
          share: element["share"] ?? "",
          photo: element["photo"]
        )
      );
    });
    return eventList;
  }

  Future<void> createEvent({
    required String title,
    required String description,
    required String videoLink,
    required String shareDescription,
    required String dateTime,
    required String type,
    required String photoLink,
    required bool isChatEnabled
  }){
    return _service
      .collection("events")
      .doc()
      .set({
        "title": title,
        "description": description,
        "photo": photoLink,
        "link": videoLink,
        "schedule": dateTime,
        "share": shareDescription,
        "type": type,
        "isChatEnabled": isChatEnabled,
        "likes": 0
      });
  }

  Future<void> editEvent({
    required String title,
    required String description,
    required String videoLink,
    required String shareDescription,
    required String dateTime,
    required String type,
    required String photoLink,
    required bool isChatEnabled,
    required int currentLike,
    required String uid,
  }){
    return _service
      .collection("events")
      .doc(uid)
      .update({
        "title": title,
        "description": description,
        "photo": photoLink,
        "link": videoLink,
        "schedule": dateTime,
        "share": shareDescription,
        "type": type,
        "isChatEnabled": isChatEnabled,
        "likes": currentLike
      });
  }

  Future<void> deleteEvent({
    required String uid
  }){
    return _service
      .collection("events")
      .doc(uid)
      .delete();
  }

  //--CHAT--//
  List<Chat> chatListFromSnapshot(QuerySnapshot data){
    final List<Chat> chatList = [];
    data.docs.forEach((element) {
      chatList.add(
        Chat(
          uid: element.id,
          senderUID: element["sender"],
          dateTime: element["dateTime"],
          message: element["message"]
        )
      );
    });
    return chatList;
  }

  Future<void> addChat(String userUID, String message, String dateTime, String eventUID){
    return eventUID == ""
    ? _service 
      .collection("public_chat")
      .doc()
      .set({
        "dateTime": dateTime,
        "sender": userUID,
        "message": message
      })
    : _service
      .collection("events")
      .doc(eventUID)
      .collection("chat")
      .doc()
      .set({
        "dateTime": dateTime,
        "sender": userUID,
        "message": message
      });
  }

  //--INTENT--//
  List<ActivityIntent> intentListFromSnapshot(QuerySnapshot data){
    final List<ActivityIntent> intentList = [];
    data.docs.forEach((element) {
      intentList.add(
        ActivityIntent(
          uid: element.id,
          title: element["title"],
          description: element["description"],
          answer: element["answer"],
          isActive: element["isActive"],
          multipleChoices: element["multipleChoices"],
          imageURL: element["imageURL"],
          userWithRightAnswer: element["right"],
          userWithWrongAnswer: element["wrong"]
        )
      );
    });
    return intentList;
  }

  Future<void> addQuizAnswer({
    required bool status,
    required String eventUID,
    required String intentID,
    required List<dynamic> currentList
  }){
    
    return status == true
      ? _service
        .collection("events")
        .doc(eventUID)
        .collection("intent")
        .doc(intentID)
        .update({
          "right": currentList
        })
      : _service
        .collection("events")
        .doc(eventUID)
        .collection("intent")
        .doc(intentID)
        .update({
          "wrong": currentList
        });
  }

  Future<void> createIntent({
    required String eventUID,
    required String title,
    required String description,
    required String answer,
    required String imageURL,
    required List<dynamic> multipleChoices,
  }){
    return _service
      .collection("events")
      .doc(eventUID)
      .collection("intent")
      .doc()
      .set({
        "title": title,
        "description": description,
        "answer": answer,
        "imageURL": imageURL,
        "multipleChoices": multipleChoices,
        "right": [],
        "wrong": [],
        "isActive": true
      });
  }

  Future<void> updateIntent({
    required String eventUID,
    required String title,
    required String description,
    required String answer,
    required String imageURL,
    required List<dynamic> multipleChoices,
    required List<dynamic> right,
    required List<dynamic> wrong,
    required bool isActive
  }){
    return _service
      .collection("events")
      .doc(eventUID)
      .collection("intent")
      .doc()
      .set({
        "title": title,
        "description": description,
        "answer": answer,
        "imageURL": imageURL,
        "multipleChoices": multipleChoices,
        "right": right,
        "wrong": wrong,
        "isActive": isActive
      });
  }

  //--LIKES--//
  Future<void> addLikes(String uid, int currentLike){
    return _service
      .collection("events")
      .doc(uid)
      .update({
        "likes": currentLike + 1
      }
    );
  }

  //-BIOS-//
  Bios _articleBiosFromSnapshot(DocumentSnapshot snapshot){
    return Bios(
      article: snapshot.get("article"),
      photoURL: snapshot.get("photos"),
      uid: snapshot.id,
      headline: snapshot.get("headline")
    );
  }

  Future<void> editBios({
    required String headline,
    required String article,
    required List<dynamic> photoURLs,
    required String type
  }){
    return _service
      .collection("bios")
      .doc(type == "school" ? "smansa-bios" : "osis-bios") 
      .update({
        "headline": headline,
        "article": article,
        "photos": photoURLs
      });
  }

  //SHOP
  List _shopInfoGenerator(DocumentSnapshot snapshot){
    return [
      snapshot.get("contact"),
      snapshot.get("imageHeader"),
      snapshot.get("questionMessage"),
      snapshot.get("purchaseMessage"),
    ];
  }

  List<ShopItemModel> _shopItemFromSnapshot(QuerySnapshot data){
    final List<ShopItemModel> itemList = [];
    data.docs.forEach((element) {
      itemList.add(
        ShopItemModel(
          uid: element.id,
          title: element["title"],
          description: element["description"],
          imageURL: element["imageURL"],
          price: element["price"],
          isSold: element["isSold"]
        )
      );
    });
    return itemList;
  }

  Future<void> addShopItem({
    required String title,
    required String description,
    required String imageURL,
    required int price,
  }){
    return _service
      .collection("shop")
      .doc()
      .set({
        "title": title,
        "description": description,
        "imageURL": imageURL,
        "price": price,
        "isSold": false
      });
  }

  Future<void> editShopItem({
    required String eventUID,
    required String title,
    required String description,
    required String imageURL,
    required int price,
    required bool isSold
  }){
    return _service
      .collection("shop")
      .doc(eventUID)
      .update({
        "title": title,
        "description": description,
        "imageURL": imageURL,
        "price": price,
        "isSold": isSold
      });
  }

  //-- GETTER --//
  Stream<List> get shopBios{
    return _service
      .collection("bios")
      .doc("shop-bios")
      .snapshots()
      .map(_shopInfoGenerator);
  }

  Stream<List<ShopItemModel>> get itemList{
    return _service
      .collection("shop")
      .snapshots()
      .map(_shopItemFromSnapshot);
  }

  Stream<List<Event>> get eventList{
    return _service
      .collection("events")
      .orderBy("schedule", descending: true)
      .snapshots()
      .map(_eventListFromSnapshot);
  }

  Stream<List<Chat>> chatList(String eventUID){
    return eventUID == ""
      ? _service
        .collection("public_chat")
        .orderBy("dateTime", descending: true)
        .snapshots()
        .map(chatListFromSnapshot)
      : _service
        .collection("events")
        .doc(eventUID)
        .collection("chat")
        .orderBy("dateTime", descending: true)
        .snapshots()
        .map(chatListFromSnapshot);
  }

  Stream<List<ActivityIntent>> intentList(String eventUID){
    return _service
      .collection("events")
      .doc(eventUID)
      .collection("intent")
      .snapshots()
      .map(intentListFromSnapshot);
  }

  Stream<Bios> get schoolArticle{
    return _service
      .collection("bios")
      .doc("smansa-bios")
      .snapshots()
      .map(_articleBiosFromSnapshot);
  }

  Stream<Bios> get osisArticle{
    return _service
      .collection("bios")
      .doc("osis-bios")
      .snapshots()
      .map(_articleBiosFromSnapshot);
  }

  Stream<OtherUser> otherUserProfile(String uid){
    return _service
      .collection("users")
      .doc(uid)
      .snapshots()
      .map((event) => OtherUser(
        uid: event.id,
        name: event.get("name"),
        profilePicture: event.get("profilePicture")
      )
    );
  }

  Stream<MainUser> mainUserProfile(String uid){
    return _service
      .collection("users")
      .doc(uid)
      .snapshots()
      .map((event) => MainUser(
        uid: event.id,
        name: event.get("name"),
        profilePicture: event.get("profilePicture"),
        role: event.get("role")
      )
    );
  }
}

