import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  TextEditingController firstnameC = TextEditingController();
  TextEditingController lastnameC = TextEditingController();
  TextEditingController ageC = TextEditingController();

  Future<DocumentSnapshot<Object?>> getById(String id) async {
    // akan ditambah colection db users di firebase
    DocumentReference users = db.collection("users").doc(id);
    return await users.get();
  }

  void tambahuser() {
    // akan ditambah colection db users di firebase
    CollectionReference users = db.collection("users");

    // validasi
    if (firstnameC.text.isNotEmpty &&
        lastnameC.text.isNotEmpty &&
        ageC.text.isNotEmpty) {
      users.add({
        'firstname': firstnameC.text,
        'lastname': lastnameC.text,
        'age': ageC.text,
      });
    } else {
      print("tidaK boleh kosong");
    }
  }

  void updateUser(String id) {
    DocumentReference users = db.collection("users").doc(id);

    users.update({
      'firstname': firstnameC.text,
      'lastname': lastnameC.text,
      'age': ageC.text,
    });
  }

  void hapususer(String id){
    DocumentReference users = db.collection("users").doc(id);
    users.delete();
  }

  // tampil sekali reload
  Future<QuerySnapshot<Object?>> tampiluser() async {
    // akan ditambah colection db users di firebase
    CollectionReference users = db.collection("users");
    return await users.get();
  }

  // realtime
  Stream<QuerySnapshot<Object?>> realtimeUser() {
    // akan ditambah colection db users di firebase
    CollectionReference users = db.collection("users");
    return users.snapshots();
  }
}
