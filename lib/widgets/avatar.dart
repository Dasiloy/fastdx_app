import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String? image;
  final void Function()? onPress;

  const Avatar({
    super.key,
    required this.size,
    this.onPress,
    this.image = "assets/images/avatar.jpg",
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 1,
              spreadRadius: 0.5,
              offset: const Offset(0, 1.5),
              blurStyle: BlurStyle.normal,
            ),
          ],
          image: DecorationImage(image: AssetImage(image!), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
