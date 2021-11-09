import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:new_app/core/errors/failures.dart';
import 'package:new_app/core/services/network/endpoints.dart';
import 'package:new_app/core/services/network/network.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/modules/product-place/models/places.dart';
import '../../../../core/utils/http_extension.dart';

import 'package:geocoding/geocoding.dart';

class GeolocationService {
  final http.Client client;
  final NetworkInfo networkInfo;
  GeolocationService({this.networkInfo, this.client});

  Future<dynamic> getAutocomplete(
      {String input, LatLng currentLocation, int radius}) async {
    if (!await networkInfo.isConnected) throw NetworkFailure();

    final response = await http.get(Uri.parse(Endpoints.getAutocompleteByInput
        .path(input: input, latLng: currentLocation, radius: radius)));

    if (!response.isSuccess)
      throw ServerFailure(message: 'Something went wrong');

    var data = jsonDecode(response.body);

    var results = data['predictions'] as List;

    return results.map((json) => Places.fromJson(json)).toList();
  }

  Future<dynamic> getPlacesByLatLng(double lat, double lng) async {
    if (!await networkInfo.isConnected) throw NetworkFailure();

    return await placemarkFromCoordinates(lat, lng);
  }

  Future<LatLng> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    return LatLng(position.latitude, position.longitude);
  }

  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }
}
