import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizlet/services/storage.services.dart';

Future<String> getAvatarURL() async {
  final user = FirebaseAuth.instance.currentUser!;
  final avatar = user.photoURL;
  if (avatar != null) {
    final url = await getDownloadURL(avatar);
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
