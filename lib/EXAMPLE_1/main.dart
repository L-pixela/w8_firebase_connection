import 'package:flutter/material.dart';
import 'package:flutter_rest_api/EXAMPLE_1/screen/app_screen.dart';
import 'package:provider/provider.dart';

import 'repository/firebase_repo/firebase_fruit_repository.dart';
import 'repository/fruit_repository.dart';
import 'screen/provider/fruit_providerd.dart';

// MAIN
void main() async {
  final FruitRepository fruitRepository = FirebaseFruitRepository();

  runApp(
    ChangeNotifierProvider(
      create: (context) => FruitProvider(fruitRepository),
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: const AppScreen()),
    ),
  );
}
