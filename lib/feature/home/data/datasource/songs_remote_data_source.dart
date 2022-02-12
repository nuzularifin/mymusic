import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mymusic/core/network/dio_service.dart';
import 'package:mymusic/core/network/enpoint_variable.dart';
import 'package:mymusic/core/usecases/exceptions.dart';
import 'package:mymusic/feature/home/domain/entities/result.dart';
import 'package:mymusic/feature/home/domain/entities/song.dart';

abstract class SongsRemoteDataSource {
  Future<List<Song>> getSongsList(String search);
}

class SongsRemoteDataSourceImpl extends SongsRemoteDataSource {
  final DioService dioService;

  SongsRemoteDataSourceImpl({required this.dioService});

  @override
  Future<List<Song>> getSongsList(String search) async {
    try {
      dioService.settingLog();
      var response = await dioService.dio.get(EndpointVariable.searchSong,
          queryParameters: {"term": search, "country": 'US', "media": "music"});

      if (response.statusCode == 200) {
        Result responseData = Result.fromJson(jsonDecode(response.data));
        List<Song> data = [];
        if (responseData.result!.isNotEmpty) {
          data.addAll(responseData.result!);
        }
        return data;
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }
}
