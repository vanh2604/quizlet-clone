import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance;

Future<String> getDownloadURL(String gsLink) async {
  final ref = storage.ref().child(gsLink);
  return ref.getDownloadURL();
}
