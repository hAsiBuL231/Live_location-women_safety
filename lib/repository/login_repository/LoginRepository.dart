import 'package:flutter_track_live/.data/network/network_api_services.dart';
import 'package:flutter_track_live/.resources/app_url/AppUrl.dart';

class LoginRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    dynamic response = _apiServices.postApi(data, AppUrl.loginUrl);
    return response;
  }
}
