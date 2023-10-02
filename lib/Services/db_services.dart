import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:playbeat/Models/category_model.dart';
import 'package:playbeat/Models/song_model.dart';
import 'package:playbeat/Models/user_model.dart';
import 'package:playbeat/Utilities/global_variables.dart';
import 'package:playbeat/Utilities/overlays_widgets.dart';

class DBServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String songs = 'songs';
  static String categories = 'categories';
  static String users = 'users';

  Future<void> createUser(UserModel userModel) async {
    try {
      await firestore.collection(users).doc(userModel.userId).set(
            userModel.toJson(),
          );
    } catch (e) {
      errorOverlay(e.toString());
    }
  }

  Future<UserModel> getUser(String userID) async {
    try {
      final retrval = await firestore
          .collection(users)
          .doc(userID)
          .get()
          .then((DocumentSnapshot doc) {
        UserModel data = UserModel();
        data = UserModel.fromFirestore(doc);
        return data;
      });
      return retrval;
    } catch (e) {
      Get.snackbar('User failed', e.toString());
      rethrow;
    }
  }

  Future<void> uploadSong(SongModel songModel) async {
    final id = firestore.collection(songs).doc().id;
    songModel.songId = id;
    await firestore.collection(songs).doc(id).set(songModel.toJson());
  }

  Future<void> likeSong(String songId) async {
    await firestore.collection(songs).doc(songId).update({
      'likedBy': FieldValue.arrayUnion([userID.value]),
    });
  }

  Future<void> removeLike(String songId) async {
    await firestore.collection(songs).doc(songId).update({
      'likedBy': FieldValue.arrayRemove([userID.value]),
    });
  }

  Future<void> addCategory(CategoryModel categoryModel) async {
    final id = firestore.collection(categories).doc().id;
    categoryModel.categoryId = id;
    await firestore.collection(categories).doc(id).set(categoryModel.toJson());
  }

  Stream<List<SongModel>> streamAdminSongsData() {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    return fireStore
        .collection('songs')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((event) {
      List<SongModel> retVal = [];
      for (var doc in event.docs) {
        retVal.add(SongModel.fromFirestore(doc));
      }
      return retVal;
    });
  }

  Stream<List<SongModel>> streamMyLikedSongs() {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    return fireStore
        .collection('songs')
        .where('likedBy', arrayContains: userID.value)
        .snapshots()
        .map((event) {
      List<SongModel> retVal = [];
      for (var doc in event.docs) {
        retVal.add(SongModel.fromFirestore(doc));
      }
      return retVal;
    });
  }

  Stream<List<SongModel>> streamUserUploadSongsData() {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    return fireStore
        .collection('songs')
        .where('uploadedBy', isEqualTo: userID.value)
        .snapshots()
        .map((event) {
      List<SongModel> retVal = [];
      for (var doc in event.docs) {
        retVal.add(SongModel.fromFirestore(doc));
      }
      return retVal;
    });
  }

  // Future<List<SongModel>> getUserUploadSongsData() async {
  //   FirebaseFirestore fireStore = FirebaseFirestore.instance;
  //   return await fireStore
  //       .collection('songs')
  //       .where('uploadedBy', isEqualTo: userID.value)
  //       .get()
  //       .then((snapshot) {
  //     List<SongModel> retVal = [];
  //     for (var doc in snapshot.docs) {
  //       retVal.add(SongModel.fromFirestore(doc));
  //     }
  //     return retVal;
  //   });
  // }

  Future<List<SongModel>> getUserSongsData(String category) async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    return await fireStore
        .collection('songs')
        .where('category', isEqualTo: category)
        .where('status', isEqualTo: 'approved')
        .get()
        .then((snapshot) {
      List<SongModel> retVal = [];
      for (var doc in snapshot.docs) {
        retVal.add(SongModel.fromFirestore(doc));
      }
      return retVal;
    });
  }

  Future<List<SongModel>> getAllSongsForSearch() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    return await fireStore
        .collection('songs')
        .where('status', isEqualTo: 'approved')
        .get()
        .then((snapshot) {
      List<SongModel> retVal = [];
      for (var doc in snapshot.docs) {
        retVal.add(SongModel.fromFirestore(doc));
      }
      return retVal;
    });
  }

  Future<void> deleteSong(String songId) async {
    await firestore.collection(songs).doc(songId).delete();
  }

  // Future<UserModel> getUser() async {
  //   return firestore
  //       .collection(users)
  //       .doc(userID.value)
  //       .get()
  //       .then((value) => UserModel.fromFirestore(value));
  // }

  Stream<List<SongModel>> streamUsersSongsData(String? category) {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    return fireStore
        .collection('songs')
        .where('category', isEqualTo: category)
        .where('status', isEqualTo: 'approved')
        .snapshots()
        .map((event) {
      List<SongModel> retVal = [];
      for (var doc in event.docs) {
        retVal.add(SongModel.fromFirestore(doc));
      }
      return retVal;
    });
  }
}
