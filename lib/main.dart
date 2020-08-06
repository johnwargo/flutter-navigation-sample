import 'package:flutter/material.dart';
import './pages/home.dart';

void main() {
  // Have to call this otherwise we get binding errors
//  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String appName = 'Flutter Navigation';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(appName: appName),
      debugShowCheckedModeBanner: false,
    );
  }
}
