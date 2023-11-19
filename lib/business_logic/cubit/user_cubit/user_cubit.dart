import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/di/di.dart';
import '../../../data/models/base/user_data/user_data.dart';
import '../../../data/source/local/my_shared_preferences.dart';
import '../../../data/source/local/my_shared_preferences_keys.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserData?> {
  UserCubit() : super(null);

  void loadUserData() async {
      print(true);
      final userData = UserData(
        transVirtualNumber:
        sl<MySharedPref>()
            .getString(key: MySharedKeys.transVirtualNumber),
        currentClientName:
        sl<MySharedPref>()
            .getString(key: MySharedKeys.currentClientName),
        warehouseTitle:
        sl<MySharedPref>()
            .getString(key: MySharedKeys.warehouseTitle),
        currentUserShortName:
        sl<MySharedPref>()
            .getString(key: MySharedKeys.currentUserShortName),
      );
      emit(userData);
  }
}
