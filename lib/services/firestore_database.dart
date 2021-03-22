part of 'services.dart';
class FirestoreDatabase{
  final String? id;

  FirestoreDatabase({this.id});

  final _service = FirebaseFirestore.instance;

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
          activityIntent: element["activityIntent"],
          likes: element["likes"] ?? 0
        )
      );
    });
    return eventList;
  }

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

  Future<void> addLikes(String uid, int currentLike){
    return _service
      .collection("events")
      .doc(uid)
      .update({
        "likes": currentLike + 1
      }
    );
  }

  Future<void> addActivityIntents(String uid, String intents){
    return _service
      .collection("events")
      .doc(uid)
      .update({
        "activityIntents": intents
      }
    );
  }

  Stream<List<Event>> get eventList{
    return _service
      .collection("events")
      .snapshots()
      .map(_eventListFromSnapshot);
  }

  Stream<List<Chat>> chatList(String eventUID){
    return _service
      .collection("events")
      .doc(eventUID)
      .collection("chat")
      .snapshots()
      .map(chatListFromSnapshot);
  }
}

