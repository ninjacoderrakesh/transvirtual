import '../../../data/di/di.dart';
import '../../../data/source/network/api_result_handler.dart';

import '../../models/base/auth/request.dart';
import '../../source/network/endpoints.dart';
import '../../source/network/my_dio.dart';

class LoginRepository {
  Future<ApiResults> createLoginData(
      LoginRequest request
  ) async {
    print("request ${request.toJson()}");
    return await sl<MyDio>().postData(endPoint: loginEP, data: request.toJson());
  }
}
