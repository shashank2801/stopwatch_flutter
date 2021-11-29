import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Stopwatch App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  int _countSeconds = 0;
  Duration timeDuration = Duration.zero;
  bool _timerRunning = false;

  void initState() {
    super.initState();
  }

  void startTimer() {
    _timerRunning = true;
    _timer?.cancel();
    // cancels the already running timer
    _countSeconds = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countSeconds++;
        timeDuration = Duration(seconds: _countSeconds);
      });
    });
  }

  void stopTimer() {
    _timerRunning = false;
    _timer?.cancel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(30.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CircularProgressIndicator(
                    strokeWidth: 20.0,
                    value: _countSeconds.remainder(60) / 60,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timeDuration.inMinutes.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    ":",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    timeDuration.inSeconds.remainder(60).toString().padLeft(2,'0'),
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_timerRunning) {
              setState(() {
                stopTimer();
              });
            } else {
              setState(() {
                startTimer();
              });
            }
          },
          child: Icon(_timerRunning ? Icons.pause : Icons.play_arrow),
        ));
  }
}
