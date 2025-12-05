import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:fastdx_app/widgets/widgets.dart';
import "package:fastdx_app/dtos/dtos.dart";
import 'package:fastdx_app/services/services.dart';
import 'package:fastdx_app/helpers/helpers.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/models/models.dart';

part 'register_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      formKey: _key,
      title: "Sign Up",
      showBackButton: true,
      description: "Please sign up to get started",
      children: [
        Input(
          label: "Name",
          autocorrect: false,
          initialValue: data.name,
          textInputAction: TextInputAction.go,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(hintText: "John Doe"),
          onSaved: (name) {
            data.name = name;
          },
          validator: validateName,
        ),
        SizedBox(height: 24),
        Input(
          label: "Email",
          autocorrect: false,
          initialValue: data.email,
          textInputAction: TextInputAction.go,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(hintText: "example@gmail.com"),
          onSaved: (email) {
            data.email = email;
          },
          validator: validateEmail,
        ),
        SizedBox(height: 24),
        Input(
          isPassword: true,
          label: "Password",
          autocorrect: false,
          controller: _passwordController,
          textInputAction: TextInputAction.go,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(hintText: "Password"),
          onSaved: (password) {
            data.password = password;
          },
          validator: validatePassword,
        ),
        SizedBox(height: 24),
        Input(
          isPassword: true,
          label: "Re-Type Password",
          autocorrect: false,
          initialValue: data.email,
          textInputAction: TextInputAction.go,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: "Confirm Password"),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: (confirmPassword) {
            data.confirmPassword = confirmPassword;
          },
          validator: validateConfirmPassword,
        ),
        SizedBox(height: 24),
        RoleSelector(
          selectedRole: data.role,
          onSelected: (role) {
            setState(() {
              data.role = role;
            });
          },
        ),
        SizedBox(height: 40),
        PrimaryButton(
          label: "SIGN UP",
          onPressed: _onRegister,
          isLoading: _loading,
        ),
      ],
    );
  }
}
