import "dart:io";

import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";

class AvatarUploader extends StatefulWidget {
  const AvatarUploader({super.key});

  @override
  State<AvatarUploader> createState() {
    return _State();
  }
}

class _State extends State<AvatarUploader> {
  File? _file;

  Future<void> _onPickImage() async {
    final imagePicker = ImagePicker();

    final xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      final newFile = File(xFile.path);
      if (mounted) {
        await precacheImage(FileImage(newFile), context);
      }
      setState(() {
        _file = newFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        image: _file != null
            ? DecorationImage(fit: BoxFit.cover, image: FileImage(_file!))
            : null,
        shape: BoxShape.circle,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -3,
            right: 10,
            child: GestureDetector(
              onTap: _onPickImage,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
