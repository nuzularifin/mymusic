import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mymusic/feature/home/domain/entities/song.dart';
import 'package:mymusic/feature/home/domain/usecase/get_song_list_usecase.dart';

part 'home_music_event.dart';
part 'home_music_state.dart';

class HomeMusicBloc extends Bloc<HomeMusicEvent, HomeMusicState> {
  final GetSongListUsecase getSongListUsecase;

  HomeMusicBloc({required this.getSongListUsecase})
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
  }
}
