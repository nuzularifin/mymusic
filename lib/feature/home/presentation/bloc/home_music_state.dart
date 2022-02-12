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
}
