import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLogin {
  final Color color;
  final IconData icon;

  SocialLogin({required this.color, required this.icon});

  static List<SocialLogin> get socials {
    return [
      SocialLogin(color: Color(0xFF395998), icon: FontAwesomeIcons.facebookF),
      SocialLogin(color: Color(0xFF169CE8), icon: FontAwesomeIcons.google),
      SocialLogin(color: Color(0xFF1B1F2F), icon: Icons.apple),
    ];
  }
}
