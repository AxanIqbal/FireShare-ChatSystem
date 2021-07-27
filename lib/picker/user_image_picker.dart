import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key, required this.imagePickFunc})
      : super(key: key);
  final void Function(PickedFile pickedImage) imagePickFunc;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  PickedFile? _pickedImage;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final _pickedImageFile = await _picker.getImage(source: ImageSource.camera);
    print(_pickedImageFile!.path);
    setState(() {
      _pickedImage = _pickedImageFile;
    });
    widget.imagePickFunc(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _pickedImage != null
              ? (kIsWeb
                  ? NetworkImage(_pickedImage!.path)
                  : FileImage(File(_pickedImage!.path))
                      as ImageProvider<Object>)
              : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text("Add Image"),
        )
      ],
    );
  }
}
