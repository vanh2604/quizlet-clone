import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quizlet/services/user.services.dart';

final UserService userService = UserService();
final storage = FirebaseStorage.instance;

class StorageService {
  Future<String> getDownloadURL(String gsLink) async {
    final ref = storage.ref().child(gsLink);
    return ref.getDownloadURL();
  }

  Future<void> uploadAvatar(FilePickerResult result) async {
    final uid = await userService.getUID();
    final Uint8List fileBytes = result.files.first.bytes as Uint8List;
    await storage.ref('avatar/$uid').putData(fileBytes);
    await userService.setAvatar('avatar/$uid');
  }
}
