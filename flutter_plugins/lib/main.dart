import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});
  final String? title;

  @override
  State<MyHomePage> createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ToastContext().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toast plugin example app'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => showToast("Show Short Toast"),
                  child: const Text('Show Short Toast'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => showToast(
                    "Show Long Toast",
                    duration: Toast.lengthLong,
                  ),
                  child: const Text('Show Long Toast'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => showToast(
                    "Show Bottom Toast",
                    gravity: Toast.bottom,
                  ),
                  child: const Text('Show Bottom Toast'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => showToast(
                    "Show Center Toast",
                    gravity: Toast.center,
                  ),
                  child: const Text('Show Center Toast'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => showToast(
                    "Show Top Toast",
                    gravity: Toast.top,
                  ),
                  child: const Text('Show Top Toast'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(
      msg,
      duration: duration ?? Toast.lengthShort,
      gravity: gravity ?? Toast.bottom,
    );
  }
}