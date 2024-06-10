part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {

  const LocationEvent();
  
}

class OnNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;
  const OnNewUserLocationEvent(this.newLocation);
}

class OnStartFollowingUser extends LocationEvent {}
class OnStopFollowingUser extends LocationEvent {}