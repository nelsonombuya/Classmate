import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  Future<LatLng?> getUserLatLng() async {
    Location location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return null;
      }
    }

    if (await location.hasPermission() == PermissionStatus.denied) {
      if (await location.requestPermission() != PermissionStatus.granted) {
        return null;
      }
    }

    return await location
        .getLocation()
        .then((value) => LatLng(value.latitude!, value.longitude!));
  }

  Future<LatLng?> getUserLatLngWithTimeout(Duration? duration) async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        await Geolocator.openLocationSettings();
        return null;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(timeLimit: duration)
          .then((value) => LatLng(value.latitude, value.longitude));
    } on TimeoutException catch (error) {
      this.addError(error);
      return await Geolocator.getLastKnownPosition().then(
        (value) =>
            value == null ? null : LatLng(value.latitude, value.longitude),
      );
    }
  }
}
