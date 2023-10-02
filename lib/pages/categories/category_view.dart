import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/Controllers/home_controller.dart';
import 'package:playbeat/Utilities/overlays_widgets.dart';
import 'package:playbeat/pages/Music/songs_view.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final homeController = Get.put(HomeController());

  Future getData() async {
    try {
      FirebaseFirestore fireStore = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await fireStore.collection('categories').get();
      return snapshot.docs;
    } catch (e) {
      errorOverlay(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => SongView(
                        categoryTitle: data['title'],
                        isAllSongs: false,
                        isAdmin: false,
                        userUploads: false,
                        isFavoriteSongs: false,
                      ),
                    );
                  },
                  child: categoryContainer(
                      categoryName: data['title'], imageUrl: data['imageUrl']),
                );
              },
            );
          } else {
            if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Text(snapshot.error.toString());
            }
            log('error');
            return const Text('Error');
          }
        },
      ),
    );
  }

  Column categoryContainer(
      {required String categoryName, required String imageUrl}) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )),
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                height: 30,
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  categoryName,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
