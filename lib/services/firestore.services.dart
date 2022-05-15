import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlet/services/user.services.dart';

final db = FirebaseFirestore.instance;

Future<void> createUserDB() async {
  final uid = await getUID();
  final name = user.displayName;
  final data = {
    'name': name,
    'folders': ['Uncategorized'],
  };
  await db.collection('users').doc(uid).set(data);
}

Future<void> createSet(
    String name, String folder, Map cards, Map resources) async {
  final uid = await getUID();
  await db.collection('sets').add({
    'user': uid,
    'name': name,
    'folder': folder,
    'cards': cards,
    'resources': resources,
  });
}
