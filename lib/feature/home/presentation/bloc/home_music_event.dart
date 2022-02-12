part of 'home_music_bloc.dart';

abstract class HomeMusicEvent extends Equatable {
  const HomeMusicEvent();

  @override
  List<Object> get props => [];
}

class GetAllSongsEvent extends HomeMusicEvent {
  final String term;

  const GetAllSongsEvent({required this.term});
}
