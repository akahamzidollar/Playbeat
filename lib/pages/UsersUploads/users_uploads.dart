import 'package:flutter/material.dart';
import 'package:playbeat/pages/Music/songs_view.dart';

class UsersUploads extends StatelessWidget {
  const UsersUploads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your uploads'),
      ),
      body: const SongView(
        isAdmin: false,
        userUploads: true,
        isFavoriteSongs: false,
      ),
    );
  }
}
