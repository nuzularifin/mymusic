import 'package:equatable/equatable.dart';

class Song extends Equatable {
  final String artistName;
  final String collectionName;
  final String trackName;
  final String artistViewUrl;
  final String collectionViewUrl;
  final String trackViewUrl;
  String previewUrl;
  final String artworkUrl30;
  final String artworkUrl60;
  final int trackTimeMillis;

  bool isSelected = false;
  bool isPlay = false;
  Duration selectedDuration = const Duration();
  Duration selectedPosition = const Duration();

  Song(
      {required this.artistName,
      required this.collectionName,
      required this.trackName,
      required this.artistViewUrl,
      required this.collectionViewUrl,
      required this.trackViewUrl,
      required this.previewUrl,
      required this.artworkUrl30,
      required this.artworkUrl60,
      required this.trackTimeMillis});

  @override
  List<Object?> get props => [
        artistName,
        collectionName,
        trackName,
        artistViewUrl,
        collectionViewUrl,
        trackViewUrl,
        previewUrl,
        artworkUrl30,
        artworkUrl60,
        trackTimeMillis
      ];

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
