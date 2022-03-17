import 'package:mymusic/feature/home/domain/entities/song.dart';

class SongModel extends Song {
  SongModel(
      {required String artistName,
      required String collectionName,
      required String trackName,
      required String artistViewUrl,
      required String collectionViewUrl,
      required String trackViewUrl,
      required String previewUrl,
      required String artworkUrl30,
      required String artworkUrl60,
      required int trackTimeMillis})
      : super(
            artistName: artistName,
            collectionName: collectionName,
            trackName: trackName,
            artistViewUrl: artistViewUrl,
            collectionViewUrl: collectionViewUrl,
            trackViewUrl: trackViewUrl,
            previewUrl: previewUrl,
            artworkUrl30: artworkUrl30,
            artworkUrl60: artworkUrl60,
            trackTimeMillis: trackTimeMillis);

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
        artistName: json['artistName'],
        collectionName: json['collectionName'],
        trackName: json['trackName'],
        artistViewUrl: json['artistViewUrl'],
        collectionViewUrl: json['collectionViewUrl'],
        trackViewUrl: json['trackViewUrl'],
        previewUrl: json['previewUrl'],
        artworkUrl30: json['artworkUrl30'],
        artworkUrl60: json['artworkUrl60'],
        trackTimeMillis: json['trackTimeMillis']);
  }

  Map<String, dynamic> toJson() {
    return {
      'artistName': artistName,
      'collectionName': collectionName,
      'trackName': trackName,
      'artistViewUrl': artistViewUrl,
      'collectionViewUrl': collectionViewUrl,
      'trackViewUrl': trackViewUrl,
      'previewUrl': previewUrl,
      'artworkUrl30': artworkUrl30,
      'artworkUrl60': artworkUrl60,
      'trackTimeMillis': trackTimeMillis
    };
  }
}
