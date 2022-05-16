import 'package:cloud_firestore/cloud_firestore.dart';

const user1 = 'VHZlCPUDsbdTdwAG8Dc0qdTsdqx2';
const user2 = 'l0KO0JQr4ha6R3kpbjAcEwyaVdK2';

Future<void> seedDatabase() async {
  await seedSets();
  await seedFolders();
}

Future<void> seedFolders() async {
  final db = FirebaseFirestore.instance;
  await db.collection('users').doc(user1).update({
    'folders': FieldValue.arrayUnion(['English', 'AWS']),
  });
  await db.collection('users').doc(user2).update({
    'folders': FieldValue.arrayUnion(['Vietnamese', 'GCP']),
  });
}

Future<void> seedSets() async {
  final db = FirebaseFirestore.instance;

  Map vocab1 = {
    'cat': 'a small domesticated carnivorous mammal',
    'dog': 'a domesticated carnivorous mammal',
    'bird': 'a small flightless bird',
    'fish': 'a small aquatic animal',
    'snake': 'a carnivorous reptile',
    'lion': 'a large African cat',
    'tiger': 'a large cat',
    'bear': 'a large mammal',
    'horse': 'a large hoofed mammal',
    'cow': 'a large herbivorous mammal',
    'elephant': 'a large land-dwelling mammal',
    'giraffe': 'a large herbivorous mammal',
    'zebra': 'a large land-dwelling mammal',
    'rhinoceros': 'a large land-dwelling mammal',
    'monkey': 'a small ape-like primate',
    'chimpanzee': 'a small ape-like primate',
    'gorilla': 'a large ape-like primate',
    'orangutan': 'a large ape-like primate',
    'kangaroo': 'a small marsupial',
    'wallaby': 'a small marsupial',
    'platypus': 'a small egg-laying mammal',
    'kookaburra': 'a small marsupial',
    'wombat': 'a small marsupial',
    'koala': 'a small marsupial',
    'panda': 'a large bear-like primate',
    'giant panda': 'a large bear-like primate',
  };

  Map vocab2 = {
    'red': 'đỏ',
    'green': 'xanh lá',
    'blue': 'xanh da trời',
    'yellow': 'vàng',
    'orange': 'cam',
    'purple': 'tím',
    'pink': 'hồng',
    'brown': 'nâu',
    'black': 'đen',
    'white': 'trắng',
    'grey': 'xám',
    'silver': 'bạc',
    'gold': 'vàng',
    'golden': 'vàng',
    'beige': 'beige',
    'ivory': 'trắng',
    'cream': 'trắng',
    'creamy': 'trắng',
    'creamy white': 'trắng',
    'creamy yellow': 'vàng',
    'creamy orange': 'vàng',
    'creamy red': 'vàng',
  };

  Map aws1 = {
    'EC2': 'Elastic Compute Cloud',
    'ECS': 'Elastic Container Service',
    'EFS': 'Elastic File System',
    'EBS': 'Elastic Block Storage',
    'S3': 'Simple Storage Service',
    'SES': 'Simple Email Service',
    'SNS': 'Simple Notification Service',
    'SQS': 'Simple Queue Service',
    'RDS': 'Relational Database Service',
    'Redshift': 'Redshift',
    'ElastiCache': 'ElastiCache',
    'CloudFront': 'CloudFront',
    'CloudWatch': 'CloudWatch',
    'CloudTrail': 'CloudTrail',
    'CloudFormation': 'CloudFormation',
  };

  Map vocabvietnam = {
    'xin chào': 'hello',
    'tạm biệt': 'goodbye',
    'cảm ơn': 'thank you',
    'vĩnh biệt': 'farewell',
    'tốt': 'good',
    'tốt lắm': 'very good',
    'tốt hơn': 'better',
    'cái bút': 'pen',
    'tờ giấy': 'paper',
    'bút chì': 'pencil',
    'thước kẻ': 'ruler',
    'cái ghế': 'chair',
    'cái bàn': 'table',
    'cái tủ': 'wardrobe',
    'cái máy giặt': 'washing machine',
    'cái điện thoại': 'phone',
    'cái máy ảnh': 'camera',
    'cái máy tính': 'computer',
    'cái máy tính bảng': 'tablet',
  };

  Map gcp1 = {
    'Compute Engine': 'Virtual Machines running in Google\'s data center',
    'App Engine': 'Google App Engine',
    'Cloud Storage': 'Object storage that\'s secure',
    'Cloud SQL': 'Relational database service',
    'Cloud Bigtable':
        'Bigtable is a fully-managed, scalable, high-performance, transactional, and fully-managed NoSQL database',
    'BigQuery': 'Data warehouse for business agility and insights',
    'Cloud Function':
        'Event-driven compute platform for cloud services and apps',
    'Cloud Datastore': 'NoSQL database for your app',
    'Cloud Pub/Sub': 'Publish-subscribe messaging service',
    'Cloud DNS': 'Domain name service',
    'Cloud Spanner':
        'Database for highly-scalable, globally distributed, transactional data',
  };

  await db.collection('sets').add({
    'user': user1,
    'name': 'Vocabulary 1',
    'folder': 'English',
    'cards': vocab1,
    'resources': {},
  });

  await db.collection('sets').add({
    'user': user1,
    'name': 'Vocabulary 2',
    'folder': 'English',
    'cards': vocab2,
    'resources': {},
  });

  await db.collection('sets').add({
    'user': user1,
    'name': 'AWS Terms',
    'folder': 'AWS',
    'cards': aws1,
    'resources': {},
  });

  await db.collection('sets').add({
    'user': user2,
    'name': 'Vietnamese Vocab',
    'folder': 'Vietnamese',
    'cards': vocabvietnam,
    'resources': {},
  });

  await db.collection('sets').add({
    'user': user2,
    'name': 'GCP Terms',
    'folder': 'GCP',
    'cards': gcp1,
    'resources': {},
  });
}
