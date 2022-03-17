import 'package:mymusic/feature/home/data/model/song_model.dart';
import 'package:mymusic/feature/home/domain/entities/song.dart';

class Result {
  int? resultCount;
  List<Song>? result;

  Result({this.resultCount, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    resultCount = json['resultCount'];
    if (json['results'] != null) {
      result = <SongModel>[];
      json['results'].forEach((v) {
        result!.add(SongModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resultCount'] = resultCount;
    if (result != null) {
      data['result'] =
          result!.map((v) => SongModel.fromJson(v.toJson())).toList();
    }
    return data;
  }
}
