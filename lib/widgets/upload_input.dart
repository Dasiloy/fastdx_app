import "dart:io";

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import "package:dotted_border/dotted_border.dart";

import "package:fastdx_app/helpers/helpers.dart";
import "package:fastdx_app/theme/theme.dart";

class UploadInput extends StatefulWidget {
  final double tileHeight;
  final double labelGap;

  final String? label;
  final String? imageUrl;
  final File? file;
  final String placeholder;
  final void Function(File file)? onUpload;

  const UploadInput({
    super.key,
    this.label,
    this.imageUrl,
    this.file,
    this.labelGap = 8,
    this.tileHeight = 160,
    this.placeholder = "Pick Image",
    this.onUpload,
  });

  @override
  State<UploadInput> createState() => _UploadInputState();
}

class _UploadInputState extends State<UploadInput> {
  bool isFirstTime = true;
  late ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  void _onPickImage() async {
    final xFile = await _picker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      setState(() {
        isFirstTime = false;
        widget.onUpload?.call(File(xFile.path));
      });
    }
  }

  Widget get _child {
    if (isFirstTime && widget.imageUrl != null) {
      return GestureDetector(
        onTap: _onPickImage,
        child: Image.network(
          widget.imageUrl!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    if (widget.file == null) {
      return IconButton(
        onPressed: () {
          _onPickImage();
        },
        icon: Icon(
          Icons.cloud_upload_outlined,
          size: 40,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(89),
        ),
      );
    }

    return GestureDetector(
      onTap: _onPickImage,
      child: Image.file(
        widget.file!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Utils.isLightMode(context);
    final bgColor = isLight ? AppColors.bgLight : AppColors.bgDark;
    final borderColor = isLight ? AppColors.borderLight : AppColors.borderDark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w400,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: widget.labelGap),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: DottedBorder(
              options: RectDottedBorderOptions(
                color: borderColor,
                strokeWidth: 3,
                dashPattern: [4, 6],
                strokeCap: StrokeCap.round,
              ),
              child: Container(
                color: bgColor,
                width: double.infinity,
                height: widget.tileHeight,
                child: _child,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
