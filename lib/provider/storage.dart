import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as Firebase_storage;
import 'package:flutter/material.dart';

class Storage with ChangeNotifier {
  void uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // List<File> file = result.paths.map((path) => File(path!)).toList();
      File file = File(result.files.single.path!);

      try {
        await FirebaseStorage.instance
            .ref(result.files.single.name)
            .putFile(file);
      } on Firebase_storage.FirebaseException catch (e) {
        // ...
        print(e);
      }
    } else {
      // User canceled the picker
      print("cencel");
    }
  }

  void uploadMultiFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      for (var element in result.files) {
        String name = element.name;
        File file = File(element.path!);

        try {
          await FirebaseStorage.instance.ref(name).putFile(file);
        } on Firebase_storage.FirebaseException catch (e) {
          // ...
          print(e);
        }
      }
    } else {
      // User canceled the picker
      print("cencel Multi");
    }
  }
}
