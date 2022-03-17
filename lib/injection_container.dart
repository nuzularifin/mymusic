import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mymusic/core/network/dio_service.dart';
import 'package:mymusic/feature/home/data/datasource/songs_remote_data_source.dart';
import 'package:mymusic/feature/home/data/repository/song_repository_impl.dart';
import 'package:mymusic/feature/home/domain/repository/song_repository.dart';
import 'package:mymusic/feature/home/domain/usecase/get_song_list_usecase.dart';
import 'package:mymusic/feature/home/presentation/bloc/home_music_bloc.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => HomeMusicBloc(getSongListUsecase: sl()));

  //! Usecase Injection
  sl.registerLazySingleton(() => GetSongListUsecase(songRepository: sl()));

  //! Datasource Injection
  sl.registerLazySingleton<SongsRemoteDataSource>(
      () => SongsRemoteDataSourceImpl(dioService: sl()));

  //! Repository Injection
  sl.registerLazySingleton<SongRepository>(
      () => SongRepositoryImpl(networkInfo: sl(), songsRemoteDataSource: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DioService());
  sl.registerLazySingleton(() => AudioPlayer(mode: PlayerMode.MEDIA_PLAYER));
}
