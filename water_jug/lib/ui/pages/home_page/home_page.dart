import 'package:flutter/material.dart';
import 'package:water_jug/ui/pages/home_page/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const SingleChildScrollView(
        child: HomePageBody(),
      ),
    );
  }
}
