import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:quizlet/services/user.services.dart';

final storage = FirebaseStorage.instance;

Future<String> getDownloadURL(String gsLink) async {
  final ref = storage.ref().child(gsLink);
  return ref.getDownloadURL();
}

Future uploadAvatar(XFile photo) async {
  // final uid = await getUID();
  // final fileName = basename(photo.path);
  // print(uid);
  // print(fileName);
  // try {
  //   final ref = storage.ref(destination).child('file/');
  //   await ref.putFile(_photo!);
  // } catch (e) {
  //   print('error occured');
  // }
}
