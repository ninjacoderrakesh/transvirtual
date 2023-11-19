import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitial());
  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      emit(ConnectivityConnected('Mobile'));
    } else if (connectivityResult == ConnectivityResult.wifi) {
      emit(ConnectivityConnected('WiFi'));
    } else {
      emit(ConnectivityDisconnected());
    }
  }
}
