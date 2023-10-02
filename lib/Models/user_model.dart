import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? name;
  String? email;

  UserModel({this.name, this.email});

  UserModel.fromFirestore(DocumentSnapshot doc) {
    userId = doc.get('userId');
    name = doc.get('name');
    email = doc.get('email');
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
