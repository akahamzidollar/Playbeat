import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:playbeat/Models/song_model.dart';
import 'package:playbeat/Services/player_service.dart';
import 'package:playbeat/Utilities/global_variables.dart';
import 'package:playbeat/Widgets/music_container.dart';
import 'package:playbeat/Widgets/player_ui.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart' as rx;
import '../../Services/db_services.dart';
import '../../Services/player_common.dart';

AudioPlayer player = AudioPlayer();

class SongView extends StatefulWidget {
  final String? categoryTitle;
  final bool isAdmin;
  final bool isFavoriteSongs;
  final bool? isAllSongs;
  final bool userUploads;
  const SongView(
      {Key? key,
      this.categoryTitle,
      this.isAllSongs,
      required this.isAdmin,
      required this.userUploads,
      required this.isFavoriteSongs})
      : super(key: key);

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream,
        player.bufferedPositionStream,
        player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAllSongs == true ||
              widget.isAdmin == true ||
              widget.userUploads == true ||
              widget.isFavoriteSongs == true
          ? null
          : AppBar(
              title: Text(widget.categoryTitle.toString()),
            ),
      backgroundColor: Colors.white,
      extendBody: false,
      body: widget.userUploads == true
          ? SlidableAutoCloseBehavior(
              closeWhenOpened: true,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: StreamBuilder<List<SongModel>>(
                    stream: DBServices().streamUserUploadSongsData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.requireData.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.requireData[index];
                            bool isLiked = data.likedBy!.contains(userID.value);
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const BehindMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: ((context) {
                                      DBServices().deleteSong(data.songId!);
                                    }),
                                    backgroundColor: Colors.red,
                                    label: 'Delete',
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  isAudioLoading.value = true;
                                  final playlist = PlayerService()
                                      .buildAudios(snapshot.requireData);
                                  await PlayerService().buildPlayer(
                                      player, playlist,
                                      initialIndex: index);
                                },
                                child: MusicContainer(
                                  isLiked: isLiked,
                                  onLike: () {
                                    isLiked
                                        ? DBServices().removeLike(data.songId!)
                                        : DBServices().likeSong(data.songId!);
                                  },
                                  isUserUpload: widget.userUploads,
                                  status: data.status.toString(),
                                  isAdmin: widget.isAdmin,
                                  songId: data.songId ?? '',
                                  title: data.title,
                                  singer: data.singer,
                                  writer: data.writer,
                                  category: data.category,
                                  uploadedDate: data.uploadedDate,
                                  imageUrl: data.imageUrl,
                                ),
                              ),
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
                  )),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: StreamBuilder<List<SongModel>>(
                stream: widget.isAdmin
                    ? DBServices().streamAdminSongsData()
                    : widget.isFavoriteSongs == true
                        ? DBServices().streamMyLikedSongs()
                        : DBServices()
                            .streamUsersSongsData(widget.categoryTitle),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.requireData.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.requireData[index];
                        bool isLiked = data.likedBy!.contains(userID.value);
                        return GestureDetector(
                          onTap: () async {
                            isAudioLoading.value = true;
                            final playlist = PlayerService()
                                .buildAudios(snapshot.requireData);
                            await PlayerService().buildPlayer(player, playlist,
                                initialIndex: index);
                          },
                          child: MusicContainer(
                            isLiked: isLiked,
                            onLike: () {
                              isLiked
                                  ? DBServices().removeLike(data.songId!)
                                  : DBServices().likeSong(data.songId!);
                            },
                            isUserUpload: widget.userUploads,
                            status: data.status.toString(),
                            isAdmin: widget.isAdmin,
                            songId: data.songId ?? '',
                            title: data.title,
                            singer: data.singer,
                            writer: data.writer,
                            category: data.category,
                            uploadedDate: data.uploadedDate,
                            imageUrl: data.imageUrl,
                          ),
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
            ),
      bottomNavigationBar: Obx(
        () => isPlaying.value ? const PlayerUi() : const SizedBox(),
      ),
    );
  }
}
