import 'package:aplikasi_firebase/provider/users.dart';
import 'package:aplikasi_firebase/screen/tambah_screen.dart';
import 'package:aplikasi_firebase/screen/ubah_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Users users = Provider.of<Users>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (context) => Users(), child: TambahUserScreen()),
              ));
        },
        child: Icon(Icons.add_box),
      ),
      appBar: AppBar(
        title: Text("Firebase"),
      ),

      // sekali relaod di firebase
      // body: FutureBuilder<QuerySnapshot<Object?>>(
      //   future: users.tampiluser(),
      //   builder: (context, snapshot) {
      //     // print(snapshot.data!.docs[0].data());
      //     if (snapshot.connectionState == ConnectionState.done) {
      //     var data = snapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: data.length,
      //         itemBuilder: (context, index) {
      //           final user = data[index].data() as Map<String, dynamic>;
      //           return ListTile(
      //             title: Text(
      //                 "Nama Depan : ${user['firstname']} ${user['lastname']}"),
      //             subtitle: Text("Usia : ${user['age']}"),
      //           );
      //         },
      //       );
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),

      body: 
          StreamBuilder(
            stream: users.realtimeUser(),
            builder: (context, snapshot) {
              // print(snapshot.data!.docs[0].data());
              if (snapshot.connectionState == ConnectionState.active) {
                // harus pakai aktive
                var data = snapshot.data!.docs;
                if (data.isEmpty) {
                  return Center(child: Text("User Kosong"));
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final user = data[index].data() as Map<String, dynamic>;
                    return ListTile(
                      trailing: IconButton(
                          onPressed: () {
                            users.hapususer(data[index].id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                  create: (context) => Users(),
                                  // child: UbahUserScreen(idUser: user['id'].toString(),)),
                                  child: UbahUserScreen(
                                    idUser: data[index].id,
                                  )),
                            ));
                      },
                      title: Text(
                          "Nama Depan : ${user['firstname']} ${user['lastname']}"),
                      subtitle: Text("Usia : ${user['age']}"),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
    );
  }
}
