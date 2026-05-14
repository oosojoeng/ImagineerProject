import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> lapTimes = []; // 랩 타임을 기록할 변수
  Stopwatch watch = Stopwatch(); // 지속적으로 시간이 지나가는 변수
  String elapsedTime = '00:00:00:000'; // 경과시간을 기록하는 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StopWatch'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                elapsedTime,
                style: const TextStyle(fontSize: 25),
              ),
            ),
            Container(
              width: 100,
              height: 200,
              child: ListView(
                children: lapTimes.map((time) => Text(time)).toList(),
              ),
            ),
            Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      if (!watch.isRunning) {
                        startWatch();
                      } else {
                        stopWatch();
                      }
                    },
                    child: !watch.isRunning
                        ? const Icon(Icons.play_arrow)
                        : const Icon(Icons.stop),
                  ),

                  FloatingActionButton(
                    onPressed: () {
                     if (!watch.isRunning) {
                       resetWatch();
                     }else{
                       recordLapTime(elapsedTime);
                      }
                    },
                    child: !watch.isRunning
                        ? const Text('Reset')
                        : const Text('Lap'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String transTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String secondStr = (seconds % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String milliStr = (milliseconds % 1000).toString().padLeft(3, '0');

    return "$hoursStr:$minutesStr:$secondStr:$milliStr";
  }

  void updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transTime(watch.elapsedMilliseconds);
      });
    }
  }

  void startWatch() {
    watch.start();
    Timer.periodic(const Duration(milliseconds: 100), updateTime);
  }

  void stopWatch() {
    setState(() {
      watch.stop();
    });
  }

  void resetWatch() {
      watch.reset();
      setTime();
      lapTimes.clear();

  }

  void setTime(){
    var timeFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transTime(timeFar);
    });
  }

  void recordLapTime(String time) {
    setState(() {
      lapTimes.insert(0, 'Lab ${lapTimes.length + 1} $time');
    });
  }
}