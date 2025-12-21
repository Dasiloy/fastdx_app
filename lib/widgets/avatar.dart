import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final ImageProvider? image;
  final bool showShadow;
  final void Function()? onPress;

  const Avatar({
    super.key,
    this.onPress,
    required this.size,
    this.showShadow = true,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 1,
                    spreadRadius: 0.5,
                    offset: const Offset(0, 1.5),
                    blurStyle: BlurStyle.normal,
                  ),
                ]
              : null,
          image: DecorationImage(
            image: image ?? const AssetImage("assets/images/avatar.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
