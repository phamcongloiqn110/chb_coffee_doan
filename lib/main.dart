import 'package:flutter/material.dart';
import './app_screens/home.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Raleway'),
    debugShowCheckedModeBanner: false,
    home: Home(),
  )
);
