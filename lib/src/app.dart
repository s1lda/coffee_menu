import 'package:flutter/material.dart';
import 'package:coffee_menu/src/menu/menu_screencoffee.dart';
import 'package:coffee_menu/src/theme/theme.dart';
class CoffeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop',
      theme: coffeeAppTheme,
      home: CoffeeHomePage(),
    );
  }
}