import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:form_field_validator/form_field_validator.dart";

import "package:fastdx_app/widgets/widgets.dart";
import "package:fastdx_app/helpers/helpers.dart";
import "package:fastdx_app/services/services.dart";

part 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      formKey: _key,
      title: "Forgot Password",
      showBackButton: true,
      description: "start the process of recovering your account",
      children: [
        Input(
          label: "Email",
          autocorrect: false,
          initialValue: _email,
          textInputAction: TextInputAction.go,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(hintText: "example@gmail.com"),
          onSaved: (email) {
            _email = email!;
          },
          validator: validateEmail,
        ),
        SizedBox(height: 30),
        PrimaryButton(
          label: "SEND CODE",
          isLoading: _loading,
          onPressed: _onForgotPassword,
        ),
      ],
    );
  }
}
