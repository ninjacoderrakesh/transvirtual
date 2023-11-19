import 'package:transvirtual/business_logic/cubit/auth_cubit/auth_cubit.dart';
import 'package:transvirtual/business_logic/cubit/connectivity/connectivity_cubit.dart';
import '../data/source/local/my_shared_preferences.dart';
import '../router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'business_logic/cubit/home_cubit/home_cubit.dart';
import 'business_logic/cubit/observer.dart';
import 'business_logic/cubit/time_cubit/time_cubit.dart';
import 'business_logic/cubit/user_cubit/user_cubit.dart';
import 'data/di/di.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await sl<MySharedPref>().initSP();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<HomeCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<TimeCubit>(),
        ),
        BlocProvider(
          create: (context) => UserCubit()..loadUserData(),
        ),
        BlocProvider(
          create: (context) =>  sl<ConnectivityCubit>(),
        )
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: sl<AppRouter>().onGenerateRoute,
          );
        },
      ),
    );
  }
}
