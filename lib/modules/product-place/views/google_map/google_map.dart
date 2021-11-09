import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/utils/snackbar_utils.dart';
import 'package:new_app/modules/product-place/models/places.dart';
import 'package:new_app/modules/product-place/views/controller/google_map_controller.dart';

import '../../../../locator.dart';

class GoogleMapView extends StatefulWidget {
  final Function(String) callback;

  const GoogleMapView({this.callback});
  @override
  _GoogleMapViewState createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  Completer<GoogleMapController> controller;

  static LatLng _initialPosition;
  final Set<Marker> _markers = {};
  static LatLng _lastMapPosition = _initialPosition;
  final TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<Places> _placesOnInput = [];
  List<String> _placesOnTap = [];
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus)
        setState(() => _hasInput = true);
      else
        setState(() {
          _hasInput = false;
        });
    });

    sl<GeolocationService>().requestPermission().then((value) {
      if (value == LocationPermission.always ||
          value == LocationPermission.whileInUse)
        return sl<GeolocationService>()
            .getCurrentPosition()
            .then((value) => setState(() {
                  _initialPosition = value;
                }));

      SnackUtil.showInfo(
          context: context,
          message: 'Enable Location Permission for application');
    });
  }

  _onAddMarkerButtonPressed(LatLng position) {
    _focusNode.unfocus();
    _markers.clear();
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: position,
          infoWindow:
              InfoWindow(title: "Pizza Parlour", snippet: "This is a snippet"),
          onTap: () {},
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _initialPosition == null
          ? Container(
              child: Center(
                child: Text(
                  'Loading map...',
                  style: TextStyle(
                      fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                ),
              ),
            )
          : Container(
              child: Stack(
                children: [
                  _hasInput
                      ? Container(
                          margin: EdgeInsets.only(top: 80.h),
                          height: _height,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (_, i) => GestureDetector(
                              onTap: () {
                                _searchController.text = _placesOnTap[i];
                                _focusNode.unfocus();
                                setState(() {
                                  _hasInput = false;
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.all(15.sp),
                                  color: Colors.white,
                                  child: Text(_placesOnTap[i],
                                      style: TextStyle(fontSize: 13.sp))),
                            ),
                            separatorBuilder: (_, __) => Divider(),
                            itemCount: _placesOnTap.length,
                          ),
                        )
                      : GoogleMap(
                          markers: _markers,
                          initialCameraPosition: CameraPosition(
                              target: _initialPosition, zoom: 15),
                          zoomGesturesEnabled: true,
                          onTap: (LatLng position) {
                            findPlaceByTap(position);
                            print(_placesOnTap);
                            _onAddMarkerButtonPressed(position);
                          },
                          myLocationButtonEnabled: false,
                          myLocationEnabled: true,
                          compassEnabled: true,
                        ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 100.h,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h, bottom: 10.h),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back,
                                color: Colors.black, size: 20.sp),
                            onPressed: () {
                              widget.callback(_searchController.text);
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 15.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  !_hasInput
                                      ? BoxShadow(
                                          color: Colors.black38,
                                          spreadRadius: 3,
                                          blurRadius: 10)
                                      : BoxShadow(),
                                ],
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      onChanged: (String val) {
                                        if (val.length > 1)
                                          findPlaceByInput(val);
                                        widget.callback(val);
                                      },
                                      onSubmitted: (String val) {
                                        widget.callback(val);
                                        Navigator.pop(context);
                                      },
                                      controller: _searchController,
                                      focusNode: _focusNode,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        prefixIcon: Icon(Icons.search,
                                            color: AppColors.darkGrey,
                                            size: 20.sp),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                  _hasInput
                                      ? IconButton(
                                          icon: Icon(Icons.close, size: 20.sp),
                                          onPressed: () {
                                            setState(() => _hasInput = false);
                                            _searchController.clear();
                                          },
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(width: 10.w)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future findPlaceByInput(String placeName) async {
    if (_initialPosition == null) return;

    var results = await sl<GeolocationService>().getAutocomplete(
        input: placeName,
        currentLocation: _initialPosition,
        radius: 2000) as List;

    setState(() => _placesOnInput = results);
  }

  Future findPlaceByTap(LatLng position) async {
    print(position);
    List<Placemark> results = await sl<GeolocationService>()
        .getPlacesByLatLng(position.latitude, position.longitude);

    List streets = results.map((el) => el.street).toList();
    setState(() => _placesOnTap = streets);
  }
}
