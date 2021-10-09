import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_autocomplete/src/screens/display_information_screen.dart';
import '../blocs/application_bloc.dart';
import '../models/place.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  static const routeName = '/map';
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  StreamSubscription boundsSubscription;
  final _locationController = TextEditingController();
  LatLng _pickedLocation;
  String _location;
  double _latitude;
  double _longitude;

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected Location
    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _location = _locationController.text.toString();
        _goToPlace(place);
      } else
        _locationController.text = "";
    });

    applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    _locationController.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();
    super.dispose();
  }

  void _selectLocation(LatLng position) {
    setState(
      () {
        _pickedLocation = position;
        _latitude = position.latitude;
        _longitude = position.longitude;
        _readableAdress(position);
      },
    );
  }

//change latitude and longitude to readable city name
  Future<void> _readableAdress(LatLng position) async {
    _latitude = position.latitude;
    _longitude = position.longitude;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(_latitude, _longitude);
    Placemark placeMark = placemarks[0];
    _location = "${placeMark.locality}, ${placeMark.country}";
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
        body: (applicationBloc.currentLocation == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _locationController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'Search by City',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => applicationBloc.searchPlaces(value),
                      onTap: () => applicationBloc.clearSelectedLocation(),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 300.0,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              applicationBloc.currentLocation.latitude,
                              applicationBloc.currentLocation.longitude,
                            ),
                            zoom: 10,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController.complete(controller);
                          },
                          onTap: _selectLocation,
                          markers: _pickedLocation == null
                              ? {}
                              : {
                                  Marker(
                                      markerId: MarkerId('m1'),
                                      position: _pickedLocation),
                                },
                          //markers: Set<Marker>.of(applicationBloc.markers),
                        ),
                      ),
                      if (applicationBloc.searchResults != null &&
                          applicationBloc.searchResults.length != 0)
                        Container(
                            height: 300.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.6),
                                backgroundBlendMode: BlendMode.darken)),
                      if (applicationBloc.searchResults != null)
                        Container(
                          height: 300.0,
                          child: ListView.builder(
                              itemCount: applicationBloc.searchResults.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    applicationBloc
                                        .searchResults[index].description,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    applicationBloc.setSelectedLocation(
                                        applicationBloc
                                            .searchResults[index].placeId);
                                  },
                                );
                              }),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      child: Text('Add car'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          DisplayInformationScreen.routName,
                          arguments: {
                            'location': _location,
                            'latitude': _latitude,
                            'longitude': _longitude,
                          },
                        );
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text('Find Nearest',
                  //       style: TextStyle(
                  //           fontSize: 25.0, fontWeight: FontWeight.bold)),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Wrap(
                  //     spacing: 8.0,
                  //     children: [
                  //       FilterChip(
                  //         label: Text('Campground'),
                  //         onSelected: (val) => applicationBloc.togglePlaceType(
                  //             'campground', val),
                  //         selected: applicationBloc.placeType == 'campground',
                  //         selectedColor: Colors.blue,
                  //       ),
                  //       FilterChip(
                  //           label: Text('Locksmith'),
                  //           onSelected: (val) => applicationBloc
                  //               .togglePlaceType('locksmith', val),
                  //           selected: applicationBloc.placeType == 'locksmith',
                  //           selectedColor: Colors.blue),
                  //       FilterChip(
                  //           label: Text('Pharmacy'),
                  //           onSelected: (val) => applicationBloc
                  //               .togglePlaceType('pharmacy', val),
                  //           selected: applicationBloc.placeType == 'pharmacy',
                  //           selectedColor: Colors.blue),
                  //       FilterChip(
                  //           label: Text('Pet Store'),
                  //           onSelected: (val) => applicationBloc
                  //               .togglePlaceType('pet_store', val),
                  //           selected: applicationBloc.placeType == 'pet_store',
                  //           selectedColor: Colors.blue),
                  //       FilterChip(
                  //           label: Text('Lawyer'),
                  //           onSelected: (val) =>
                  //               applicationBloc.togglePlaceType('lawyer', val),
                  //           selected: applicationBloc.placeType == 'lawyer',
                  //           selectedColor: Colors.blue),
                  //       FilterChip(
                  //           label: Text('Bank'),
                  //           onSelected: (val) =>
                  //               applicationBloc.togglePlaceType('bank', val),
                  //           selected: applicationBloc.placeType == 'bank',
                  //           selectedColor: Colors.blue),
                  //     ],
                  //   ),
                  // )
                ],
              ));
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 14.0),
      ),
    );
  }
}
