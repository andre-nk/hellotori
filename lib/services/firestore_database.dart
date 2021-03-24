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
        "profilePicture": user.photoURL
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
          share: element["share"] ?? ""
        )
      );
    });
    return eventList;
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

  //-- GETTER --//
  Stream<List<Event>> get eventList{
    return _service
      .collection("events")
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
}

