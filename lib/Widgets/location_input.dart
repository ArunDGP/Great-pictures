import 'package:flutter/material.dart';
import 'package:location/location.dart';
class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  Future<void> getLocation() async {
      final locData = await Location().getLocation();
      print(locData.latitude);
      print(locData.longitude);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1)
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: getLocation,
                icon: Icon(Icons.location_on),
                label: Text('Current Location'),),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.map),
                label: Text('Select On Map'))
          ],
        )
      ],
    );
  }
}
