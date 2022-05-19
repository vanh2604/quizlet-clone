import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future createUserDB() async {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final uid = user.uid;
  final name = user.displayName;
  final data = {
    'username': name,
    'folders': ['Uncategorized'],
  };
  await db.collection('users').doc(uid).set(data, SetOptions(merge: true));
}

Future createSet(String name, String folder, Map cards, Map resources) async {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final uid = user.uid;
  await db.collection('sets').add({
    'user': uid,
    'name': name,
    'folder': folder,
    'cards': cards,
    'resources': resources,
  });
}

Future createFolder(String name) async {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final uid = user.uid;
  await db.collection('users').doc(uid).update({
    'folders': FieldValue.arrayUnion([name]),
  });
}

Future<DocumentSnapshot> getUserInfo() async {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final uid = user.uid;
  return db.collection('users').doc(uid).get();
}

Stream<QuerySnapshot> getUserSetsStream() {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final uid = user.uid;
  return db.collection('sets').where('uid', isEqualTo: uid).snapshots();
}

// Stream<dynamic> getRecommendedSetsStream() {}
