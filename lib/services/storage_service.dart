part of "services.dart";

class StorageService{
  final _storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String pathName) async {
    File file = File(filePath);
    try {
      await _storage
        .ref(pathName)
        .putFile(file);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<String> getDownloadURL(String pathName) async{
    return await _storage.ref().child(pathName).getDownloadURL();
  }
}