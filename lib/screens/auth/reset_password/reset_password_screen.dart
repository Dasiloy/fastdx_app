import "package:flutter/material.dart";

import "package:fastdx_app/widgets/otp_input.dart";
import "package:fastdx_app/widgets/widgets.dart";
import 'package:fastdx_app/helpers/helpers.dart';

import "package:fastdx_app/screens/auth/login/login_screen.dart";

part "reset_password_controller.dart";

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      formKey: _key,
      showBackButton: true,
      title: 'Verification',
      headerLabel: Text(
        widget.email,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      description: 'We have sent a code to your email',
      children: [
        Row(
          children: [
            Text(
              "CODE",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            Spacer(),
            Expanded(
              child: Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _countDown.start();
                    },
                    child: Text(
                      "Resend",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  if (_time > 0)
                    Text(
                      "in $_time sec",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.8),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.5),
        PinInput(),
        const SizedBox(height: 30),
        PrimaryButton(label: "VERIFY", onPressed: _onVerifyOtp),
      ],
    );
  }
}
