import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

abstract class Database {}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  Future<void> _setData(String path, Map<String, dynamic> data) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }
}
