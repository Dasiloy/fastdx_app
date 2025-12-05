import 'package:flutter/material.dart';

import 'package:fastdx_app/models/social_model.dart';

class SocialButton extends StatelessWidget {
  final SocialLogin social;
  const SocialButton({super.key, required this.social});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: social.color,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: AlignmentGeometry.center,
        child: Icon(social.icon, color: Colors.white),
      ),
    );
  }
}
