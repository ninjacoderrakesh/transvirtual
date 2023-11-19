part of 'connectivity_cubit.dart';

@immutable
abstract class ConnectivityState {}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {
  final String source;

  ConnectivityConnected(this.source);
}

class ConnectivityDisconnected extends ConnectivityState {}