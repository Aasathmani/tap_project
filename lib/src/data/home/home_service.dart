import 'package:dio/dio.dart';
import 'package:tap_project/src/core/app_constants.dart';

class HomeService {
  final Dio _dio = Dio();

  Future<Response> fetchBondsList() async {
    try {
      const String baseUrl = ApiEndPoints.bondsListApi;
      final response = await _dio.get(baseUrl);
      if(response.statusCode==200) {
        return response;
      }
      else{
        throw Exception('Failed to fetch bonds list');
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to fetch weather: ${e.response?.statusMessage.toString()}',
      );
    }
  }
}
