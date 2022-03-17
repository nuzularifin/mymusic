part of 'home_music_bloc.dart';

abstract class HomeMusicState extends Equatable {
  const HomeMusicState();

  @override
  List<Object> get props => [];
}

class HomeMusicInitial extends HomeMusicState {}

class HomeMusicLoading extends HomeMusicState {}

class HomeMusicEmptyList extends HomeMusicState {}

class HomeMusicError extends HomeMusicState {
  final String message;

  const HomeMusicError({required this.message});
}

class HomeMusicLoaded extends HomeMusicState {
  final List<Song> song;

  const HomeMusicLoaded({required this.song});

  @override
  List<Object> get props => [song];
}

class SelectedSongState extends HomeMusicState {
  final Song currentSong;
  final List<Song> listSong;

  const SelectedSongState({required this.currentSong, required this.listSong});

  @override
  List<Object> get props => [currentSong, listSong];
}

class PlayMusicState extends HomeMusicState {
  final Song currentSong;
  final List<Song> currentSongList;

  const PlayMusicState(
      {required this.currentSong, required this.currentSongList});

  @override
  List<Object> get props => [currentSong, currentSongList];
}

class PauseMusicState extends HomeMusicState {
  final Song currentSong;

  const PauseMusicState({required this.currentSong});

  @override
  List<Object> get props => [
        currentSong,
      ];
}
