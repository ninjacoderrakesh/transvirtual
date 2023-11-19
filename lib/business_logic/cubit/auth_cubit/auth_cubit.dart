import 'package:flutter/material.dart';
import 'package:transvirtual/data/models/base/auth/request.dart';
import 'package:transvirtual/data/models/base/user_data/user_data.dart';

import '../../../data/repository/login_repository/login_repository.dart';
import '../../../data/source/local/my_shared_preferences_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/di/di.dart';
import '../../../data/models/responses/auth_model/auth_model.dart';
import '../../../data/source/local/my_shared_preferences.dart';
import '../../../data/source/network/api_result_handler.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  Auth auth = Auth();
  UserData userData = UserData();

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    LoginRequest request = LoginRequest(
        username: email,
        password: password,
        deviceDetails: DeviceDetails(
            deviceManufacturer: "Google",
            deviceName: "sdk_gphone64_x86_64",
            versionSource: "com.transvirtual.wms.android",
            deviceSerial: "b0db5ab296890c26",
            currentVersion: 109,
            fcmToken:
                "fuKOZnIiSAapdq0XerDl6J:APA91bFoso8Ynr_ArGKi1MlYzB0N_K1KdpUo_7M6oLlMwwlbXAyER_6-VUe1ysLaEn-wRL4y6_sdUrNqjTsw3AVmBMi-J9duKU8qpS8ziReebl_LDUA4pHCYutz9hGwg7YfQZHXZPzzN"));
    ApiResults apiResults =
        await LoginRepository().createLoginData(request);
    if (apiResults is ApiSuccess) {
      print("pass");

      handleLoginResponse(apiResults.data);
    } else if (apiResults is ApiFailure) {
      print("fail");
      emit(LoginFailureState(apiResults.message));
    }
  }

  void handleLoginResponse(json) {
    userData = UserData.fromJson(json);
    if (userData.success!) {
      sl<MySharedPref>()
          .putString(key: MySharedKeys.apiToken, value: userData.jwtToken);
      sl<MySharedPref>()
          .putString(key: MySharedKeys.transVirtualNumber, value: userData.transVirtualNumber);
      sl<MySharedPref>()
          .putString(key: MySharedKeys.currentClientName, value: userData.currentClientName);
      sl<MySharedPref>()
          .putString(key: MySharedKeys.warehouseTitle, value: userData.warehouseTitle);
      sl<MySharedPref>()
          .putString(key: MySharedKeys.currentUserShortName, value: userData.currentUserShortName);
       emit(LoginSuccessState());
    } else {
      emit(LoginFailureState(auth.status.title.en));
    }
  }
}
