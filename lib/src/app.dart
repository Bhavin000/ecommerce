import 'package:ecommerce/src/routes/app_routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eCommerce',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes().onGenerateRoute,
    );
  }
}
