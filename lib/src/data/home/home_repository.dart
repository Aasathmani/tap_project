import 'package:tap_project/src/application/model/bonds_model.dart';
import 'package:tap_project/src/data/home/home_service.dart';

class HomeRepository {
  static HomeRepository? instance;
  final HomeService homeService;

  HomeRepository({required this.homeService});

  Future<BondsResponse?> getBondsList() async {
    final response = await homeService.fetchBondsList();
    return _toBondsResponse(response.data);
  }

  BondsResponse _toBondsResponse(Map<String, dynamic> json) {
    return BondsResponse.fromJson(json);
  }
}
