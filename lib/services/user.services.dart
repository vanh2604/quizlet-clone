import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizlet/services/storage.services.dart';

final StorageService storageService = StorageService();

class UserService {
  Future<String> getAvatarURL() async {
    final user = FirebaseAuth.instance.currentUser!;
    final avatar = user.photoURL;
    if (avatar != null) {
      final url = await storageService.getDownloadURL(avatar);
      return url;
    }
    return '';
  }

  Future<String> getDisplayName() async {
    final user = FirebaseAuth.instance.currentUser!;
    final name = user.displayName;
    if (name != null) {
      return name;
    }
    return '';
  }

  Future<String> getEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    final email = user.email;
    if (email != null) {
      return email;
    }
    return '';
  }

  Future<String> getUID() async {
    final user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    return uid;
  }

  Future<void> setAvatar(String path) async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.updatePhotoURL(path);
  }
}
