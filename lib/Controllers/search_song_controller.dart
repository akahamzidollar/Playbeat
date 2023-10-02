import 'package:get/get.dart';
import 'package:playbeat/Models/song_model.dart';
import 'package:playbeat/Services/db_services.dart';

class SearchSongController extends GetxController {
  final Rxn<List<SongModel>> _songs = Rxn<List<SongModel>>();
  List<SongModel>? get songs => _songs.value;

  @override
  void onInit() {
    _songs.bindStream(Stream.fromFuture(DBServices().getAllSongsForSearch()));
    super.onInit();
  }
}

class SongSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchSongController());
  }
}
