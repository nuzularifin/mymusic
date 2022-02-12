import 'package:mymusic/feature/home/domain/entities/song.dart';

class Result {
  int? resultCount;
  List<Song>? result;

  Result({this.resultCount, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    resultCount = json['resultCount'];
    if (json['results'] != null) {
      result = <Song>[];
      json['results'].forEach((v) {
        result!.add(Song.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resultCount'] = resultCount;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
