import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? categoryId;
  String? title;
  String? imageUrl;

  CategoryModel({this.title, this.imageUrl, this.categoryId});

  CategoryModel.fromFirestore(DocumentSnapshot doc) {
    categoryId = doc.get('categoryId');
    title = doc.get('title');
    imageUrl = doc.get('imageUrl');
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
