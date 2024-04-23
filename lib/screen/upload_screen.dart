import 'package:aplikasi_firebase/provider/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Storage storage = Provider.of<Storage>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload File"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(onPressed: () {
              storage.uploadFile();
            }, child: Text("Upload File"),),
            OutlinedButton(onPressed: () {
              storage.uploadMultiFile();
            }, child: Text("Upload Banyak File"),),
          ],
        ),
      ),
    );
  }
}