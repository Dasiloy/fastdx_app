import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/widgets/widgets.dart';

part "edit_profile_controller.dart";

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() {
    return _State();
  }
}

class _State extends _EditProfileController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            AvatarUploader(),
            const SizedBox(height: 24),
            Input(
              label: "Full Name",
              autocorrect: false,
              // initialValue: data.name,
              textInputAction: TextInputAction.go,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(hintText: "Vishal Khadok"),
              // onSaved: (name) {
              //   data.name = name;
              // },
              // validator: validateName,
            ),
            const SizedBox(height: 24),
            Input(
              label: "Email",
              autocorrect: false,
              // initialValue: data.email,
              textInputAction: TextInputAction.go,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(hintText: "hello@halallab.co"),
              // onSaved: (email) {
              //   data.email = email;
              // },
              // validator: validateEmail,
            ),
            const SizedBox(height: 24),
            Input(
              label: "Phone Number",
              autocorrect: false,
              // initialValue: data.name,
              textInputAction: TextInputAction.go,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.phone,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(hintText: "408-841-0926"),
              // onSaved: (name) {
              //   data.name = name;
              // },
              // validator: validateName,
            ),
            const SizedBox(height: 24),
            Input(
              label: "Bio",
              autocorrect: true,
              maxLines: 5,
              // initialValue: data.name,
              textInputAction: TextInputAction.go,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(hintText: "Vishal Khadok"),
              // onSaved: (name) {
              //   data.name = name;
              // },
              // validator: validateName,
            ),
            const SizedBox(height: 48),
            PrimaryButton(label: "SIGN UP", onPressed: () {}, isLoading: false),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
