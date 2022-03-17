import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mymusic/feature/home/domain/entities/song.dart';
import 'package:mymusic/feature/home/domain/usecase/get_song_list_usecase.dart';

part 'home_music_event.dart';
part 'home_music_state.dart';

class HomeMusicBloc extends Bloc<HomeMusicEvent, HomeMusicState> {
  final GetSongListUsecase getSongListUsecase;
  final AudioPlayer audioPlayer;

  HomeMusicBloc({required this.getSongListUsecase, required this.audioPlayer})
      : super(HomeMusicInitial()) {
    on<GetAllSongsEvent>((event, emit) async {
      emit(HomeMusicLoading());
      final data =
          await getSongListUsecase(GetSongListParams(search: event.term));
      data.fold(
          (failure) =>
              {emit(const HomeMusicError(message: 'Unexpected error occured'))},
          (successResponse) => {emit(HomeMusicLoaded(song: successResponse))});
    });

    on<SelectSongToPlayEvent>((event, emit) async {
      //? checking selected song before to set selected false;
      event.selectedSong.isSelected = true;
      int index =
          event.songs.indexWhere((element) => element.isSelected == true);
      if (index != -1) {
        event.selectedSong.isSelected = false;
      }
      emit(SelectedSongState(
          currentSong: event.selectedSong, listSong: event.songs));
    });

    on<PlayTheMusicEvent>((event, emit) async {
      // check before play has song played or not
      int index = event.songs.indexWhere((element) => element.isPlay == true);
      if (index != -1) {
        event.songs[index].isPlay = false;
      }
      event.selectedSong.isPlay = true;
      print('Start Player');

      emit(PlayMusicState(
          currentSong: event.selectedSong, currentSongList: event.songs));
    });

    on<PauseTheMusicEvent>((event, emit) async {
      event.selectedSong.isPlay = false;

      print('Pause Player');
      emit(PauseMusicState(
        currentSong: event.selectedSong,
      ));
    });
  }
}
