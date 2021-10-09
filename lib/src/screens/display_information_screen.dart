import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DisplayInformationScreen extends StatelessWidget {
  static const routName = '/display_information';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final location = routeArgs['location'];
    final latitude = routeArgs['latitude'];
    final longitude = routeArgs['longitude'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Display'),
      ),
      body: Column(
        children: [
          Form(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: location),
                ),
                Container(
                  height: 300.0,
                  child: GoogleMap(
                    mapType: MapType.hybrid,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(latitude,
                        longitude),
                      zoom: 10,
                    ),
                    // onMapCreated: (GoogleMapController controller) {
                    //   _mapController.complete(controller);
                    // },
                    // onTap: _selectLocation,
                    // markers: _pickedLocation == null
                    //     ? {}
                    //     : {
                    //         Marker(
                    //             markerId: MarkerId('m1'),
                    //             position: _pickedLocation),
                    //       },
                    //markers: Set<Marker>.of(applicationBloc.markers),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: Text('Back'),
                    onPressed: () {
                      
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
