import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizlet/services/storage.services.dart';

final user = FirebaseAuth.instance.currentUser!;

Future<String> getAvatarURL() async {
  final avatar = user.photoURL;
  if (avatar != null) {
    final url = await getDownloadURL(avatar);
    return url;
  }
  return '';
}

Future<String> getDisplayName() async {
  final name = user.displayName;
  if (name != null) {
    return name;
  }
  return '';
}

Future<String> getEmail() async {
  final email = user.email;
  if (email != null) {
    return email;
  }
  return '';
}

Future<String> getUID() async {
  final uid = user.uid;
  return uid;
}
