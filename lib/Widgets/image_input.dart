import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  //const ImageInput({Key? key}) : super(key: key);
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
   File? _storedImage;

  Future<void> _takePicture() async {
     final imageFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 600, imageQuality: 90);
     if(imageFile == null) {
       return;
     }
     setState(() {
       _storedImage =  File(imageFile!.path);
     });
     //Navigator.pop(context);
     final appDir = await syspaths.getApplicationDocumentsDirectory();
     String relativePath = '/' + DateTime.now().millisecondsSinceEpoch.toString()
                                                       + path.basename(imageFile!.path);
     String newPath = '${appDir.path}' + relativePath;

     //final fileName = path.basename(imageFile!.path);
     final savedImage = await File(imageFile!.path).copy('$newPath');
     widget.onSelectImage(savedImage) ;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container( child: _storedImage != null ? Image.file(_storedImage!,fit: BoxFit.cover,width: double.infinity,)
            :  Text('No Image Taken',),
          height: 100,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(width: 1.5,color: Colors.black54) ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera_alt),
              label: Text('Take a Picture'),
               ),
        )
      ],
    );
  }
}
