import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mymusic/core/error/exception.dart';
import 'package:mymusic/core/network/dio_service.dart';
import 'package:mymusic/core/network/enpoint_variable.dart';
import 'package:mymusic/feature/home/domain/entities/result.dart';

import '../model/song_model.dart';

abstract class SongsRemoteDataSource {
  Future<List<SongModel>> getSongsList(String search);
}

class SongsRemoteDataSourceImpl extends SongsRemoteDataSource {
  final DioService dioService;

  SongsRemoteDataSourceImpl({required this.dioService});

  @override
  Future<List<SongModel>> getSongsList(String search) async {
    try {
      dioService.settingLog();
      var response = await dioService.dio.get(EndpointVariable.searchSong,
          queryParameters: {"term": search, "country": 'US', "media": "music"});

      if (response.statusCode == 200) {
        Result responseData = Result.fromJson(jsonDecode(response.data));
        List<SongModel> songModelList = [];
        if (responseData.result!.isNotEmpty) {
          for (var data in responseData.result!) {
            songModelList.add(SongModel.fromJson(data.toJson()));
          }
        }
        return songModelList;
      } else {
        throw ServerException(
            code: response.statusCode ?? 404,
            errorMessage: response.statusMessage ?? 'Unknown error');
      }
    } on DioError catch (e) {
      throw ServerException(code: 504, errorMessage: e.message);
    }
  }
}
