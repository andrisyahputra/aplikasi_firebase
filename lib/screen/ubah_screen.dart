import 'package:aplikasi_firebase/provider/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UbahUserScreen extends StatelessWidget {
  UbahUserScreen({required this.idUser, super.key});

  String idUser;
   

  @override
  Widget build(BuildContext context) {
    
    Users users = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah User"),
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: users.getById(idUser),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            // print(data);
            users.firstnameC.text = data['firstname'];
            users.lastnameC.text = data['lastname'];
            users.ageC.text = data['age'];
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                      controller: users.firstnameC,
                      decoration: InputDecoration(
                          hintText: "Nama Depan",
                          border: OutlineInputBorder())),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: users.lastnameC,
                      decoration: InputDecoration(
                          hintText: "Nama Belakang",
                          border: OutlineInputBorder())),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: users.ageC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Usia", border: OutlineInputBorder())),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (users.firstnameC.text.isNotEmpty &&
                            users.lastnameC.text.isNotEmpty &&
                            users.ageC.text.isNotEmpty) {
                          users.updateUser(idUser);
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Ubah"))
                ],
              ),
            );
          } else {
          return Center(
            child: CircularProgressIndicator(),
          );
          }
        },
      ),
    );
  }
}