import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/blocs/location/location_bloc.dart';
import 'package:maps_app/blocs/map/map_bloc.dart';
import 'package:maps_app/views/views.dart';
import 'package:maps_app/widgets/btn_toggle_user_route.dart';
import 'package:maps_app/widgets/widgets.dart';

class MapScreen extends StatefulWidget {

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    //locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.close();
    super.dispose();
  }

  @override
  Widget build( BuildContext context ) {

    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(builder: ( context, locationState ){
        
        if ( locationState.lastKnownLocation == null ) {
          return const Center( child: Text('Espere par favar...'), );
        }
        
        return BlocBuilder<MapBloc, MapState>(
          builder: (context, mapState) {

            Map<String, Polyline> polylines = Map.from( mapState.polylines );
            if ( !mapState.showMyroute ) {
              polylines.removeWhere((key, value) => (key == 'myRoute' || key == 'route' ));
            }

            return SingleChildScrollView (
              child: Stack(
                children: [
                  MapView( 
                    initialLocation: locationState.lastKnownLocation!,
                    polylines: polylines.values.toSet(),
                    markers: mapState.markers.values.toSet(),
                  ),
                  const CustomSearchBar(),
                  const ManualMarker()
                ],
              ),
            );
          }
        );

      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnToggleUserRoute(),
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),
    );

  }
}