import 'package:flutter/material.dart';
import 'package:device_features/Widgets/image_input.dart';
import 'dart:io';
import 'package:device_features/Providers/great_places.dart';
import 'package:provider/provider.dart';
import 'package:device_features/Widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  void _selectImage( File pickedImage) {
    _pickedImage = pickedImage;
  }
  void _savePlace() {
    if(_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context,listen: false).addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Add a New Place',
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      label: Text('title'),
                    ),
                    controller: _titleController,
                  ),
                  SizedBox(height: 10),
                  ImageInput(_selectImage),
                  SizedBox(height: 10),
                  LocationInput(),
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,

            icon: Icon(Icons.add),
            label: Text('Add A Place'),
          )
        ],
      ),
    );
  }
}
