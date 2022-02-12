import 'package:dio/dio.dart';
import 'package:mymusic/core/utils/global_variables.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService {
  final Dio dio = Dio();

  settingLog() {
    dio.interceptors.clear();
    dio.interceptors.add(PrettyDioLogger(
        error: GlobalVariables.appDebug,
        request: GlobalVariables.appDebug,
        requestBody: GlobalVariables.appDebug,
        requestHeader: GlobalVariables.appDebug,
        responseBody: GlobalVariables.appDebug,
        responseHeader: GlobalVariables.appDebug,
        compact: GlobalVariables.appDebug,
        maxWidth: 500));

    dio.options = BaseOptions(
        baseUrl: GlobalVariables.baseUrlProd,
        connectTimeout: GlobalVariables.connectTimeOutRequest,
        receiveTimeout: GlobalVariables.connectTimeOutRequest,
        sendTimeout: GlobalVariables.connectTimeOutRequest,
        headers: settingHeaders());

    return dio;
  }

  static Map<String, dynamic> settingHeaders() {
    Map<String, dynamic> headersDefault = {
      "apps-version": GlobalVariables.appVersion,
      "apps-origin": GlobalVariables.appOriginCourier,
      "ClientKey": GlobalVariables.clientKey,
      "Content-Type": 'application/json',
      "ContentType": 'application/json',
    };
    return headersDefault;
  }

  static Map<String, dynamic> settingHeadersWithBearer(String bearerToken) {
    Map<String, dynamic> headersDefault = {
      "apps-version": GlobalVariables.appVersion,
      "apps-origin": GlobalVariables.appOriginCourier,
      "ClientKey": GlobalVariables.clientKey,
      "Authorization": "Bearer " + bearerToken,
      "Content-Type": 'application/json',
      "ContentType": 'application/json',
    };
    return headersDefault;
  }
}
