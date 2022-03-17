part of 'home_music_bloc.dart';

abstract class HomeMusicEvent extends Equatable {
  const HomeMusicEvent();

  @override
  List<Object> get props => [];
}

class GetAllSongsEvent extends HomeMusicEvent {
  final String term;

  const GetAllSongsEvent({required this.term});

  @override
  List<Object> get props => [term];
}

class SelectSongToPlayEvent extends HomeMusicEvent {
  final Song selectedSong;
  final List<Song> songs;

  const SelectSongToPlayEvent(
      {required this.selectedSong, required this.songs});

  @override
  List<Object> get props => [selectedSong, songs];
}

class PlayTheMusicEvent extends HomeMusicEvent {
  final Song selectedSong;
  final List<Song> songs;

  const PlayTheMusicEvent({required this.selectedSong, required this.songs});

  @override
  List<Object> get props => [selectedSong, songs];
}

class PauseTheMusicEvent extends HomeMusicEvent {
  final Song selectedSong;
  final List<Song> fromList;

  const PauseTheMusicEvent(
      {required this.selectedSong, required this.fromList});
}
