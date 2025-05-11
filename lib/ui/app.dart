import 'package:flutter/material.dart';
import 'package:myeg_flutter_test/ui/pages/productList.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProductListPage(),
    );
  }
}
