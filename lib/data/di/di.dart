import '../../business_logic/cubit/auth_cubit/auth_cubit.dart';
import '../../business_logic/cubit/connectivity/connectivity_cubit.dart';
import '../../business_logic/cubit/home_cubit/home_cubit.dart';
import '../../business_logic/cubit/time_cubit/time_cubit.dart';
import '../../business_logic/cubit/user_cubit/user_cubit.dart';
import '../../data/source/local/my_shared_preferences.dart';
import '../../data/source/network/my_dio.dart';
import '../../router/app_router.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<MyDio>(
    () => MyDio(),
  );
  sl.registerLazySingleton<MySharedPref>(
    () => MySharedPref(),
  );
  sl.registerLazySingleton<AppRouter>(
    () => AppRouter(),
  );
  sl.registerLazySingleton<HomeCubit>(
    () => HomeCubit(),
  );
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(),
  );
  sl.registerFactory<TimeCubit>(
    () => TimeCubit(),
  );
  sl.registerFactory<UserCubit>(
    () => UserCubit(),
  );
  sl.registerFactory<ConnectivityCubit>(
    () => ConnectivityCubit(),
  );
}
