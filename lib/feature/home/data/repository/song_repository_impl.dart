import 'package:mymusic/core/error/exception.dart';
import 'package:mymusic/core/network/network_info.dart';
import 'package:mymusic/feature/home/data/datasource/songs_remote_data_source.dart';
import 'package:mymusic/feature/home/domain/entities/song.dart';
import 'package:mymusic/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mymusic/feature/home/domain/repository/song_repository.dart';

class SongRepositoryImpl extends SongRepository {
  final NetworkInfo networkInfo;
  final SongsRemoteDataSource songsRemoteDataSource;

  SongRepositoryImpl(
      {required this.networkInfo, required this.songsRemoteDataSource});

  @override
  Future<Either<Failure, List<Song>>> getSongList(String term) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await songsRemoteDataSource.getSongsList(term));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.errorMessage));
      }
    } else {
      return const Left(ServerFailure(message: 'No Internet Connection'));
    }
  }
}
