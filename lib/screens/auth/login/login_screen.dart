import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:fastdx_app/widgets/widgets.dart';
import 'package:fastdx_app/models/models.dart';
import "package:fastdx_app/screens/screens.dart";
import "package:fastdx_app/dtos/dtos.dart";
import "package:fastdx_app/services/services.dart";
import "package:fastdx_app/helpers/helpers.dart";
import 'package:fastdx_app/providers/providers.dart';
part 'login_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      formKey: _key,
      title: "Log In",
      showBackButton: false,
      description: "Please sign in to your existing account",
      children: [
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
          textInputAction: TextInputAction.go,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: "Password"),
          onSaved: (password) {
            data.password = password;
          },
          validator: validatePassword,
        ),
        SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            AppCheckBox(
              isChecked: data.rememberMe,
              label: "Remember me",
              onCheck: (check) {
                setState(() {
                  data.rememberMe = check ?? false;
                });
              },
            ),
            AppTextButton(
              label: "Forgot Password",
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return ForgotPasswordScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 24),
        PrimaryButton(
          label: "LOG IN",
          isLoading: _loading,
          onPressed: _onLogin,
        ),
        SizedBox(height: 38),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Dont have an account?",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(width: 6),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 5),
              child: AppTextButton(
                label: "SIGN UP",
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return RegisterScreen();
                      },
                    ),
                  );
                },
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),

        SizedBox(height: 27),
        Text(
          "Or",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        SizedBox(height: 15),
        Row(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (final social in SocialLogin.socials)
              SocialButton(social: social),
          ],
        ),
      ],
    );
  }
}
