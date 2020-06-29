import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/OrderDetail.dart';
import 'widget/main_app.dart';
void main() => runApp(
  ChangeNotifierProvider(create: (context) => OrderDetail(),
  child: MainApp(),)
);
