import 'package:flutter/material.dart';

class ManualScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('앱 설명'),
      ),
      body: Center(
        child: Text('앱 설명 화면'),
      ),
    );
  }
}
