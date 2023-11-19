import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  late Timer _timer;
  TimeCubit() : super(TimeState(currentTime: _getCurrentTime())) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateCurrentTime();
    });
  }

  static String _getCurrentTime() {
    return DateFormat('HH:mm a').format(DateTime.now());
  }

  void updateCurrentTime() {
    emit(TimeState(currentTime: _getCurrentTime()));
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
