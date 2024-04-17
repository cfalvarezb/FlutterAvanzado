part of 'map_bloc.dart';

class MapState extends Equatable {

  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyroute;

  // Polylines
  final Map<String, Polyline> polylines;

  const MapState({
    this.isMapInitialized = false, 
    this.isFollowingUser = true,
    this.showMyroute = true,
    Map<String, Polyline>? polylines
  }): polylines = polylines ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showMyroute,
    Map<String, Polyline>? polylines
  }) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    showMyroute: showMyroute ?? this.showMyroute,
    polylines: polylines ?? this.polylines,
  );

  @override
  List<Object> get props => [ isMapInitialized, isFollowingUser, showMyroute, polylines ];

}
