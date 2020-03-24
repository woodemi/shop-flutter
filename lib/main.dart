import 'package:flutter/material.dart';
import 'package:shopflutter/ShopPage.dart';
import 'package:shopflutter/public.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  loadDeafultData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShopPage(),
    );
  }
}