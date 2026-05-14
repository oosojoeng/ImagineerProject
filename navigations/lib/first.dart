import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key, required this.name});
  final String name;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstPage'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('back'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            Text(name),
          ],
        ),
      ),
    );
  }
}
