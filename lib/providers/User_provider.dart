import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/entities/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

List usuarios = [];

Stream fetchUsersFromFirestore() {
  return db.collection('user').doc('auth').snapshots().map((snapshot) {
    usuarios = [];
    var data = snapshot.data();
    for (var element in data!.entries) {
      usuarios.add(User(email: element.key, password: element.value));
    }
    print(usuarios);
    print(usuarios[0].email);
    print(usuarios[0].password);
    return usuarios;
  });
}

String logged = '';

final userProvider = StreamProvider((ref) {
  return fetchUsersFromFirestore();
});

final loggedProvider = StateProvider((ref) {
  return logged;
});
