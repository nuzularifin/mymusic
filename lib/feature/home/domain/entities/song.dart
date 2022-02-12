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

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
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


// {
//   "resultCount": 50,
//   "result": [
//     {
//       "wrapperType": "track",
//       "kind": "song",
//       "artistId": 109572,
//       "collectionId": 1440839098,
//       "trackId": 1440839325,
//       "artistName": "Jadakiss",
//       "collectionName": "Top 5 Dead or Alive",
//       "trackName": "Jason (feat. Swizz Beatz)",
//       "collectionCensoredName": "Top 5 Dead or Alive",
//       "trackCensoredName": "Jason (feat. Swizz Beatz)",
//       "artistViewUrl": "https://music.apple.com/us/artist/jadakiss/109572?uo=4",
//       "collectionViewUrl": "https://music.apple.com/us/album/jason-feat-swizz-beatz/1440839098?i=1440839325&uo=4",
//       "trackViewUrl": "https://music.apple.com/us/album/jason-feat-swizz-beatz/1440839098?i=1440839325&uo=4",
//       "previewUrl": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/a5/a4/c9/a5a4c9f5-e59d-7cf5-4acc-a613e304c440/mzaf_17219420307478574105.plus.aac.p.m4a",
//       "artworkUrl30": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/d6/20/9b/d6209b19-50b7-7dd2-e095-9d5cd4cf642a/source/30x30bb.jpg",
//       "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/d6/20/9b/d6209b19-50b7-7dd2-e095-9d5cd4cf642a/source/60x60bb.jpg",
//       "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/d6/20/9b/d6209b19-50b7-7dd2-e095-9d5cd4cf642a/source/100x100bb.jpg",
//       "collectionPrice": 9.99,
//       "trackPrice": 1.29,
//       "releaseDate": "2015-10-09T12:00:00Z",
//       "collectionExplicitness": "explicit",
//       "trackExplicitness": "explicit",
//       "discCount": 1,
//       "discNumber": 1,
//       "trackCount": 18,
//       "trackNumber": 6,
//       "trackTimeMillis": 246096,
//       "country": "USA",
//       "currency": "USD",
//       "primaryGenreName": "Hip-Hop/Rap",
//       "contentAdvisoryRating": "Explicit",
//       "isStreamable": true
//     }
//   ]
// }