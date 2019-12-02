import 'package:flutter/material.dart';
import 'package:flutter_showcase_view/show_case_view.dart';
import 'package:showcaseview/showcaseview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ShowCase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ShowCaseWidget(
          builder: Builder(
              builder: (context) => ShowCasePage()
          ),
        ),
      ),
    );
  }
}
