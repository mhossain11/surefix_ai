import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source)async{
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file =await _imagePicker.pickImage(source: source);

  if(_file != null){
    return await _file.readAsBytes();
  }
  print('No Images Selected');
}



Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}


class Base64CircleAvatar extends StatelessWidget {
  final String base64Image;

  Base64CircleAvatar({required this.base64Image});

  @override
  Widget build(BuildContext context) {
    // Ensure the Base64 string has correct padding
    Uint8List decodedBytes = base64Decode(addBase64Padding(base64Image));

    return CircleAvatar(
      radius: 50, // Adjust the radius as needed
      backgroundImage: MemoryImage(decodedBytes),
    );
  }

  // Helper function to add padding if necessary
  String addBase64Padding(String base64String) {
    while (base64String.length % 4 != 0) {
      base64String += '=';
    }
    return base64String;
  }
}
