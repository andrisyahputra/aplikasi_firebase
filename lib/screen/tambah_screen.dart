import 'package:aplikasi_firebase/provider/storage.dart';
import 'package:aplikasi_firebase/provider/users.dart';
import 'package:aplikasi_firebase/screen/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TambahUserScreen extends StatelessWidget {
  const TambahUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Users users = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
                controller: users.firstnameC,
                decoration: InputDecoration(
                    hintText: "Nama Depan", border: OutlineInputBorder())),
            SizedBox(
              height: 10,
            ),
            TextField(
                controller: users.lastnameC,
                decoration: InputDecoration(
                    hintText: "Nama Belakang", border: OutlineInputBorder())),
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
                    users.tambahuser();
                    Navigator.pop(context);
                  }
                },
                child: Text("Tambah")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiProvider(providers: [
                          ChangeNotifierProvider(create: (context) =>  Users(),),
                          ChangeNotifierProvider(create: (context) =>  Storage(),)
                        ], child: UploadScreen()),
                      ));
                },
                child: Text("Upload Screen"))
          ],
        ),
      ),
    );
  }
}
