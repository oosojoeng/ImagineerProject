import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondPage'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('back'),
              onPressed: (){
                Navigator.pop(context, 'ok');
              },
            )
          ],
        ),
      ),
    );
  }
}
