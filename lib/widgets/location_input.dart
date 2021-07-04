import 'package:flutter/material.dart';
// import 'package:great_place_app/helpers/location_helper.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function selectCurrentLocation;

  const LocationInput(this.selectCurrentLocation);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // String? _previewImageUrl;
  double? _lat;
  double? _long;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    // final staticMapImageUrl = LocationHelper.getLocationPreviewImage(
    //   long: locData.longitude as double,
    //   lat: locData.latitude as double,
    // );
    setState(() {
      _lat = locData.latitude;
      _long = locData.longitude;
      // _previewImageUrl = staticMapImageUrl;
    });
    widget.selectCurrentLocation(locData.latitude, locData.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            child: (_lat == null || _long == null)
                ? Text(
                    'No Location Chosen',
                    textAlign: TextAlign.center,
                  )
                : Text(
                    'latitude: $_lat, longitude: $_long',
                    textAlign: TextAlign.center,
                  )
            // Image.network(
            //     _previewImageUrl as String,
            //     fit: BoxFit.cover,
            //     width: double.infinity,
            //   ),
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current location'),
            ),
            // TextButton.icon(
            //   onPressed: () {},
            //   icon: Icon(Icons.map),
            //   label: Text('Select on map'),
            // ),
          ],
        )
      ],
    );
  }
}
