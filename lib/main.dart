import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:riverpod_sample_crud_operation/model/list_model.dart';
import 'package:riverpod_sample_crud_operation/view/splash_screen/splash.dart';

void main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ListModelAdapter().typeId)) {
    Hive.registerAdapter(ListModelAdapter());
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
