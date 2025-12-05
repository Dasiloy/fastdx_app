import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/services/services.dart';
import 'package:fastdx_app/providers/providers.dart';

part "home_controller.dart";

class CustomerHomeScreen extends ConsumerStatefulWidget {
  const CustomerHomeScreen({super.key});
  @override
  ConsumerState<CustomerHomeScreen> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          children: [
            Text("Customer home screen"),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                kFireAuth.signOut();
                ref.read(appProvider.notifier).clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
