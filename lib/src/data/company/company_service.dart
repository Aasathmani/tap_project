import 'package:dio/dio.dart';
import 'package:tap_project/src/core/app_constants.dart';

class CompanyService {
  final Dio _dio = Dio();

  Future<Response> fetchCompanyDetails() async {
    try {
      const String baseUrl = ApiEndPoints.companyDetailsApi;
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to company details');
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to fetch company details: ${e.response?.statusMessage.toString()}',
      );
    }
  }
}
