import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/Controllers/search_song_controller.dart';
import 'package:playbeat/Models/song_model.dart';
import 'package:playbeat/Services/player_common.dart';
import 'package:playbeat/Services/player_service.dart';
import 'package:playbeat/Utilities/global_variables.dart';
import 'package:playbeat/Widgets/music_container.dart';
import 'package:playbeat/Widgets/player_ui.dart';
// ignore: depend_on_referenced_packages
import 'package:playbeat/pages/Music/songs_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchDataController = Get.find<SearchSongController>();
  RxString searchString = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'search',
          child: CupertinoSearchTextField(
            backgroundColor: Colors.white,
            onChanged: (value) => searchString.value = value,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Obx(() {
          if (searchDataController.songs == null) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (searchDataController.songs!.isNotEmpty) {
            return Obx(() {
              List<SongModel> songs = [];
              songs.addAll(searchDataController.songs!.where((element) =>
                  element.title!
                      .toLowerCase()
                      .contains(searchString.value.toLowerCase())));
              return ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  SongModel song = songs[index];
                  return GestureDetector(
                    onTap: () async {
                      isAudioLoading.value = true;
                      final playlist = PlayerService().buildAudios(songs);
                      await PlayerService()
                          .buildPlayer(player, playlist, initialIndex: index);
                    },
                    child: MusicContainer(
                      title: song.title,
                      singer: song.singer,
                      imageUrl: song.imageUrl,
                      isAdmin: false,
                      isLiked: false,
                      songId: song.songId!,
                      isUserUpload: false,
                      status: 'status',
                      onLike: () {},
                    ),
                  );
                },
              );
            });
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        }),
      ),
      bottomNavigationBar: Obx(
        () => isPlaying.value ? const PlayerUi() : const SizedBox(),
      ),
    );
  }
}
