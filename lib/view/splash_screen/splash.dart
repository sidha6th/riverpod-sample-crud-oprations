

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample_crud_operation/controller/home_controller.dart';
import 'package:riverpod_sample_crud_operation/view/home_screen/screen_home.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder(
        future: ref.read(homeNotifier.notifier).getAllData(),
        builder: (_,snapshot){
          return snapshot.connectionState==ConnectionState.done?const HomeScreen():
        const SizedBox();
        }),
    );
  }
}
