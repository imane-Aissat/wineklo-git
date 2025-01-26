import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Sen Font Example')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'This is Regular',
                style: TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w400, fontSize: 20),
              ),
              Text(
                'This is Medium',
                style: TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Text(
                'This is Semi Bold',
                style: TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                'This is Bold',
                style: TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w700, fontSize: 20),
              ),
              Text(
                'This is ExtraBold',
                style: TextStyle(fontFamily: 'Sen', fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

