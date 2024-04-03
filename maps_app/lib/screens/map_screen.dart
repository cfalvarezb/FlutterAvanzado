import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/location/location_bloc.dart';

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
    // TODO: implement dispose
    locationBloc.close();
    super.dispose();
  }

  @override
  Widget build( BuildContext context ) {

    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(builder: ( context, state ){
        
        if ( state.lastKnownLocation == null ) return const Center( child: Text('Espere por favar...'), );
        return Container(
          alignment: Alignment.center,
          child: Text('${state.lastKnownLocation!.latitude}, ${ state.lastKnownLocation!.longitude }'),
        );
      })
    );

  }
}