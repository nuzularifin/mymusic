import 'package:dartz/dartz.dart';
import 'package:mymusic/core/error/failure.dart';
import 'package:mymusic/feature/home/domain/entities/song.dart';

abstract class SongRepository {
  Future<Either<Failure, List<Song>>> getSongList(String term);
}
