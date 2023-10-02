import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/pages/Admin/add_category.dart';
import 'package:playbeat/pages/Music/songs_view.dart';

class AdminApproval extends StatelessWidget {
  const AdminApproval({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin Approval'),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const AddCategory());
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: const SongView(
          isAdmin: true,
          userUploads: false,
          isFavoriteSongs: false,
        ));
  }
}
