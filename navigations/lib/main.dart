import 'package:flutter/material.dart';
import 'package:navigations/second.dart';
import 'first.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage')
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('FirstPage'),
              onPressed: ()async{
                final name = 'flutter';

                final res = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstPage(name: 'flutter',))
                );
              },
            ),
            ElevatedButton(
              child: Text('SecondPage'),
              onPressed: ()async{
                final res = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage())
                );
                print(res);
              },
            ),

          ],
        ),
      ),
    );
  }
}
