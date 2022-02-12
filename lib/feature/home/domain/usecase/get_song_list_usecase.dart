import 'package:mymusic/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:mymusic/core/usecases/usecases.dart';
import 'package:mymusic/feature/home/domain/entities/song.dart';
import 'package:mymusic/feature/home/domain/repository/song_repository.dart';

class GetSongListUsecase extends UseCase<List<Song>, GetSongListParams> {
  final SongRepository songRepository;

  GetSongListUsecase({required this.songRepository});

  @override
  Future<Either<Failure, List<Song>>> call(GetSongListParams params) async {
    return await songRepository.getSongList(params.search);
  }
}

class GetSongListParams {
  final String search;

  GetSongListParams({required this.search});
}
