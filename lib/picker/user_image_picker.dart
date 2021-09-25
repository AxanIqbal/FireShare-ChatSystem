import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key, required this.imagePickFunc})
      : super(key: key);
  final void Function(File pickedImage) imagePickFunc;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    var _pickedImageFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = File(_pickedImageFile!.path);
    });
    widget.imagePickFunc(_pickedImage!);
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
          icon: const Icon(Icons.image),
          label: const Text("Add Image"),
        )
      ],
    );
  }
}
