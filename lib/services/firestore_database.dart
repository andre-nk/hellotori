part of 'services.dart';
class FirestoreDatabase{
  final _service = FirebaseFirestore.instance;

  List<Event> _eventListFromSnapshot(QuerySnapshot data) {
    final List<Event> eventList = [];
    data.docs.forEach((element) {
      eventList.add(Event(
        uid: element.id,
        title: element["title"] ?? "",
        description: element["description"] ?? "",
        videoLink: element["link"] ?? "",
        schedule: element["schedule"] ?? "",
        isChatEnabled: element["chatEnabled"] ?? true,
        type: element["type"] ?? "",
      ));
    });
    return eventList;
  }

  Stream<List<Event>> get eventList{
    return _service
      .collection("events")
      .snapshots()
      .map(_eventListFromSnapshot);
  }

}

