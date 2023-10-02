import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/Utilities/global_variables.dart';

class MusicContainer extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String? category;
  final String? writer;
  final String status;
  final String? uploadedDate;
  final String? imageUrl;
  final String? singer;
  final bool isUserUpload;
  final String? title;
  final bool isAdmin;
  final String songId;
  final bool isLiked;
  final VoidCallback onLike;

  MusicContainer({
    required this.isAdmin,
    super.key,
    this.imageUrl,
    this.singer,
    this.title,
    this.category,
    this.writer,
    required this.isLiked,
    required this.songId,
    this.uploadedDate,
    required this.isUserUpload,
    required this.status,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    // bool  = likedBy.contains(userID.value);
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: currentAudioText.value == songId
                ? Colors.deepPurple[200]
                : Colors.transparent,
            borderRadius: isUserUpload
                ? const BorderRadius.horizontal(
                    left: Radius.circular(12),
                  )
                : BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 3,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: imageUrl.toString(),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: songId == currentAudioText.value
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              singer.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: songId == currentAudioText.value
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        isAdmin
                            ? IconButton(
                                onPressed: () {
                                  Get.bottomSheet(
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(35),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 20),
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Details',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            musicDetail(
                                                'Title', title.toString()),
                                            musicDetail(
                                                'Singer', singer.toString()),
                                            musicDetail(
                                                'Writer', writer.toString()),
                                            musicDetail('Category',
                                                category.toString()),
                                            musicDetail('Uploaded Date',
                                                uploadedDate.toString()),
                                            const Spacer(),
                                            customMaterialButton(
                                              'Disapprove',
                                              Colors.red,
                                              () async {
                                                await firestore
                                                    .collection('songs')
                                                    .doc(songId)
                                                    .update({
                                                  'status': 'disapproved'
                                                });
                                                Get.back();
                                              },
                                              BorderRadius.circular(12),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            customMaterialButton(
                                              'Approve',
                                              Colors.deepPurple,
                                              () async {
                                                await firestore
                                                    .collection('songs')
                                                    .doc(songId)
                                                    .update(
                                                        {'status': 'approved'});
                                                Get.back();
                                              },
                                              BorderRadius.circular(12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    // isScrollControlled: true,
                                    isDismissible: true,
                                    enableDrag: false,
                                  );
                                },
                                icon: const Icon(Icons.more_vert),
                              )
                            : isUserUpload
                                ? Text(
                                    status,
                                    style: TextStyle(
                                        color: status == 'approved'
                                            ? Colors.green
                                            : status == 'pending'
                                                ? Colors.black
                                                : Colors.red),
                                  )
                                : IconButton(
                                    onPressed: onLike,
                                    icon: isLiked
                                        ? const Icon(Icons.favorite_rounded,
                                            color: Colors.red)
                                        : const Icon(Icons.favorite_outline))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 3,
              )
            ],
          ),
        ));
  }

  MaterialButton customMaterialButton(
      String text, Color color, void Function()? onPress, BorderRadius border) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      color: color,
      onPressed: onPress,
      shape: RoundedRectangleBorder(borderRadius: border),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  Column musicDetail(String key, String value) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$key : ',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                // textAlign: TextAlign.end,
                // overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
