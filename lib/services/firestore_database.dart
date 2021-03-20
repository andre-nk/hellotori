part of 'services.dart';
class FirestoreDatabase{
  final String? id;

  FirestoreDatabase({this.id});

  final _service = FirebaseFirestore.instance;

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
          isChatEnabled: element["chatEnabled"] ?? true,
          type: element["type"] ?? "",
          activityIntent: element["activityIntents"],
          likes: element["likes"] ?? 0
        )
      );
    });
    return eventList;
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
}

